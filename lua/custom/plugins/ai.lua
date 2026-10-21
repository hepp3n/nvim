local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'olimorris/codecompanion.nvim' }

require('codecompanion').setup {
  adapters = {
    http = {
      acme_gateway = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          formatted_name = 'Acme Gateway',
          env = {
            url = 'https://api.solheim.ai',
          },
          schema = {
            model = {
              default = 'qwen3.8-27b',
            },
          },
        })
      end,
    },
  },
  interactions = {
    --NOTE: Change the adapter as required
    chat = { adapter = 'acme_gateway' },
    inline = { adapter = 'acme_gateway' },
  },
  opts = {
    log_level = 'DEBUG', -- or "TRACE"
  },
}

require('nvim-treesitter')
  .install({
    'lua',
    'markdown',
    'markdown_inline',
    'yaml',
  }, { summary = true, max_jobs = 10 })
  :wait(1800000)
