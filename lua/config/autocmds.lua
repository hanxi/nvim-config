-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "proto", "cpp", "lua" },
    callback = function()
        vim.b.autoformat = false
    end,
})

vim.cmd('command! ProfileStart lua require("util").profile(true)')
vim.cmd('command! ProfileEnd lua require("util").profile(false)')

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md", "*.json" },
    callback = function()
        vim.cmd("set conceallevel=0")
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
    pattern = { "*.md", "*.json" },
    callback = function()
        vim.cmd("set conceallevel=3")
    end,
})
