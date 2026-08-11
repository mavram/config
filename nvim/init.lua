vim.g.mapleader = ' '

-- Enable Nerd fonts
vim.g.have_nerd_font = true

-- Show line numbers in the left margin.
vim.o.number = true

-- Show relative line numbers so motion commands (e.g. 5j) use
-- distances rather than absolute line numbers.
vim.o.relativenumber = true

-- Highlight the current line under the cursor for easier visual
-- tracking while scrolling through the buffer.
vim.o.cursorline = true

-- Enable mouse usage in all modes (normal, insert, visual, etc.)
-- so you can click, scroll, and resize panes with the mouse.
vim.o.mouse = 'a'

-- Hide the '-- INSERT --' / '-- VISUAL --' mode indicator at
-- the bottom of the screen to reduce clutter.
vim.o.showmode = false

-- Use spaces instead of literal tab characters when inserting.
vim.o.expandtab = true

-- Set the number of spaces used for one level of indentation.
vim.o.shiftwidth = 4

-- Display tab characters as this many columns wide.
vim.o.tabstop = 4

-- When pressing Tab in insert mode, insert this many spaces
-- instead of a real tab character.
vim.o.softtabstop = 4

-- Automatically indent a new line to match the indentation of
-- the previous line (useful for most programming languages).
vim.o.smartindent = true

-- When a line wraps, align the continuation lines with the
-- content of the first line rather than the window margin.
vim.o.breakindent = true

-- Disable automatic line wrapping; long lines extend beyond
-- the visible window instead of wrapping to the next line.
vim.o.wrap = true

-- Perform incremental searches in-place without splitting the
-- window, showing matches as you type the search pattern.
vim.o.inccommand = 'nosplit'

-- Enable full true-color (24-bit) support for terminals that
-- support it, enabling rich colour palettes in plugins.
vim.o.termguicolors = true

-- Keep at least this many lines of context above and below
-- the cursor while scrolling to avoid losing your place.
vim.o.scrolloff = 10

-- Highlight all occurrences of the search term as you type,
-- providing real-time feedback during searches.
vim.o.incsearch = true

-- Always display the sign column (for signs, diagnostics, etc.)
-- to prevent layout shifts when signs appear or disappear.
vim.o.signcolumn = 'yes'

-- Briefly highlight the matching bracket/parent when you type
-- the closing character of an open one.
vim.o.showmatch = true

-- Disable swap files (.swp) to avoid clutter and conflicts
-- with version-control systems like Git.
vim.o.swapfile = false
vim.o.backup = false

-- Store undo history in a file so it persists across Neovim
-- restarts; this prevents loss of undo history on exit.
vim.o.undofile = true

-- Automatically reload a file from disk when it has been
-- modified externally (e.g. by another editor or a Git hook).
vim.o.autoread = true

-- Prompt to save or discard unsaved changes when quitting or
-- switching buffers, preventing accidental data loss.
vim.o.confirm = true

-- Set a custom directory for undo file storage so that undo
-- history is persisted independently per buffer.
vim.o.undodir = vim.fn.stdpath('data') .. '/undodir'

-- Clipboard setting so that any yanked or pasted text is also available
-- in the system clipboard, enabling cross-application copy/paste.
vim.o.clipboard = 'unnamedplus'

-- Defines the style of floating windows. e.g. when hovering on types
-- for definitions
vim.o.winborder = 'rounded'

-- Controls splitting window positioning
vim.o.splitbelow = true
vim.o.splitright = true

-- Case insensitive search, and override if search patten
-- contains upper case characters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Only, and always, last window will have a status line
vim.o.laststatus = 3

-- Auto-hide command line
vim.o.cmdheight = 0

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
    -- AST plugins
    -- LSP plugins
    --{src = 'https://github.com/neovim/nvim-lspconfig'},
})

require('mini.diff').setup()
require('mini.icons').setup()
require('mini.git').setup()
require('mini.statusline').setup()
require('mini.pick').setup()

-- Formats the whole buffer by piping it through an external CLI tool on
-- stdin/stdout, keyed by filetype. No formatting plugin required.
-- brew install stylua black taplo prettier
local formatters = {
    lua = function()
        return { 'stylua', '-' }
    end,
    python = function()
        return { 'black', '-q', '-' }
    end,
    javascript = function()
        return { 'prettier', '--stdin-filepath', vim.fn.expand('%') }
    end,
    javascriptreact = function()
        return { 'prettier', '--stdin-filepath', vim.fn.expand('%') }
    end,
    typescript = function()
        return { 'prettier', '--stdin-filepath', vim.fn.expand('%') }
    end,
    typescriptreact = function()
        return { 'prettier', '--stdin-filepath', vim.fn.expand('%') }
    end,
    css = function()
        return { 'prettier', '--stdin-filepath', vim.fn.expand('%') }
    end,
    html = function()
        return { 'prettier', '--stdin-filepath', vim.fn.expand('%') }
    end,
    yaml = function()
        return { 'prettier', '--stdin-filepath', vim.fn.expand('%') }
    end,
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

-- Apply settings
vim.cmd.colorscheme('catppuccin')
