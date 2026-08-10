-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<leader>t", ":split | terminal<CR>", { desc = "Open terminal buffer as split (with auto-insert)" })
vim.keymap.set("t", "<leader>t", "<C-\\><C-n>:bd!<CR>", { desc = "Escape and delete terminal buffer" })

vim.keymap.set("n", "<leader>r", function()
    vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
    print("Config reloaded!")
end, { desc = "Reload init.lua" })
