return {
    -- formatters
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        opts = {
            default_format_opts = {
                timeout_ms = 3000,
                async = false, -- not recommended to change
                quiet = false, -- not recommended to change
                lsp_format = "fallback", -- not recommended to change
            },
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                sh = { "shfmt" },
                go = { "gofmt" },
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "black",
                "shfmt",
                "vtsls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            inlay_hints = {
                enabled = false,
                exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
            },
            servers = {
                vtsls = {},
                lua_ls = {
                    mason = true,
                    enabled = false,
                },
                gopls = {
                },
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        keys = {
            {
                "<C-]>",
                vim.lsp.buf.definition,
                desc = "Goto definition",
            },
        },
        opts = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            keys[#keys + 1] = { "<C-]>", vim.lsp.buf.definition, desc = "Goto definition" }

            vim.diagnostic.disable() -- 全局禁用所有诊断
        end,
    },
}
