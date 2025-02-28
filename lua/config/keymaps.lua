-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local util = require("util")
local map = util.map

-- table prev and next
map("n", "<C-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<C-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- 手动删除当前缓冲区中的行尾空白字符
vim.keymap.set("n", "<leader><Space>", function()
	local save_cursor = vim.fn.getpos(".")
	vim.cmd([[%s/\s\+$//e]])
	vim.fn.setpos(".", save_cursor)
end, { desc = "Remove trailing whitespace" })

-- Replace visual selection with text in register, but not contaminate the
-- register, see also https://stackoverflow.com/q/10723700/6064933.
map("x", "p", '"_c<ESC>p')

-- close current buffer
map("", "<C-q>", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>")

-- close all plugin window
map("", "<C-C><C-C>", util.close_plugin_window, { desc = "Close all plugin windows" })

-- 转换选中字符串，然后写入粘贴板
map("v", "<leader>y", function()
    local ret = util.select_convert_case()
    vim.fn.setreg("+", ret)
    vim.fn.setreg('"', ret)
    -- Exit visual mode.
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
end, { desc = "Convert select string" })

-- toggle comment
vim.keymap.set('n', '<C-/>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-/>', 'gc', { remap = true })
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true })
