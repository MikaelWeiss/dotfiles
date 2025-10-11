-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Toggle file explorer with cmd+s
vim.keymap.set("n", "<D-s>", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- Open file search with shift+cmd+o
vim.keymap.set("n", "<D-S-o>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })

-- Open terminal with shift+cmd+y
vim.keymap.set("n", "<D-S-y>", function()
  Snacks.terminal(nil, { win = { position = "bottom" } })
end, { desc = "Open terminal" })

-- Run code based on file type with cmd+r
vim.keymap.set("n", "<D-r>", function()
  local filetype = vim.bo.filetype
  local file = vim.fn.expand("%:p")

  if filetype == "swift" then
    vim.cmd("XcodebuildBuildRun")
    return
  end

  local run_cmd

  if filetype == "elixir" then
    run_cmd = "elixir " .. vim.fn.shellescape(file)
  elseif filetype == "python" then
    run_cmd = "python3 " .. vim.fn.shellescape(file)
  else
    print("No run command configured for filetype: " .. filetype)
    return
  end

  -- Run the command in a shell, then keep the shell open
  local cmd = vim.o.shell .. " -c " .. vim.fn.shellescape(run_cmd .. "; exec " .. vim.o.shell)

  Snacks.terminal(cmd, {
    win = { position = "bottom" },
    interactive = true,
    auto_close = false,
  })
end, { desc = "Run current file" })

-- Toggle comment with cmd+/
vim.keymap.set("n", "<D-/>", "gcc", { desc = "Toggle comment line", remap = true })
vim.keymap.set("v", "<D-/>", "gc", { desc = "Toggle comment selection", remap = true })
