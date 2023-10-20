return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
					border = "rounded",
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- local server = {
			-- 	clangd = {
					
			-- 	},
			-- }

			require("mason-lspconfig").setup({
				-- ensure_installed = vim.tbl_keys(server),
				ensure_installed = {"clangd"}
			})


			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({})
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				-- ["rust_analyzer"] = function ()
				--     require("rust-tools").setup {}
				-- end

				

				-- ["clangd"] = function()
				-- 	require("lspconfig")["clangd"].setup({
				-- 		cmd = {"clangd", "--background-index"}, -- Clangd可执行文件及选项
				-- 		filetypes = {"c", "cpp", "objc", "objcpp", "c++"}, -- 支持的文件类型
				-- 		-- 项目根目录查找方式
				-- 		-- root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
			  
				-- 		-- 更多配置选项
				-- 		settings = {
				--   		-- Clangd 配置
				--   			clangd = {
				-- 				-- compileCommands = {"<path-to-your-build-directory>/compile_commands.json"}, -- 指定编译命令文件路径
				-- 				usePlaceholders = true, -- 启用占位符（placeholders），支持代码补全
				-- 				completeUnimported = true, -- 在代码补全时也包含未导入的头文件
				-- 				semanticHighlighting = true, -- 启用语义高亮
				-- 				extraArgs = {
				-- 					"-IC:/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/13.2.0/include/c++",  -- 添加本地头文件路径
				-- 					"-IC:/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/13.2.0/include/c++/x86_64-w64-mingw32",
				-- 					"-IC:/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/13.2.0/include/c++/backward", 
				-- 					"-IC:/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/13.2.0/include",
				-- 					"-IC:/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/13.2.0/include-fixed",
				-- 					"-IC:/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/13.2.0/../../../../x86_64-w64-mingw32/include",
				-- 					"-std=c++2b",
				-- 					"--target=x86_64-w64-mingw32",
				-- 					"--query-driver=C:\\mingw64",
				-- 					-- 可以添加更多的路径
				-- 				},
				-- 			}	
				-- 		}
				-- 	})

				-- end,

			})			
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins/lspconfig/config")()
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				border = "rounded",
				cmd = { "nvim" },
				debounce = 250,
				debug = false,
				default_timeout = 5000,
				diagnostic_config = {},
				diagnostics_format = "#{m}",
				fallback_severity = vim.diagnostic.severity.ERROR,
				log_level = "warn",
				notify_format = "[null-ls] %s",
				on_init = nil,
				on_exit = nil,
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
				should_attach = nil,
				sources = nil,
				temp_dir = nil,
				update_in_insert = false,
				-- formatting on save
				--on_attach = function(client, bufnr)
				--	if client.supports_method("textDocument/formatting") then
				--		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				--		vim.api.nvim_create_autocmd("BufWritePre", {
				--			group = augroup,
				--			buffer = bufnr,
				--			callback = function()
				--				vim.lsp.buf.format({ bufnr = bufnr })
				--			end,
				--		})
				--	end
				--end,
			}) -- end of setup
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				automatic_setup = true,
				ensure_installed = { "shfmt", "prettier", "stylua" },
			handlers = {},
			})
		end,
	},
}
