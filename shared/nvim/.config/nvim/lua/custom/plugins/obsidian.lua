return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  config = function()
    require('obsidian').setup {
      workspaces = {

        {
          name = 'personal',
          path = '~/obsidian/obsidian/',
        },
        {
          name = 'work',
          path = '~/obsidian/work',
        },
      },
      notes_subdir = '0. new Notes',
      daily_notes = {
        folder = '1. Daily Notes',
        date_format = '%Y-%m-%d',
        template = 'daily.md',
      },
      new_notes_location = 'notes_subdir',

      templates = {
        subdir = '99.misc/Templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
      },

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = 'telescope.nvim',
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = '<C-x>',
          -- Insert a link to the selected note.
          insert_link = '<C-l>',
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = '<C-x>',
          -- Insert a tag at the current location.
          insert_tag = '<C-l>',
        },
      },
    }
    -- Add Keybinds
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', '<leader>oo', '<cmd>ObsidianOpen<CR>', opts)
    map('n', '<leader>os', '<cmd>ObsidianSearch<CR>', opts)
    map('n', '<leader>ot', '<cmd>ObsidianToday<CR>', opts)
    map('n', '<leader>oe', '<cmd>ObsidianExtractNote<CR>', opts)
    map('n', '<leader>ob', '<cmd>ObsidianBacklinks<CR>', opts)
    map('n', '<leader>of', '<cmd>ObsidianFollowLink<CR>', opts)
    map('n', '<leader>ol', '<cmd>ObsidianLink<CR>', opts)
    map('n', '<leader>on', '<cmd>ObsidianNew<CR>', opts)
  end,
}
