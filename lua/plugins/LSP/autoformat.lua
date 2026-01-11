return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      'ff',
      function()
        require('conform').format { async = true, lsp_fallback = false }
      end,
      mode = '',
      desc = '[F]ormat Code',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, java = true }

      if disable_filetypes[vim.bo[bufnr].filetype] then
        return false
      end

      return {
        timeout_ms = 500,
        -- lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters = {
      ['google-java-format'] = {
        args = function()
          return { '-aosp', '-' }
        end,
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      java = { 'google-java-format' },
      elixir = { 'mix' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
  },
}
