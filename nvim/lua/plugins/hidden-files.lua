return {
  -- Show hidden files in neo-tree (file browser)
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = {
            ".conductor",
            ".worktrees",
            ".nvim",
          },
        },
      },
    },
  },

  -- Show hidden files in telescope (file finder)
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "%.conductor/",
          "%.worktrees/",
          "%.nvim/",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
      },
    },
  },

  -- Show hidden files in snacks picker (space+f+f)
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = { ".conductor", ".worktrees", ".nvim" },
          },
        },
      },
    },
  },
}
