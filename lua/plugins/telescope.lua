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
      builtin.oldfiles(vim.tbl_extend('force', normal_mode, {
        cwd_only = true, -- Faster filtering
        previewer = false, -- Skip preview for speed
        -- only_cwd = true, -- Only show files from current project
      }))
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

    -- ==========================================
    -- HARPOON-STYLE RECENT FILES NAVIGATION
    -- ==========================================
    local MAX_RECENT_FILES = 20
    local NUM_HARPOON_KEYS = 5
    local recent_files = {}

    local function is_valid_project_file(file, cwd)
      return file ~= '' and vim.startswith(file, cwd) and vim.fn.filereadable(file) == 1
    end

    local function add_to_recent(file)
      -- Remove duplicate if exists
      for i, f in ipairs(recent_files) do
        if f == file then
          table.remove(recent_files, i)
          break
        end
      end
      -- Prepend and trim to max
      table.insert(recent_files, 1, file)
      if #recent_files > MAX_RECENT_FILES then
        table.remove(recent_files)
      end
    end

    local function get_recent_at_index(index)
      local current_file = vim.api.nvim_buf_get_name(0)
      local count = 0
      for _, file in ipairs(recent_files) do
        if file ~= current_file then
          count = count + 1
          if count == index then
            return file
          end
        end
      end
      return nil
    end

    -- Initialize from oldfiles
    local cwd = vim.fn.getcwd()
    for _, file in ipairs(vim.v.oldfiles) do
      if #recent_files >= MAX_RECENT_FILES then
        break
      end
      if is_valid_project_file(file, cwd) then
        add_to_recent(file)
      end
    end

    -- Track files on buffer enter
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        local file = vim.api.nvim_buf_get_name(0)
        if is_valid_project_file(file, vim.fn.getcwd()) then
          add_to_recent(file)
        end
      end,
    })

    -- Keymaps <leader>1 to <leader>N
    for i = 1, NUM_HARPOON_KEYS do
      vim.keymap.set('n', '<leader>' .. i, function()
        local file = get_recent_at_index(i)
        if file then
          vim.cmd('edit ' .. vim.fn.fnameescape(file))
          print('Harpoon [' .. i .. ']: ' .. vim.fn.fnamemodify(file, ':t'))
        else
          print('No recent file at position ' .. i)
        end
      end, { desc = 'Recent file ' .. i })
    end
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
