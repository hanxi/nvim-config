# 涵曦的 neovim 配置

- 插件使用 [LazyVim](https://github.com/LazyVim/LazyVim) 管理
- 主要的插件
  - [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) 模糊搜索
 	- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) lsp 配置 c/c++, go, python, lua, bash
 	- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) 使用 tabbar 管理 buffer
 	- [catppuccin/nvim](https://github.com/catppuccin/nvim) 主题, 使用明色主题 latte
 	- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) 状态栏
 	- [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) 目录树

安装脚本见： <https://github.com/hanxi/dotfiles>

## 快捷键

- `<C-]>` lsp definition
- `<C-p>` 文件模糊搜索
- `<C-q>` 关闭 tab 页签
- `<C-c><C-c>` 连续两次 Ctrl + C 关闭所有插件窗口
- `<C-h>` `<C-l>` 切换tab页签
- `,<space>` 删除行尾空白字符
- `,t` nvim-tree 目录树
- `,/` 打开 Grep 搜索框
- `,sw` 搜索光标所在单词
- `<select>sw` 选择字符串，按sw打开搜索选择字符串
- 自动补全使用 `<Tab>` 和 `<S-Tab>` 选择候选项， `Enter` 选中
