return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      window = {
        position = 'left',
        width = 30,
        mappings = {
          ['h'] = 'close_node',
          ['l'] = 'open',
        },
      },
      filesystem = {
        follow_current_file = { enabled = true }, -- Optional: Folgt der Datei im Editor
      },
    }
  end,
}
