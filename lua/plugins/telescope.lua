return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    -- Useful for getting pretty icons, but requires a Nerd Font.
  },
  config = function()
    local actions = require 'telescope.actions'

    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      defaults = {
        path_display = { 'smart' },
        mappings = {
          -- Schließe Telescope auch mit 'q' --
          n = {
            ['q'] = actions.close, -- Schließt Telescope mit q
            ['<Esc>'] = actions.close, -- Schließt Telescope mit Esc
            ['l'] = actions.select_default,
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    local normal_mode = { initial_mode = 'normal' }
    vim.keymap.set({ 'n', 'x' }, '<leader>sh', function()
      builtin.help_tags(normal_mode)
    end, { desc = '[s]earch [h]elp' })
    vim.keymap.set({ 'n', 'x' }, '<leader>sk', function()
      builtin.keymaps(normal_mode)
    end, { desc = '[s]earch [k]eymaps' })
    vim.keymap.set({ 'n', 'x' }, '<leader>sf', function()
      builtin.find_files(normal_mode)
    end, { desc = '[s]earch [f]iles' })
    vim.keymap.set({ 'n', 'x' }, '<leader>sr', function()
      builtin.oldfiles(normal_mode)
    end, { desc = '[s]earch recent files ("r" for recent)' })
    vim.keymap.set({ 'n', 'x' }, '<leader>sg', function()
      builtin.live_grep(normal_mode)
    end, { desc = '[s]earch by [g]rep' })
    -- Slightly advanced example of overriding default behavior and theme
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    vim.keymap.set({ 'n', 'x' }, '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set({ 'n', 'x' }, '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
    --
    --
    --
    --
    --
    --  WARNING:
    --
    -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
    -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] find existing buffers' })
    -- It's also possible to pass additional configuration options.
    -- See `:help telescope.builtin.live_grep()` for information about particular keys
    -- vim.keymap.set('n', '<leader>sg', function()
    --   builtin.live_grep {
    --     grep_open_files = false,
    --     prompt_title = 'Live Grep',
    --   }
    -- end, { desc = '[S]earch word with [g]rep' })
  end,
}
