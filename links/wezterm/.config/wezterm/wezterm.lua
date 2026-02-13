local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font_size = 13.0
config.use_ime = true
config.window_background_opacity = 0.77
config.macos_window_background_blur = 10
config.window_decorations = "RESIZE"
config.window_background_gradient = {
  colors = { "#000000" },
}
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"

  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end

  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  local tab_title = pane.title
  if cwd then
    local cwd_path = cwd.file_path
    -- ホームディレクトリを ~ に置換
    local home = os.getenv("HOME")
    if home and cwd_path:sub(1, #home) == home then
      cwd_path = "~" .. cwd_path:sub(#home + 1)
    end
    -- 末尾のスラッシュを除去（ルート以外）
    if #cwd_path > 1 and cwd_path:sub(-1) == "/" then
      cwd_path = cwd_path:sub(1, -2)
    end
    tab_title = cwd_path:match("([^/]+)$") or cwd_path
  end
  local title = "   " .. wezterm.truncate_right(tab_title, max_width - 1) .. "   "

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

return config