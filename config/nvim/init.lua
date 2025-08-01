vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
-- vim.o.clipboard = "unnamedplus"
vim.opt.rtp:append(vim.fn.stdpath('config') .. '/lua')

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "nvim-treesitter.configs".setup({
	ensure_installed = { "typescript", "javascript", "php", "blade" },
	highlight = { enable = true }
})
require "oil".setup()

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>')

vim.lsp.enable({ "lua_ls", "phpactor" })

require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

local gemini_key = os.getenv("GEMINI_KEY")
require('gemini').setup{api_key=gemini_key}

vim.api.nvim_create_user_command(
  "Gemini",
  function()
    require("gemini").ask_gemini()
  end,
  { nargs = 0 }
)

vim.keymap.set('n', '<leader>g', ':Gemini<CR>')
