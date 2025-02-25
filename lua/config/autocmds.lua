-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "proto", "cpp", "javascript", "sh", "bash", "lua" },
    callback = function()
        vim.b.autoformat = false
    end,
})

-- 4 个空格
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lua", "python"},
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.expandtab = true
  end,
})

-- 2 个空格
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
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
