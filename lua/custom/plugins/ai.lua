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

vim.pack.add { gh "jim-at-jibba/nvim-stride" }

require("stride").setup({
  -- API Configuration
  api_key = "asdfk",
  endpoint = "http://localhost:13305/api/v1/chat/completions",
  model = "Qwen2.5-Coder-1.5B-Instruct-GGUF-Q4_K_M",

  -- UX Settings
  debounce_ms = 500,           -- Debounce for insert mode (ms)
  debounce_normal_ms = 500,    -- Debounce for normal mode edits (ms)
  accept_keymap = "<Tab>",     -- Key to accept suggestion
  accept_word_keymap = "<M-w>", -- Key to accept next word (false to disable)
  accept_line_keymap = "<M-l>", -- Key to accept first line (false to disable)
  dismiss_keymap = "<Esc>",    -- Key to dismiss suggestion (normal mode)
  context_lines = 30,          -- Lines of context before/after cursor

  -- Rate Limiting
  min_request_interval_ms = 500,  -- Min interval between any two API requests
  rate_limit_cooldown_ms = 15000, -- Pause after a 429 without Retry-After header
  max_context_chars = 9000,       -- Char budget for completion prompt context

  -- Feature Flags
  use_treesitter = true,       -- Use Treesitter for smart context expansion
  disabled_filetypes = {},     -- Additional filetypes to disable (merged with defaults)
  disabled_buftypes = {},      -- Additional buftypes to disable (merged with defaults)
  debug = false,               -- Enable debug logging to file

  -- Mode Selection
  mode = "completion",         -- "completion", "refactor", or "both"
  show_remote = true,          -- Show remote suggestions in refactor mode

  -- Refactor Mode Settings
  max_tracked_changes = 10,    -- Max edits to track in history
  token_budget = 1000,         -- Max tokens for change history in prompt
  small_file_threshold = 200,  -- Files <= this many lines send whole content

  -- Project Context
  context_files = false,       -- false or {"AGENTS.md", ".cursor/rules"}

  -- Gutter Sign
  sign = {
    icon = nil,                -- nil = auto-detect nerd font ("󰷺" or ">")
    hl = "StrideSign",         -- Highlight group for sign
  },
  -- sign = false,             -- Set to false to disable gutter sign

  -- Notifications (bottom-center popup when suggestions available)
  notify = {
    enabled = true,            -- Show notifications
    timeout = 2000,            -- Display duration (ms)
    backend = "fidget",       -- "builtin" or "fidget"
  },
  -- notify = false,           -- Set to false to disable notifications
})
