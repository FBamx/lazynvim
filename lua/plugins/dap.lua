return {
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
}
