return {
  -- make sure the textobjects module is available for treesitter
  { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.textobjects = opts.textobjects or {}
      opts.textobjects.select = opts.textobjects.select or {}
      local select = opts.textobjects.select

      select.enable = true
      if select.lookahead == nil then
        select.lookahead = true
      end

      select.keymaps = select.keymaps or {}
      local keymaps = select.keymaps

      keymaps["ab"] = keymaps["ab"] or { query = "@block.outer", desc = "Select outer block" }
      keymaps["ib"] = keymaps["ib"] or { query = "@block.inner", desc = "Select inner block" }
      keymaps["af"] = keymaps["af"] or { query = "@function.outer", desc = "Select outer function" }
      keymaps["if"] = keymaps["if"] or { query = "@function.inner", desc = "Select inner function" }

      select.keymaps = keymaps
      opts.textobjects.select = select
    end,
  },
  -- Elixir-specific textobjects for do...end blocks
  {
    "amiralies/vim-textobj-elixir",
    ft = "elixir",
    dependencies = { "kana/vim-textobj-user" },
  },
}