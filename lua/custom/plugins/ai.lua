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

-- minuet-ai

vim.pack.add { gh 'milanglacier/minuet-ai.nvim' }

require('minuet').setup {
  blink = {
    enable_auto_complete = true,
  },
  virtualtext = {
    auto_trigger_ft = {"*"},
    keymap = {
      -- accept whole completion
      accept = '<A-A>',
      -- accept one line
      accept_line = '<A-a>',
      -- accept n lines (prompts for number)
      -- e.g. "A-z 2 CR" will accept 2 lines
      accept_n_lines = '<A-z>',
      -- Cycle to prev completion item, or manually invoke completion
      prev = '<A-[>',
      -- Cycle to next completion item, or manually invoke completion
      next = '<A-]>',
      dismiss = '<A-e>',
    },
  },
  provider = 'openai_compatible',
  provider_options = {
    openai_compatible = {
      api_key = 'TERM',
      model = 'Qwen2.5-Coder-1.5B-Instruct-GGUF-Q4_K_M',
      end_point = 'http://localhost:13305/v1/chat/completions',
      optional = {
        max_completion_tokens = 128,
        -- for thinking models
        reasoning_effort = 'none',
        -- reasoning_effort = "minimal",
        -- Set to "minimal" if your chosen model doesn't support "none"
      },
    },
  },
  duet = {
    provider = 'openai_compatible',
    provider_options = {
      openai_compatible = {
        api_key = 'TERM',
        model = 'Qwen2.5-Coder-1.5B-Instruct-GGUF-Q4_K_M',
        optional = {
          max_completion_tokens = 128,
          -- for thinking models
          reasoning_effort = 'none',
          -- reasoning_effort = "minimal",
          -- Set to "minimal" if your chosen model doesn't support "none"
        },
        end_point = 'http://localhost:13305/v1/chat/completions',
      },
    },
  },
}

-- 99

vim.pack.add { gh 'ThePrimeagen/99' }

local _99 = require '99'

_99.setup {
  provider = _99.Providers.OpenCodeProvider,
  -- model is optional, overrides the provider's default
  model = 'solheim/qwen3.8-27b',
}

vim.keymap.set('v', '<leader>9v', function() _99.visual() end)

--- if you have a request you dont want to make any changes, just cancel it
vim.keymap.set('n', '<leader>9x', function() _99.stop_all_requests() end)

vim.keymap.set('n', '<leader>9s', function() _99.search() end)
