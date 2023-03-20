return {
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      term_colors = true,
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
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
      italic = {
        strings = true,
        operators = true,
        comments = true
      },
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
      transparent_mode = false,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
