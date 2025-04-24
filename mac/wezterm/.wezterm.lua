-- Pull in the wezterm API
local wezterm = require 'wezterm'
local io = require 'io'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

max_fps = 120
-- redefine brewer colors to better contrast
local mybrewerlight = wezterm.color.get_builtin_schemes()['Brewer (light) (terminal.sexy)']
mybrewerlight.background = 'white'
mybrewerlight.foreground = 'black'

local mybrewerdark = wezterm.color.get_builtin_schemes()['Brewer (dark) (terminal.sexy)']
mybrewerdark.foreground = 'white'
mybrewerdark.background = 'black'



config.color_schemes = {
  ['mybrewer light'] = mybrewerlight,
  ['mybrewer dark'] = mybrewerdark,
}

local lighttheme = 'mybrewer light'
--local darktheme =  'rose-pine'
local darktheme =  'Gruvbox Dark (Gogh)'


-- redefine background color in Brewer light theme to white


config.color_scheme = darktheme
-- config.foreground_text_hsb = {hue = 1.0,saturation = 0.9,brightness = 1.0}

config.hide_tab_bar_if_only_one_tab = true
config.font_size = 28
config.force_reverse_video_cursor = true

local basefont = 'JetBrains Mono'
local regularfont = wezterm.font(basefont, { weight = 'Regular'})
local boldfont = wezterm.font(basefont, { weight = 'Bold'})
config.font = regularfont

config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
config.audible_bell = "Disabled"
config.window_close_confirmation = 'NeverPrompt'
config.canonicalize_pasted_newlines = 'CarriageReturn'
if (config.notification_handling ~= nil) then
  config.notification_handling = 'AlwaysShow'
end

-- tilde on macos
config.use_dead_keys = true


-- os specifics
-- windows
if string.find(wezterm.target_triple, 'windows') ~= nil then
  myenv="windows"
  front_end="Software"
  winenv=os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH")
  config.default_prog = { winenv .. '\\scoop\\apps\\git\\current\\bin\\bash.exe', '-l' }
end
-- linux
if string.find(wezterm.target_triple, 'linux') ~= nil then
  myenv="linux"
end
-- macos
if string.find(wezterm.target_triple, 'apple') ~= nil then
  myenv="apple"
  config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
  config.send_composed_key_when_left_alt_is_pressed = true
  --  config.front_end = "WebGpu"
end



-- function on event toggle-theme - see config.keys
wezterm.on('toggle-theme', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if overrides.color_scheme == lighttheme then
    overrides.color_scheme = darktheme
  else
    overrides.color_scheme = lighttheme
  end
  window:set_config_overrides(overrides)
end)

-- function on event toggle-fontweight - see config.keys
wezterm.on('toggle-fontweight', function(window, pane)
  local fullconfig = window:effective_config()
  local overrides = window:get_config_overrides() or {}
  if fullconfig.font.font[1].weight == "Regular" then
    overrides.font = boldfont
  else
    overrides.font = regularfont
  end
  window:set_config_overrides(overrides)
end)



config.keys = {
  {
    -- Turn off non-breaking spaces in wezterm on MacOS
    key = ' ',
    mods = 'OPT',
    action = wezterm.action.SendKey { key = ' '},
  },

  {
    key = 'w',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },

  {
    key = '1',
    mods = 'CTRL',
    action = wezterm.action.PaneSelect {
      alphabet = '1234567890',
    },
  },
  {
    key = '2',
    mods = 'CTRL',
    action = wezterm.action.PaneSelect {
      alphabet = '1234567890',
      mode = 'SwapWithActive',
    },
  },
  {
    key = '3',
    mods = 'CTRL',
    action = wezterm.action.EmitEvent 'toggle-theme',
  },
  {
    key = '4',
    mods = 'CTRL',
    action = wezterm.action.EmitEvent 'toggle-fontweight',
  },
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },
}

-- and finally, return the configuration to wezterm
return config

