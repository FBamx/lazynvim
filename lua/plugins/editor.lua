return {

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
      opts.close_if_last_window = true
      opts.filesystem = {
        follow_current_file = true,
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default",
      }
    end,
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
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "hrsh7th/cmp-emoji", "onsails/lspkind.nvim" },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     -- highlight groups config
  --     local hl_groups = {
  --       PmenuSel = { bg = "#282C34", fg = "NONE" },
  --       Pmenu = { fg = "#C5CDD9", bg = "#22252A" },
  --       CatppCursor = { bg = "#EABDFF", fg = "#4B4453" },
  --       CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE" },
  --       CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE" },
  --       CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE" },
  --       CmpItemMenu = { fg = "#D4BB6C", bold = true },
  --       CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
  --       CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
  --       CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },
  --       CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
  --       CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
  --       CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
  --       CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
  --       CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
  --       CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },
  --       CmpItemKindFunction = { fg = "#EADFF0", bg = "#AAAFFF" },
  --       CmpItemKindStruct = { fg = "#EADFF0", bg = "#AAAFFF" },
  --       CmpItemKindClass = { fg = "#EADFF0", bg = "#AAAFFF" },
  --       CmpItemKindModule = { fg = "#EADFF0", bg = "#AAAFFF" },
  --       CmpItemKindOperator = { fg = "#EADFF0", bg = "#AAAFFF" },
  --       CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
  --       CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },
  --       CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
  --       CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
  --       CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A958" },
  --       CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
  --       CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
  --       CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },
  --       CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
  --       CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
  --       CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
  --     }
  --     for group, color in pairs(hl_groups) do
  --       vim.api.nvim_set_hl(0, group, color)
  --     end
  --     opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
  --     opts.window = {
  --       completion = {
  --         winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:CatppCursor,Search:None",
  --         side_padding = 0,
  --       },
  --       documentation = {
  --         winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
  --         side_padding = 0,
  --       },
  --     }
  --     opts.formatting = {
  --       fields = { "kind", "abbr", "menu" },
  --       format = function(entry, vim_item)
  --         local kind = require("lspkind").cmp_format({
  --           mode = "symbol_text",
  --           maxwidth = 40,
  --           ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
  --         })(entry, vim_item)
  --         local strings = vim.split(kind.kind, "%s", { trimempty = true })
  --
  --         kind.menu = ({
  --           buffer = "☄️",
  --           nvim_lsp = "☘️ ",
  --           luasnip = "🌖",
  --           nvim_lua = "🌙",
  --           latex_symbols = "📚",
  --         })[entry.source.name]
  --         -- add return types for function suggestions.
  --         local item = entry:get_completion_item()
  --         if kind.menu == nil then
  --           kind.menu = ""
  --         end
  --         if item.detail then
  --           kind.menu = "    " .. (strings[2] or "") .. kind.menu .. "✨" .. item.detail
  --         else
  --           kind.menu = "    " .. (strings[2] or "") .. kind.menu
  --         end
  --
  --         kind.kind = " " .. (strings[1] or "") .. " "
  --         return kind
  --       end,
  --     }
  --   end,
  -- },

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
}
