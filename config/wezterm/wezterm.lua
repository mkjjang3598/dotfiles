-- https://wezfurlong.org/wezterm/config/files.html

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}
local M = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end


-- Config starts!
-- https://wezfurlong.org/wezterm/config/lua/config/index.html

function M.setup_appearances()
  -- Appearances: https://wezfurlong.org/wezterm/config/appearance.html
  config.adjust_window_size_when_changing_font_size = false
  config.hide_tab_bar_if_only_one_tab = true
  config.window_padding = {  -- in pixels
    left = 5, right = 5,
    top = 8, bottom = 8,
  }
end
function M.setup_fonts()
  -- Fonts: https://wezfurlong.org/wezterm/config/fonts.html
  config.font = wezterm.font_with_fallback {
    'JetBrainsMono Nerd Font Mono',
    'Hack Nerd Font Mono',
    'Monaco',
  }
  config.cell_width = 0.9
  config.line_height = 0.92
  config.font_size = 18
  -- No ligatures
  config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
end
function M.setup_keys()
  -- Need to turn off use_ime otherwise key repeat gets broken (see #4061)
  -- Note: this setting makes CJK (e.g., 한글) input not work properly.
  -- https://wezfurlong.org/wezterm/config/lua/config/use_ime.html
  config.use_ime = false
  -- https://wezfurlong.org/wezterm/config/keyboard-concepts.html#dead-keys
  config.use_dead_keys = false
end
function M.setup_misc()
  config.scrollback_lines = 10000
end

-- Debugging mode
function M.setup_debug()
  if false then
    config.debug_key_events = true
  end
end


-- Invoke all the M.setup_xxx functions.
for key, _ in pairs(M) do
  if string.sub(key, 1, 5) == 'setup' then
    M[key]()
  end
end
return config
