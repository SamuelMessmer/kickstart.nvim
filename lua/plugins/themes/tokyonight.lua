return {
  -- You can easily change to a different colorscheme.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      transparent = true,
      styles = {
        comments = { italic = true }, -- Disable italics in comments
      },
    }
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
-- return {
--   -- You can easily change to a different colorscheme.
--   'folke/tokyonight.nvim',
--   priority = 1000, -- Make sure to load this before all the other start plugins.
--   config = function()
--     require('tokyonight').setup {
--       -- HIER SIND DIE ÄNDERUNGEN:
--       transparent = true, -- Aktiviert Transparenz global (nutzt Terminal-Hintergrund)
--       styles = {
--         comments = { italic = true },
--       },
--     }
--     vim.cmd.colorscheme 'tokyonight-night'
--   end,
-- }
