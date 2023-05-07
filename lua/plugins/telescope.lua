return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-dap.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-project.nvim" },
      { "debugloop/telescope-undo.nvim" },
      { "AckslD/nvim-neoclip.lua" },
      { "xiyaowong/telescope-emoji.nvim" },
      { "LinArcX/telescope-env.nvim" },
      { "LinArcX/telescope-ports.nvim" },
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        layout_strategy = "horizontal",
        layout_config = {
          vertical = {
            preview_cutoff = 0.2,
            preview_height = 0.4,
          },
          height = 0.9,
          width = 0.9,
        },
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
          n = {
            ["j"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["k"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["gg"] = function(...)
              return require("telescope.actions").move_to_top(...)
            end,
            ["G"] = function(...)
              return require("telescope.actions").move_to_bottom(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
        },
      },
      extensions = {
        project = {
          base_dirs = {
            "~/workspace/",
          },
        },
        undo = {
          use_delta = true,
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.4,
          },
        },
      },
    },
    keys = {
      {
        "<leader>fp",
        "<CMD>Telescope project display_type=full<CR>",
        desc = "Find project",
      },
      { "<leader>fy", "<Cmd>Telescope neoclip<CR>", desc = "neoclip" },
      { "<leader>mo", "<Cmd>Telescope emoji<CR>", desc = "emoji" },
      { "<leader>nv", "<Cmd>Telescope env<CR>", desc = "env" },
      { "<leader>po", "<Cmd>Telescope ports<CR>", desc = "ports" },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      require("neoclip").setup()
      telescope.setup(opts)
      telescope.load_extension("dap")
      telescope.load_extension("fzf")
      telescope.load_extension("project")
      telescope.load_extension("undo")
      telescope.load_extension("neoclip")
      telescope.load_extension("emoji")
      telescope.load_extension("env")
      telescope.load_extension("ports")
    end,
  },
}
