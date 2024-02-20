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
  "stevearc/dressing.nvim",
  "farmergreg/vim-lastplace",
  {"lewis6991/gitsigns.nvim", opts = {}},
  {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}},
  {'akinsho/git-conflict.nvim', version = "*", config = true},
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'ayu_dark'
        }
      }
    end,
  },
  {
    "ghillb/cybu.nvim",
    version = "*",
    dependencies = {"nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim"},
    config = true
  },
  {"Exafunction/codeium.vim", event = "BufEnter"},
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("bufferline").setup() end,
  },
  {"w0ng/vim-hybrid", name="hybrid", lazy = false, priority = 1000},
  {"NvChad/nvim-colorizer.lua", config = function() require("colorizer").setup() end},
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function() require("Comment").setup() end,
  },
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
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {"j-hui/fidget.nvim", opts = {}},
    },
    ft = { "scala", "sbt", "java" },
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },

  -- LSP configuration
  {"williamboman/mason.nvim", config = function() require("mason").setup() end},
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
          "eslint",
          "gradle_ls",
          "html",
          "jsonls",
          "lua_ls",
          "pylyzer",
          "rust_analyzer",
          "sqlls",
          "tflint",
          "vimls",
          "volar",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require"lspconfig".bashls.setup{}
      require"lspconfig".biome.setup{}
      require"lspconfig".clangd.setup{}
      require"lspconfig".cmake.setup{}
      require"lspconfig".docker_compose_language_service.setup{}
      require"lspconfig".dockerls.setup{}
      require"lspconfig".eslint.setup{}
      require"lspconfig".gradle_ls.setup{}
      require"lspconfig".html.setup{}
      require"lspconfig".jsonls.setup{}
      require"lspconfig".lua_ls.setup{}
      require"lspconfig".pylyzer.setup{}
      require"lspconfig".rust_analyzer.setup{}
      require"lspconfig".sqlls.setup{}
      require"lspconfig".tflint.setup{}
      require"lspconfig".vimls.setup{}
      require"lspconfig".volar.setup{}
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  }
})
