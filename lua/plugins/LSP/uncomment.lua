return {
  'numToStr/Comment.nvim',
  config = function()
    -- Plugin initialisieren (Standard-Einstellungen sind meist am besten)
    require('Comment').setup()

    -- 1. Normal Mode: <leader>u kommentiert die aktuelle Zeile (wie gcc)
    vim.keymap.set('n', '<leader>u', 'gcc', { remap = true, desc = 'Uncomment current Line' })

    -- 2. Visual Mode: <leader>u kommentiert den markierten Bereich (wie gc)
    vim.keymap.set('x', '<leader>u', 'gc', { remap = true, desc = 'Uncomment current Line' })
  end,
}
