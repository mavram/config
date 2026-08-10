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

-- Disable backup files (~) to keep the working directory clean.
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

-- Schedule clipboard sync on the main event loop so that any
-- yanked or pasted text is also available in the system
-- clipboard, enabling cross-application copy/paste.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
