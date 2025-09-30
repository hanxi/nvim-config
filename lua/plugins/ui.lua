return {
    -- theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
    },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-frappe",
        },
    },

    -- add more treesitter parsers
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        highlight = { enable = true },
        indent = { enable = false },
        opts = {
            ensure_installed = {
                "bash",
                "vimdoc",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
                "go",
                "dockerfile",
                "git_config",
                "jsdoc",
                "make",
                "toml",
                "sproto",
            },
        },
    },

    -- file tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = function()
            return {
                {
                    "<leader>t",
                    function()
                        require("neo-tree.command").execute({ toggle = true, dir = vim.fn.expand("%:p:h") })
                    end,
                    desc = "Explorer NeoTree (cwd)",
                },
            }
        end,
        opts = {
            enable_diagnostics = false,
            filesystem = {
                window = {
                    mappings = {
                        ["<space>"] = "none",
                        ["t"] = "none",
                        ["p"] = function(state)
                            local node = state.tree:get_node()
                            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                        end,
                        ["u"] = "navigate_up",
                        ["/"] = "noop",
                    },
                },
            },
        },
    },

    -- tab line
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "catppuccin/nvim",
        },
        opts = {
            options = {
                mode = "buffers", -- set to "tabs" to only show tabpages instead
                numbers = function(opts)
                    return string.format("%s", opts.raise(opts.ordinal))
                end,
                close_command = nil, -- can be a string | function, see "Mouse actions"
                right_mouse_command = nil, -- can be a string | function, see "Mouse actions"
                left_mouse_command = nil, -- can be a string | function, see "Mouse actions"
                middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
                always_show_bufferline = true,
                sort_by = "id",
                separator_style = "thin",
                enforce_regular_tabs = false,
                color_icons = true, -- whether or not to add the filetype icon highlights
                show_buffer_icons = true, -- disable filetype icons for buffers
                show_close_icon = false,
                show_buffer_close_icons = false,
                show_tab_indicators = false,
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                diagnostics = "",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "left",
                    },
                },
            },
        },
    },

    -- status line
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                -- component_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },
                section_separators = "",
                component_separators = "",
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_c = {
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
					-- stylua: ignore
					{
						function() return require("nvim-navic").get_location() end,
						cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
					},
                },
                lualine_z = { "encoding" },
            },
            extensions = {
                "quickfix",
                "fugitive",
                "nvim-tree",
            },
        },
    },

    -- disable commond line
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                bottom_search = false,
                command_palette = true,
            },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
        },
    },
}
