require('plugins')

vim.cmd [[colorscheme hybrid]]
vim.opt.termguicolors = true

vim.opt.undodir = vim.fn.stdpath('config') .. '/undo'
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.title = true                -- Update window title on file change
vim.opt.scrolloff = 3               -- Keep three lines of buffer when scrolling
vim.opt.sidescrolloff = 3
vim.opt.incsearch = true            -- Incremental search
vim.opt.hlsearch = true             -- Highlight search results
vim.opt.smartcase = true            -- Search is case-sensitive only if search contains upper case
vim.opt.number = true               -- Show line numbers
vim.opt.showcmd = true              -- Display commands in the statusline
vim.opt.ruler = true                -- Show current line number in statusline
vim.opt.ttyfast = true              -- It's ok vim, our terminal is fast
vim.opt.hidden = true               -- Allow hiding of hidden buffers
vim.opt.cursorline = true           -- Highlight the current line
vim.opt.colorcolumn = '80'          -- Show a right margin
