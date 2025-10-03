local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-treesitter/nvim-treesitter-context",
  "lbrayner/vim-rzip",
  "farmergreg/vim-lastplace",
  {"lewis6991/gitsigns.nvim", opts = {}},
  {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}},
  "darfink/vim-plist",
  "alker0/chezmoi.vim",
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<C-S-p>", builtin.buffers, {})
      vim.keymap.set("n", "<C-g>", builtin.live_grep, {})
    end
  },
  {
    "ghillb/cybu.nvim",
    version = "*",
    dependencies = {"nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim"},
    config = true
  },
  {"Exafunction/windsurf.vim", event = "BufEnter"},
  {"w0ng/vim-hybrid", name="hybrid", lazy = false, priority = 1000},
  {"NvChad/nvim-colorizer.lua", config = function() require("colorizer").setup() end},
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "bibtex",
            "c",
            "cmake",
            "cpp",
            "css",
            "csv",
            "diff",
            "dockerfile",
            "dot",
            "doxygen",
            "git_config",
            "git_rebase",
            "html",
            "javascript",
            "json",
            "lua",
            "perl",
            "php",
            "query",
            "rust",
            "scala",
            "sql",
            "tmux",
            "typescript",
            "vim",
            "vimdoc",
            "vue",
            "xml",
            "yaml",
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
  },
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with "{" and "}"
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end,
  },
  --
  -- LSP configuration
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "bashls",
          "biome",
          "clangd",
          "cmake",
          "docker_compose_language_service",
          "dockerls",
          "emmylua_ls",
          "gradle_ls",
          "html",
          "jsonls",
          "lua_ls",
          "pylyzer",
          "rust_analyzer",
          "sqlls",
          "tflint",
          "vimls",
          "vue_ls",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("bashls")
      vim.lsp.enable("biome")
      vim.lsp.enable("clangd")
      vim.lsp.enable("cmake")
      vim.lsp.enable("docker_compose_language_service")
      vim.lsp.enable("dockerls")
      vim.lsp.enable("emmylua_ls")
      vim.lsp.enable("gradle_ls")
      vim.lsp.enable("html")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pylyzer")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("sqlls")
      vim.lsp.enable("tflint")
      vim.lsp.enable("vimls")
      vim.lsp.enable("vue_ls")
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
})
