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

-- Open new split panes below and right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Quickly switch between buffers and tabs
vim.keymap.set('n', '<C-j>', '<Plug>(CybuPrev)<CR>')
vim.keymap.set('n', '<right>', '<Plug>(CybuNext)<CR>')
vim.keymap.set('n', '<left>', '<cmd>:bp<CR>')
vim.keymap.set('n', '<up>', '<cmd>:tabn<CR>')
vim.keymap.set('n', '<down>', '<cmd>:tabp<CR>')

-- C-c to close buffer but keep window
vim.keymap.set('n', '<C-c>', '<cmd>:bp|bd #<CR>', { noremap = true, silent = true })

-- Allow Control-Z to work in insert mode
vim.keymap.set('n', '<C-Z>', '<cmd>:suspend<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Z>', '<C-O><C-Z>', { noremap = true, silent = true })

-- Move paragraphs by backspace/return
vim.keymap.set({'n', 'o', 'v'}, '<BS>', '{', { noremap = true, silent = true })
vim.keymap.set({'n', 'o', 'v'}, '<CR>', '}', { noremap = true, silent = true })
