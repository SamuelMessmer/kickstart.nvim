--[[=================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
===================================================================]]

-- WARNING: [[ Settings ]]
--
--
-- Set <space> as the leader key
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- Make line numbers default
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.number = true
--- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

--[[ Clipboard Settings ]]
--
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Das Zeilen automatisch umbrechen
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
-- nicht für plugins nur für '/' search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
--
--
--
--
--
--
--
--
--
--  WARNING: [[ Custom Keymaps ]]
--
--
-- jk zum Verlassen des Insert Mode --
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit Insert Mode with jk' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Exit Insert Mode with kj' })

-- toggle neo-tree --
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'NeoTree öffnen/schließen' })
vim.keymap.set('n', '<leader>E', ':Neotree reveal<CR>', { desc = 'Datei im NeoTree zeigen' })
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit Insert Mode with jk' })

-- System-Clipboard für Yank & Paste --
vim.keymap.set('n', 'y', '"+y', { desc = 'Yank to System Clipboard' })
vim.keymap.set('n', 'Y', '"+Y', { desc = 'Yank Line to System Clipboard' })
vim.keymap.set('n', 'p', '"+p', { desc = 'Paste from System Clipboard' })
vim.keymap.set('n', 'P', '"+P', { desc = 'Paste (Block) from System Clipboard' })

-- Normal-Mode Black-Hole für Delete/Change/Cut --
vim.keymap.set('n', 'd', '"_d', { desc = 'Delete to Blackhole' })
vim.keymap.set('n', 'D', '"_D', { desc = 'Delete Line to Blackhole' })
vim.keymap.set('n', 'c', '"_c', { desc = 'Change to Blackhole' })
vim.keymap.set('n', 'C', '"_C', { desc = 'Change Line to Blackhole' })
vim.keymap.set('n', 'x', '"_x', { desc = 'Delete Char to Blackhole' })
vim.keymap.set('n', 's', '"_s', { desc = 'Substitute Char to Blackhole' })

-- Visual-Mode Black-Hole für Delete/Change aber Clipboard für Cut --
vim.keymap.set('x', 'y', '"+y', { desc = 'Yank Visual to System Clipboard' })
vim.keymap.set('x', 'd', '"_d', { desc = 'Delete Visual to Blackhole' })
vim.keymap.set('x', 'c', '"_c', { desc = 'Change Visual to Blackhole' })
-- xnoremap x "+x
vim.keymap.set('x', 'x', '"+x', { desc = 'Cut Visual to System Clipboard' })
vim.keymap.set('x', 's', '"_s', { desc = 'Substitute Visual to Blackhole' })

-- Shift+K fügt einen Zeilenumbruch oberhalb der aktuellen Zeile ein --
vim.keymap.set('n', 'K', 'O<Esc>', { desc = 'Insert Line Above' })

-- Redo auf Großbuchstabe U legen --
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo (Wiederherstellen)' })

-- Clear highlighted words on search '/' when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps --
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier. --
--  Use <leader>+<hjkl> to switch between windows --
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
--
--
--
--
--
--
--
--
--
-- WARNING: [[ Basic Autocommands ]]
--
--
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)
--
--
--
--
--  WARNING: [[ Cutom Plugins ]]
--
--
require('lazy').setup(
  {
    { import = 'plugins' },
    { import = 'plugins.LSP' },
    { import = 'plugins.themes' },
    { import = 'plugins.visual' },
  },
  --
  --
  --
  -- WARNING: [[ Random ]]
  --
  --
  {
    ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  }
)
