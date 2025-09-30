-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Write" })
vim.keymap.set("n", "<leader>W", ":wq<CR>", { desc = "Write and quit" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { desc = "Quit without saving" })

-- Run code based on file type with cmd+r
vim.keymap.set("n", "<D-r>", function()
  local filetype = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local cmd

  if filetype == "elixir" then
    cmd = "elixir " .. vim.fn.shellescape(file)
  elseif filetype == "python" then
    cmd = "python3 " .. vim.fn.shellescape(file)
  elseif filetype == "swift" then
    cmd = "swift " .. vim.fn.shellescape(file)
  else
    print("No run command configured for filetype: " .. filetype)
    return
  end

  Snacks.terminal(cmd, {
    win = { position = "bottom" },
    interactive = true,
    auto_close = false
  })
end, { desc = "Run current file" })
