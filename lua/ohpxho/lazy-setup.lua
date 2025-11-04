-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	-- Plugin manager
	"folke/lazy.nvim",

	-- Essential dependencies
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use

	-- Color scheme
	"bluz71/vim-nightfly-guicolors",

	-- Tmux & split window navigation
	"christoomey/vim-tmux-navigator",

	-- Maximizes and restores current window
	"szw/vim-maximizer",

	-- Essential plugins
	"tpope/vim-surround", -- add, delete, change surroundings
	"inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)

	-- Commenting with gc
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ohpxho.plugins.comment")
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("ohpxho.plugins.nvim-tree")
		end,
	},

	-- VS-code like icons
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("ohpxho.plugins.web-devicons")
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("ohpxho.plugins.lualine")
		end,
	},

	-- Fuzzy finding w/ telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("ohpxho.plugins.telescope")
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippets
			"hrsh7th/cmp-nvim-lsp", -- for lsp autocompletion
			"onsails/lspkind.nvim", -- vs-code like icons for autocompletion
		},
		config = function()
			require("ohpxho.plugins.nvim-cmp")
		end,
	},

	-- Managing & installing lsp servers, linters & formatters
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("ohpxho.plugins.lsp.mason")
		end,
	},

	-- Configuring lsp servers
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			require("ohpxho.plugins.lsp.lspconfig")
		end,
	},

	-- Enhanced lsp uis
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("ohpxho.plugins.lsp.lspsaga")
		end,
	},

	-- Formatting & linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ohpxho.plugins.conform")
		end,
	},

	-- Treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ohpxho.plugins.treesitter")
		end,
	},

	-- Auto closing
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("ohpxho.plugins.autopairs")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = "InsertEnter",
	},

	-- AI completion
	{
		"Exafunction/windsurf.nvim",
		config = function()
			require("ohpxho.plugins.windsurf")
		end,
	},

	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ohpxho.plugins.gitsigns")
		end,
	},
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
