return {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        -- 1. 添加 sproto 到 `ensure_installed` 列表
        -- 这会让 nvim-treesitter 在启动时尝试安装 sproto
        if type(opts.ensure_installed) == "table" then
            vim.list_extend(opts.ensure_installed, { "sproto" })
        end

        -- 注册新的 parser
        if type(parsers) == "table" then
            vim.list_extend(parsers, { "sproto" })
        end

        -- 配置文件类型
        vim.filetype.add({
            extension = {
                sproto = "sproto",
            },
            pattern = {
                [".*/%.sproto$"] = "sproto",
            },
        })

        -- 2. 配置 sproto parser 的位置
        -- 这是最关键的一步
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.sproto = {
            install_info = {
                -- 指向你本地 parser 的路径
                url = "https://github.com/hanxi/tree-sitter-sproto",
                files = { "src/parser.c" },
                generate_requires_npm = false,
                requires_generate = false,
            },
            filetype = "sproto", -- 将此 parser 关联到 sproto 文件类型
            indent = { enable = true },
        }
    end,
}
