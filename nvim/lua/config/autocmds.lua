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
