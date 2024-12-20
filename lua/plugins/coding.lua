return {
    {
        "axelf4/vim-strip-trailing-whitespace",
    },

    {
        "kazhala/close-buffers.nvim",
    },

	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = {
					"select_next",
					"fallback",
				},
				["<S-Tab>"] = {
					"select_prev",
					"fallback",
				},
			},
		},
	},
}
