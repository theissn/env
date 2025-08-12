vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.pack.add({
	'https://github.com/vague2k/vague.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/kdheepak/lazygit.nvim',
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/saghen/blink.cmp',
})

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

require('nvim-treesitter.configs').setup({
	auto_install = true
})

require("mason").setup()
require("mason-lspconfig").setup()
require("oil").setup()

require('blink.cmp').setup {
	fuzzy = { implementation = "lua" },
}

local map = vim.keymap.set
local builtin = require('telescope.builtin')
map('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader> ', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })

map('n', '<leader>lg', '<cmd>LazyGit<cr>')
map("n", "<leader>e", "<CMD>Oil<CR>")

map('n', '<leader>d', vim.diagnostic.open_float)
map('n', '<leader>dq', vim.diagnostic.setloclist)

map('n', '<leader>w', ':write<CR>');
map('n', '<leader>q', ':quit<CR>');
map('n', '<leader>lf', vim.lsp.buf.format)
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
