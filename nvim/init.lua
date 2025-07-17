vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = false

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.termguicolors = false
vim.cmd.colorscheme("default")

vim.opt.cmdheight = 0

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.opt.clipboard = "unnamedplus"

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selected text to clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Copy current line to clipboard" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from clipboard before cursor" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	"tpope/vim-sleuth",
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			spec = {
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.hues").setup({
				background = "#11262d",
				foreground = "#c0c8cc",
				n_hues = 8,
				saturation = "medium",
				accent = "bg", -- Use background for accent
			})
			local statusline = require("mini.statusline")
			statusline.setup({
				use_icons = false,
				content = {
					active = function()
						local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
						local git = statusline.section_git({ trunc_width = 75 })
						local filename = statusline.section_filename({ trunc_width = 140 })
						local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
						local location = "%2l:%-2v"

						return statusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git } },
							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- End left alignment
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { location } },
						})
					end,
				},
			})

			-- Git signs (minimal text-based)
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "+", change = "~", delete = "-" },
				},
			})

			-- Auto-pairs (minimal)
			require("mini.pairs").setup()

			-- Better text objects
			require("mini.ai").setup({ n_lines = 500 })

			-- Surround functionality
			require("mini.surround").setup()

			-- Comments (better than default)
			require("mini.comment").setup()

			-- File explorer (if you want to try it)
			-- require('mini.files').setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				rust_analyzer = {},
				clangd = {},
				ts_ls = {},
				omnisharp = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				jdtls = {
					settings = {
						java = {
							home = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
						},
					},
				},
			}
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"rust-analyzer",
				"clangd",
				"typescript-language-server",
				"omnisharp",
				"stylua",
				"clang-format",
				"latexindent",
				"isort",
				"black",
				"rustfmt",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				automatic_installation = false,
				ensure_installed = {},
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = true,
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				latex = { "latexindent" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				jsx = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				tsx = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete({}),
				}),
				sources = {
					{ name = "nvim_lsp" },
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			signs = false,
		},
	},
	{
		"lervag/vimtex",
		init = function()
			vim.g.vimtex_view_method = "skim"
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"yaml",
				"json",
				"javascript",
				"typescript",
				"tsx",
				"css",
				"scss",
				"rust",
				"cpp",
				"java",
				"python",
				"ruby",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		{
			"github/copilot.vim",
		},
	},
})

