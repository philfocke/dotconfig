-- Default options:
return {
  {
    'rebelot/kanagawa.nvim',
    opts = {},
  },
  {
    'vague2k/vague.nvim',
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      -- vim.cmd 'colorscheme rose-pine'
    end,
  },
  { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ... },
}
