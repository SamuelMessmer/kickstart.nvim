return {
  -- 1. Der Motor: copilot.lua
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<C-l>', -- Drücke Strg+l um einen Vorschlag anzunehmen (Tab macht oft Probleme)
            next = '<M-]>', -- Alt + ] für nächsten Vorschlag
            prev = '<M-[>', -- Alt + [ für vorherigen Vorschlag
          },
        },
        panel = { enabled = false },
      }
    end,
  },

  -- 2. Das Chat-Fenster: CopilotChat.nvim
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- Macht den Motor zur Abhängigkeit
      { 'nvim-lua/plenary.nvim' }, -- Hilfsbibliothek
    },
    build = 'make tiktoken', -- WICHTIG: Damit der Chat schneller ist (optional, aber empfohlen)
    opts = {
      debug = false,
      window = {
        layout = 'float',
        width = 0.8,
        height = 0.8,
      },
    },
    keys = {
      { '<leader>cc', ':CopilotChatToggle<CR>', desc = '[C]opilot [C]hat Toggle' },
      { '<leader>ce', ':CopilotChatExplain<CR>', desc = '[C]opilot [E]xplain Code' },
      { '<leader>cf', ':CopilotChatFix<CR>', desc = '[C]opilot [F]ix Code' },
      { '<leader>cr', ':CopilotChatReset<CR>', desc = '[C]opilot [R]eset' },
    },
  },
}