vim.cmd("doautocmd ColorScheme")

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "@keyword", { ctermfg = 5 }) -- magenta (#bb9af7)
		vim.api.nvim_set_hl(0, "@keyword.return", { ctermfg = 5 })
		vim.api.nvim_set_hl(0, "@keyword.function", { ctermfg = 5 })
		vim.api.nvim_set_hl(0, "@keyword.operator", { ctermfg = 5 })
		vim.api.nvim_set_hl(0, "@keyword.modifier", { ctermfg = 13 }) -- bright magenta
		vim.api.nvim_set_hl(0, "@storageclass", { ctermfg = 5 })
		vim.api.nvim_set_hl(0, "@variable", { ctermfg = 15 })
		vim.api.nvim_set_hl(0, "@variable.member", { ctermfg = 14 })
		vim.api.nvim_set_hl(0, "@variable.parameter", { ctermfg = 11 })
		vim.api.nvim_set_hl(0, "@constant", { ctermfg = 3 }) -- yellow/orange (#ff9e64)
		vim.api.nvim_set_hl(0, "@constant.builtin", { ctermfg = 3 })
		vim.api.nvim_set_hl(0, "@punctuation", { ctermfg = 14 }) -- bright cyan (#89ddff)
		vim.api.nvim_set_hl(0, "@punctuation.bracket", { ctermfg = 7 }) -- light gray
		vim.api.nvim_set_hl(0, "@operator", { ctermfg = 14 })
		vim.api.nvim_set_hl(0, "@function", { ctermfg = 12 }) -- bright blue (#7aa2f7)
		vim.api.nvim_set_hl(0, "@function.builtin", { ctermfg = 12 })
		vim.api.nvim_set_hl(0, "@function.method", { ctermfg = 12 })
		vim.api.nvim_set_hl(0, "@type", { ctermfg = 6 }) -- cyan (#0db9d7)
		vim.api.nvim_set_hl(0, "@type.builtin", { ctermfg = 6 })
		vim.api.nvim_set_hl(0, "@namespace", { ctermfg = 6 })
		vim.api.nvim_set_hl(0, "@string", { ctermfg = 10 }) -- bright green (#9ece6a)
		vim.api.nvim_set_hl(0, "@string.escape", { ctermfg = 14 }) -- bright cyan
		vim.api.nvim_set_hl(0, "@number", { ctermfg = 3 }) -- yellow (#ff9e64)
		vim.api.nvim_set_hl(0, "@boolean", { ctermfg = 3 })
		vim.api.nvim_set_hl(0, "@comment", { ctermfg = 8 }) -- dark gray (#51597d)
		vim.api.nvim_set_hl(0, "@tag", { ctermfg = 9 }) -- bright red (#f7768e)
		vim.api.nvim_set_hl(0, "@tag.attribute", { ctermfg = 5 }) -- magenta
		vim.api.nvim_set_hl(0, "@macro", { ctermfg = 5 }) -- magenta
		vim.api.nvim_set_hl(0, "@property", { ctermfg = 6 }) -- cyan (#73daca)

		vim.api.nvim_set_hl(0, "DiagnosticError", { ctermfg = 9 }) -- bright red
		vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 11 }) -- bright yellow
		vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 12 }) -- bright blue
		vim.api.nvim_set_hl(0, "DiagnosticHint", { ctermfg = 14 }) -- bright cyan

		-- Git diff signs (for mini.diff)
		vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { ctermfg = 10 }) -- bright green
		vim.api.nvim_set_hl(0, "MiniDiffSignChange", { ctermfg = 11 }) -- bright yellow
		vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { ctermfg = 9 }) -- bright red

		-- Statusline colors - black background with light text
		vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { ctermfg = 0, ctermbg = 8 }) -- light gray text on black
		vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { ctermfg = 0, ctermbg = 8 }) -- white text on black
		vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { ctermfg = 0, ctermbg = 8 }) -- light gray text on black

		-- Mode indicators - green text on green background (\e[0;32;42m)
		vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { ctermfg = 2, ctermbg = 0 }) -- green on green
		vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { ctermfg = 2, ctermbg = 0 }) -- green on green
		vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { ctermfg = 2, ctermbg = 0 }) -- green on green
		vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { ctermfg = 2, ctermbg = 0 }) -- green on green
		vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { ctermfg = 2, ctermbg = 0 }) -- green on green

		-- Telescope highlights
		vim.api.nvim_set_hl(0, "TelescopeSelection", { ctermfg = 15, ctermbg = 8 }) -- white on dark gray
		vim.api.nvim_set_hl(0, "TelescopeMatching", { ctermfg = 11 }) -- bright yellow matches
		vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { ctermfg = 12 }) -- bright blue prompt

		-- Which-key highlights
		vim.api.nvim_set_hl(0, "WhichKey", { ctermfg = 11 }) -- bright yellow keys
		vim.api.nvim_set_hl(0, "WhichKeyDesc", { ctermfg = 14 }) -- bright cyan descriptions
		vim.api.nvim_set_hl(0, "WhichKeyGroup", { ctermfg = 10 }) -- bright green groups

		-- Todo comments
		vim.api.nvim_set_hl(0, "@comment.todo", { ctermfg = 0, ctermbg = 11 }) -- black on bright yellow
		vim.api.nvim_set_hl(0, "@comment.note", { ctermfg = 0, ctermbg = 12 }) -- black on bright blue
		vim.api.nvim_set_hl(0, "@comment.warning", { ctermfg = 0, ctermbg = 9 }) -- black on bright red
	end,
})

vim.cmd("doautocmd ColorScheme")
vim.cmd("TSEnable highlight")
