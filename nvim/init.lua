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
vim.o.wrap = true

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
        vim.wo.winhighlight = 'Normal:TermNormal'
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
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down in buffer with cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up in buffer with cursor centered' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result cursor centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result cursor centered' })

vim.keymap.set('n', '<leader>ff', ':Pick files<CR>', { desc = 'Search files' })
vim.keymap.set('n', '<leader>gg', ':Pick grep_live<CR>', { desc = 'Search text' })

vim.keymap.set('n', '<leader>tt', ':split | terminal<CR>', { desc = 'Open terminal buffer as split)' })
vim.keymap.set('t', '<leader>tt', '<C-\\><C-n>:bd!<CR>', { desc = 'Escape and delete terminal buffer' })

-- Plugins
vim.pack.add({
    { src = 'https://github.com/nvim-mini/mini.diff' },
    { src = 'https://github.com/nvim-mini/mini.icons' },
    { src = 'https://github.com/nvim-mini/mini-git' },
    { src = 'https://github.com/nvim-mini/mini.statusline' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})

require('mini.diff').setup()
require('mini.icons').setup()
require('mini.git').setup()
require('mini.statusline').setup()
require('mini.pick').setup()

-- Native LSP using server definitions from nvim-lspconfig
vim.lsp.enable({
    'tsgo',
    'eslint',
    'gopls',
    'html',
    'cssls',
    'tailwindcss',
    'pyright',
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('native-lsp', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
    end,
})

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
    sh = function()
        return { 'shfmt', '--language-dialect', 'auto', '--indent', '4', '-' }
    end,
    zsh = function()
        return { 'shfmt', '--language-dialect', 'zsh', '--indent', '4', '-' }
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

local terminal_colors = {
    '#000000',
    '#990000',
    '#00a600',
    '#999900',
    '#0000b2',
    '#b200b2',
    '#00a6b2',
    '#bfbfbf',
    '#666666',
    '#e50000',
    '#00d900',
    '#e5e500',
    '#0000ff',
    '#e500e5',
    '#00e5e5',
    '#e5e5e5',
}

for index, color in ipairs(terminal_colors) do
    vim.g['terminal_color_' .. (index - 1)] = color
end

vim.api.nvim_set_hl(0, 'TermNormal', { fg = '#00ff00', bg = '#000000' })
