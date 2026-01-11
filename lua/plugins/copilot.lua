return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
          suggestion = {
            enabled = false,
          },
          panel = {
            enabled = false,
          },
        },
      },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },

    build = 'make tiktoken', -- Only on MacOS or Linux

    -- Change 'opts' from a table to a function to safely require the select module
    opts = function()
      -- local selection = require 'CopilotChat.select'
      return {
        model = 'claude-sonnet-4.5',
        agent = 'copilot',
        sticky = { '#buffer' },

        -- Set default selection to the whole buffer
        -- selection = selection.buffer,
      }
    end,

    keys = {
      -- Chat Management
      { '<leader>cc', '<cmd>CopilotChat<cr>', desc = 'Open Copilot Chat' },
      { '<leader>ct', '<cmd>CopilotChatToggle<cr>', desc = 'Toggle Chat' },
      { '<leader>cq', '<cmd>CopilotChatClose<cr>', desc = 'Close Chat' },
      { '<leader>cr', '<cmd>CopilotChatReset<cr>', desc = 'Reset Chat' },

      -- History
      { '<leader>cl', '<cmd>CopilotChatLoad<cr>', desc = 'Load History' },
      { '<leader>cs', '<cmd>CopilotChatSave<cr>', desc = 'Save History' },

      -- Code Actions
      { '<leader>ce', '<cmd>CopilotChatExplain<cr>', mode = 'v', desc = 'Explain Selection' },
      { '<leader>cf', '<cmd>CopilotChatFix<cr>', mode = 'v', desc = 'Fix Selection' },
      { '<leader>co', '<cmd>CopilotChatOptimize<cr>', mode = 'v', desc = 'Optimize Selection' },
      { '<leader>cd', '<cmd>CopilotChatDocs<cr>', mode = 'v', desc = 'Generate Docs' },
      { '<leader>cT', '<cmd>CopilotChatTests<cr>', mode = 'v', desc = 'Generate Tests' },
      { '<leader>cR', '<cmd>CopilotChatReview<cr>', mode = 'v', desc = 'Review Selection' },
    },
  },
}
