return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Setze das Header-Logo (das klassische Neovim ASCII Art)
    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  /' __` __`\ ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \ /\ \/\ \/\ \]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/ \/_/\/_/\/_/]],
    }

    -- Setze die Buttons im Menü
    dashboard.section.buttons.val = {
      dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
      dashboard.button('r', '  Recent', ':Telescope oldfiles <CR>'),
      dashboard.button('g', '  Live Grep', ':Telescope live_grep <CR>'),
      dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    -- Setze ein Footer (optional)
    dashboard.section.footer.val = { 'Neovim Kickstart' }

    alpha.setup(dashboard.config)
  end,
}
