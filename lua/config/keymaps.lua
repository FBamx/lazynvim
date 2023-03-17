local map = vim.keymap.set

-- vim.g.mapleader = " "

-- unset highlight
map("n", "<Esc>", ":nohl<CR>")

-- local history
map("n", "<A-h>", ":LocalHistoryToggle<CR>")

-- escape the insert mode
map("i", "jj", "<Esc>")

-- navigate within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

map("n", "x", '"_x')
map("n", "=", "<C-a>")
map("n", "-", "<C-x>")

map("n", "<C-a>", "ggVG", { silent = true })

map("i", "<M-z>", "<ESC>", { silent = true })

map("n", "<leader>nh", ":nohl<CR>", { silent = true })

-- dap
map("n", "<F1>", ":lua require 'dap'.toggle_breakpoint()<CR>")
map("n", "<F2>", ":lua require 'dap'.continue()<CR>")
map("n", "<F3>", ":lua require 'dap'.step_over()<CR>")
map("n", "<F4>", ":lua require 'dap'.step_into()<CR>")
map("n", "<F5>", ":lua require 'dap'.step_out()<CR>")
map("n", "<F6>", ":lua require 'dapui'.close()<CR>")

-- git
map("n", "<leader>rh", ":lua require 'gitsigns'.reset_hunk()<CR>")
map("n", "<leader>ph", ":lua require 'gitsigns'.preview_hunk()<CR>")
map("n", "<leader>gb", ":lua package.loaded.gitsigns.blame_line()<CR>")
map("n", "<leader>td", ":lua require 'gitsigns'.toggle_deleted()<CR>")

-- tagbar
map("n", "<A-t>", ":Tagbar<CR>")

-- commment
map("n", "<C-m>", ":lua require('Comment.api').toggle.linewise.current()<CR>")
map("v", "<C-m>", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
