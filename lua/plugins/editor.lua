return {
  -- customize file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      filesystem = {
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      },
    },
  },

  { "Shougo/deoplete.nvim" },

  -- { "folke/noice.nvim", enabled = false },

  {
    "christoomey/vim-tmux-navigator",
  },

  -- fold
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = false

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      require("ufo").setup({
        preview = {
          win_config = {
            border = { "", "─", "", "", "", "─", "", "" },
            winhighlight = "Normal:Folded",
            winblend = 0,
          },
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
          },
        },
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  -- neo tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = {
        mappings = {
          ["<space>"] = "none",
          ["o"] = "open",
        },
      }
    end,
  },

  -- symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },

  -- diffview (git version >= 2.31)
  {
    "sindrets/diffview.nvim",
    dependencies = { -- optional packages
      "nvim-lua/plenary.nvim",
    },
  },

  -- cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji", "onsails/lspkind.nvim" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      -- highlight groups config
      local hl_groups = {
        PmenuSel = { bg = "#282C34", fg = "NONE" },
        Pmenu = { fg = "#C5CDD9", bg = "#22252A" },
        CatppCursor = { bg = "#EABDFF", fg = "#4B4453" },
        CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE" },
        CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE" },
        CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE" },
        CmpItemMenu = { fg = "#D4BB6C", bold = true },
        CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
        CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
        CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },
        CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
        CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
        CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
        CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
        CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
        CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },
        CmpItemKindFunction = { fg = "#EADFF0", bg = "#AAAFFF" },
        CmpItemKindStruct = { fg = "#EADFF0", bg = "#AAAFFF" },
        CmpItemKindClass = { fg = "#EADFF0", bg = "#AAAFFF" },
        CmpItemKindModule = { fg = "#EADFF0", bg = "#AAAFFF" },
        CmpItemKindOperator = { fg = "#EADFF0", bg = "#AAAFFF" },
        CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
        CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },
        CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
        CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
        CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A958" },
        CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
        CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
        CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },
        CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
        CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
        CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
      }
      for group, color in pairs(hl_groups) do
        vim.api.nvim_set_hl(0, group, color)
      end
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:CatppCursor,Search:None",
          side_padding = 0,
        },
        documentation = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          side_padding = 0,
        },
      }
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 40,
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })

          kind.menu = ({
            buffer = "☄️",
            nvim_lsp = "☘️ ",
            luasnip = "🌖",
            nvim_lua = "🌙",
            latex_symbols = "📚",
          })[entry.source.name]
          -- add return types for function suggestions.
          local item = entry:get_completion_item()
          if kind.menu == nil then
            kind.menu = ""
          end
          if item.detail then
            kind.menu = "    " .. (strings[2] or "") .. kind.menu .. "✨" .. item.detail
          else
            kind.menu = "    " .. (strings[2] or "") .. kind.menu
          end

          kind.kind = " " .. (strings[1] or "") .. " "
          return kind
        end,
      }
    end,
  },

  -- colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- go nvim
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- dapui
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      icons = { expanded = "", collapsed = "", current_frame = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      expand_lines = vim.fn.has("nvim-0.7") == 1,
      layouts = {
        {
          elements = {
            "breakpoints",
            "stacks",
            { id = "scopes", size = 0.25 },
            "watches",
          },
          size = 40, -- 40 columns
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25, -- 25% of total lines
          position = "bottom",
        },
      },
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    },
  },

  -- dap
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
      },
    },
    config = function()
      require("dap").adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
      require("dap").configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "main.go",
        },
        {
          type = "delve",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
      -- start/close dapui when debugging session initialized/terminated
      require("dap").listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open({})
      end
      require("dap").listeners.before.event_terminated["dapui_config"] = function()
        require("dapui").close({})
      end
      require("dap").listeners.before.event_exited["dapui_config"] = function()
        require("dapui").close({})
      end

      require("dap").defaults.fallback.terminal_win_cmd = "enew | set filetype=dap-terminal"
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl",
        callback = function()
          require("dap.ext.autocompl").attach()
        end,
      })
      require("which-key").register({
        ["<leader>db"] = { name = "+breakpoints" },
        ["<leader>ds"] = { name = "+steps" },
        ["<leader>dv"] = { name = "+views" },
      })
    end,
    keys = {
      {
        "<leader>dbc",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional Breakpoint",
      },
      {
        "<leader>dbl",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message"))
        end,
        desc = "Logpoint",
      },
      {
        "<leader>dbr",
        function()
          require("dap.breakpoints").clear()
        end,
        desc = "Remove All",
      },
      { "<leader>dbs", "<CMD>Telescope dap list_breakpoints<CR>", desc = "Show All" },
      {
        "<leader>dbt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>de",
        function()
          require("dap.ui.widgets").hover(nil, { border = "none" })
        end,
        desc = "Evalutate Expression",
        mode = { "n", "v" },
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      { "<leader>dr", "<CMD>Telescope dap configurations<CR>", desc = "Run" },
      {
        "<leader>dsb",
        function()
          require("dap").step_back()
        end,
        desc = "Step Back",
      },
      {
        "<leader>dsc",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dsi",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dso",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dsx",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dx",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dvf",
        function()
          require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames, { border = "none" })
        end,
        desc = "Show Frames",
      },
      {
        "<leader>dvr",
        function()
          require("dap").repl.open(nil, "20split")
        end,
        desc = "Show Repl",
      },
      {
        "<leader>dvs",
        function()
          require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes, { border = "none" })
        end,
        desc = "Show Scopes",
      },
      {
        "<leader>dvt",
        function()
          require("dap.ui.widgets").centered_float(require("dap.ui.widgets").threads, { border = "none" })
        end,
        desc = "Show Threads",
      },
    },
  },

  -- toggle term
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<a-i>]],
      terminal_mappings = true,
      insert_mappings = true,
      direction = "float",
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
        "bash",
        "comment",
        "diff",
        "dockerfile",
        "dot",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "python",
        "regex",
        "vim",
        "yaml",
        "cpp",
      }
    end,
  },

  -- local history
  -- you need to install python3 and pip3 install pynvim
  -- If you see an error Not and editor command: LocalHistoryToggle you need to run :UpdateRemotePlugins
  {
    "dinhhuy258/vim-local-history",
    branch = "master",
  },
  -- customize telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-dap.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-project.nvim" },
      { "debugloop/telescope-undo.nvim" },
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        layout_strategy = "vertical",
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
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("dap")
      telescope.load_extension("fzf")
      telescope.load_extension("project")
      telescope.load_extension("undo")
    end,
  },
}
