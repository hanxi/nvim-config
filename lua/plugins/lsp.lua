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
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"black",
				"shfmt",
			},
		},
	},

	-- add lspconfig
	{
		"neovim/nvim-lspconfig",
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "<C-]>", vim.lsp.buf.definition, desc = "Goto definition" }
			keys[#keys + 1] = {
				"gr",
				function()
					require("telescope.builtin").lsp_references({ jump_type = "never" })
				end,
				desc = "References",
			}
		end,
		---@class PluginLspOpts
		opts = {
			diagnostics = {
				underline = false,
				virtual_text = false,
				signs = false,
				severity_sort = true,
			},
			---@type lspconfig.options
			servers = {
				gopls = {
					--memoryMode = "DegradeClosed",
				},
				lua_ls = {
					mason = false,
					enabled = false,
				},
			},
		},
	},
}
