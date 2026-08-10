vim.g.mapleader = ' '
vim.g.have_nerd_font = true

require('config.lazy')
require('config.autocmds')
require('config.opts')
require('config.keymaps')

require('mini.diff').setup({})
require('mini.icons').setup({})
require('mini.git').setup({})
require('mini.statusline').setup({})
