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

-- Automatically reload files if unmodified
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  callback = function()
    -- Only check if the buffer is not modified
    if vim.fn.mode() ~= 'c' then
      vim.cmd('checktime')
    end
  end,
})

local commit_diff_group = vim.api.nvim_create_augroup("GitCommitDiff", { clear = true })

local function open_commit_diff()
  if vim.b.commit_diff_open then
    return
  end
  vim.b.commit_diff_open = true

  vim.cmd("vertical rightbelow new")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  vim.bo.swapfile = false
  vim.bo.filetype = "diff"

  local diff = vim.fn.systemlist("git -c core.pager=cat diff --cached --no-ext-diff")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, diff)
  vim.cmd("normal! gg")
  vim.cmd("wincmd p")
end

vim.api.nvim_create_autocmd("FileType", {
  group = commit_diff_group,
  pattern = "gitcommit",
  callback = open_commit_diff,
})
