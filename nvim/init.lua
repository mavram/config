vim.g.mapleader = ' '

-- Interface
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.termguicolors = true
vim.o.scrolloff = 10
vim.o.signcolumn = 'yes'
vim.o.showmatch = true
vim.o.clipboard = 'unnamedplus'
vim.o.winborder = 'rounded'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.laststatus = 3
vim.o.cmdheight = 0

-- Indentation
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.smartindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Files and history
vim.o.swapfile = false
vim.o.undofile = true
vim.o.confirm = true
vim.o.undodir = vim.fn.stdpath('data') .. '/undodir'

-- Auto commands
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('kickstart-start-insert', { clear = true }),
    callback = function()
        vim.cmd('startinsert')
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Key bindings
-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('x', 'p', [['_dP]], { desc = 'Paste over selection WITHOUT losing yanked text' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down in buffer with cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up in buffer with cursor centered' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result cursor centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result cursor centered' })

vim.keymap.set('n', '<leader>h', ':Pick help<CR>', { desc = 'Search help tags' })
vim.keymap.set('n', '<leader>f', ':Pick files<CR>', { desc = 'Search files' })
vim.keymap.set('n', '<leader>g', ':Pick grep_live<CR>', { desc = 'Search text' })

vim.keymap.set('n', '<leader>t', ':split | terminal<CR>', { desc = 'Open terminal buffer as split (with auto-insert)' })
vim.keymap.set('t', '<leader>t', '<C-\\><C-n>:bd!<CR>', { desc = 'Escape and delete terminal buffer' })

-- Plugins
vim.pack.add({
    -- Selected mini plugins
    { src = 'https://github.com/nvim-mini/mini.diff' },
    { src = 'https://github.com/nvim-mini/mini.icons' },
    { src = 'https://github.com/nvim-mini/mini-git' },
    { src = 'https://github.com/nvim-mini/mini.statusline' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
})

require('mini.diff').setup()
require('mini.icons').setup()
require('mini.git').setup()
require('mini.statusline').setup()
require('mini.pick').setup()

-- Configure formatters
-- Formats the whole buffer by piping it through an external CLI tool on
-- stdin/stdout, keyed by filetype. No formatting plugin required.
-- brew install stylua black taplo prettier
local function prettier()
    return { 'prettier', '--stdin-filepath', vim.api.nvim_buf_get_name(0) }
end

local formatters = {
    lua = function()
        return { 'stylua', '-' }
    end,
    python = function()
        return { 'black', '-q', '-' }
    end,
    javascript = prettier,
    javascriptreact = prettier,
    typescript = prettier,
    typescriptreact = prettier,
    css = prettier,
    html = prettier,
    json = prettier,
    markdown = prettier,
    yaml = prettier,
    toml = function()
        return { 'taplo', 'format', '-' }
    end,
    go = function()
        return { 'gofmt' }
    end,
}

local function format_buffer()
    local ft = vim.bo.filetype
    local get_cmd = formatters[ft]
    if not get_cmd then
        vim.notify('No formatter configured for filetype: ' .. ft, vim.log.levels.WARN)
        return
    end

    local cmd = get_cmd()
    if vim.fn.executable(cmd[1]) == 0 then
        vim.notify('Formatter not found on PATH: ' .. cmd[1], vim.log.levels.ERROR)
        return
    end

    local view = vim.fn.winsaveview()
    local input = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n') .. '\n'
    local result = vim.system(cmd, { stdin = input, text = true }):wait()
    if result.code ~= 0 then
        vim.notify('Format failed:\n' .. (result.stderr or ''), vim.log.levels.ERROR)
        return
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result.stdout:gsub('\n$', ''), '\n'))
    vim.fn.winrestview(view)
end

vim.keymap.set('n', '<leader>lf', format_buffer, { desc = 'Format buffer' })

-- Auto-format on save
vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('autoformat_on_save', { clear = true }),
    callback = format_buffer,
})

-- Apply settings
vim.cmd.colorscheme('catppuccin')
