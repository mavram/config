vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.wrap = false



vim.opt.inccommand = "nosplit"
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.incsearch = true
vim.opt.signcolumn = "yes" 
vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.opt.autoread = true
