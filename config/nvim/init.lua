vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"

vim.keymap.set('n', '<leader>w', ':write<CR>');
vim.keymap.set('n', '<leader>q', ':quit<CR>');
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- vim.o.mouse = "a"
-- vim.o.showmode = false
-- vim.o.clipboard = 'unnamedplus'
-- vim.o.breakindent = true
-- vim.o.undofile = true
-- vim.o.ignorecase = true
-- vim.o.smartcase = true
-- vim.o.signcolumn = "yes"
-- vim.o.updatetime = 250
-- vim.o.timeoutlen = 500
-- vim.o.splitright = true
-- vim.o.splitbelow = true
-- vim.o.list = true
-- vim.o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- vim.o.inccommand = "split"
-- vim.o.cursorline = true
-- vim.o.scrolloff = 10


vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

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
})

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

require('nvim-treesitter.configs').setup({
	auto_install = true
})

require("mason").setup()
require("mason-lspconfig").setup()
require("oil").setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader> ', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>')
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")
