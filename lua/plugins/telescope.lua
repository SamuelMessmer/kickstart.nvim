return { -- Füge 'return' am Anfang hinzu
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
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [f]iles' })
    vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[s]earch recent files ("r" for recent)' })
    -- Slightly advanced example of overriding default behavior and theme
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    --
    --
    --
    --
    --
    --  WARNING:
    --
    -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch by [g]rep' })
    -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
    -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] find existing buffers' })

    -- It's also possible to pass additional configuration options.
    -- See `:help telescope.builtin.live_grep()` for information about particular keys
    -- vim.keymap.set('n', '<leader>s/', function()
    --   builtin.live_grep {
    --     grep_open_files = true,
    --     prompt_title = 'Live Grep in Open Files',
    --   }
    -- end, { desc = '[S]earch [/] in Open Files' })
  end,
}
