-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Leader key
vim.g.mapleader = ","

local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fencs = "utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936"

opt.matchtime = 1
opt.updatetime = 100
opt.foldenable = false
opt.swapfile = false
opt.backup = false
opt.autoread = true
opt.autowrite = true

opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.cursorcolumn = true

opt.smarttab = true
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.cindent = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.textwidth = 120

-- clipboard
opt.clipboard = "unnamedplus"
vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
}

if vim.env.SSH_TTY then
    local function paste()
        return {
            vim.split(vim.fn.getreg(""), "\n"),
            vim.fn.getregtype(""),
        }
    end

    vim.g.clipboard.paste = {
        ["+"] = paste,
        ["*"] = paste,
    }
end
