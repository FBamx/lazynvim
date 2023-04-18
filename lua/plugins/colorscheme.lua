return {
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      term_colors = false,
      transparent_background = true,
      no_italic = false,
      no_bold = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "bold" },
        strings = {},
        variables = { "bold", "italic" },
        numbers = {},
        booleans = {},
        types = { "italic", "bold" },
        operators = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      custom_highlights = function(colors)
        return {
          ["@keyword"] = { fg = "#fca7ea", style = { "italic" } },
          ["@property"] = { fg = "#fca7ea", style = { "italic" } },
          ["@type.builtin"] = { style = { "italic" } },
        }
      end
    },
  },
  -- oxocarbon
  {
    "nyoom-engineering/oxocarbon.nvim",
    name = "oxocarbon"
  },
  -- gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    opts = {
      undercurl = true,
      underline = true,
      bold = true,
      -- italic = {
      --   strings = true,
      --   operators = true,
      --   comments = true
      -- },
      strikethrough = false,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = false,
      overrides = {
        GruvboxRedSign = { bg = "none" },
        GruvboxGreenSign = { bg = "none" },
        GruvboxYellowSign = { bg = "none" },
        GruvboxBlueSign = { bg = "none" },
        GruvboxPurpleSign = { bg = "none" },
        GruvboxAquaSign = { bg = "none" },
        GruvboxOrangeSign = { bg = "none" }
      },
      contrast = "soft",
      dim_inactive = false,
      transparent_mode = true,
    },
  },

  -- dracula
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    opts = {
      transparent_bg = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
