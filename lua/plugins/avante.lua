return {
    {
        "yetone/avante.nvim",
        build = "make",
        event = "VeryLazy",
        version = false, -- 永远不要将此值设置为 "*"！永远不要！
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            provider = "qianwen",
            providers = {
                qianwen = {
                    __inherited_from = "openai",
                    api_key_name = "DASHSCOPE_API_KEY",
                    endpoint = "https://idealab.alibaba-inc.com/api/openai/v1",
                    model = "qwen3-coder-plus",
                },
            },
            -- auto_suggestions_provider = "qianwen",
            -- behaviour = {
            --     auto_suggestions = true,
            --     enable_cursor_planning_mode = true,
            -- },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- 以下依赖项是可选的，
            "ibhagwan/fzf-lua", -- 用于文件选择器提供者 fzf
            "nvim-tree/nvim-web-devicons", -- 或 echasnovski/mini.icons
            {
                -- 如果您有 lazy=true，请确保正确设置
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
