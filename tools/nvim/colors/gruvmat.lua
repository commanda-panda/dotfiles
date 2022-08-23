local colorscheme = {
  name = "gruvmat",
  background = "dark",
}

colorscheme.theme = {
  bg0 = "#282828",
  bg1 = "#32302f",
  bg2 = "#32302f",
  bg3 = "#45403d",
  bg4 = "#45403d",
  bg5 = "#5a524c",
  bg_statusline1 = "#32302f",
  bg_statusline2 = "#3a3735",
  bg_statusline3 = "#504945",
  bg_diff_green = "#34381b",
  bg_visual_green = "#3b4439",
  bg_diff_red = "#402120",
  bg_visual_red = "#4c3432",
  bg_diff_blue = "#0e363e",
  bg_visual_blue = "#374141",
  bg_visual_yellow = "#4f422e",
  bg_current_word = "#3c3836",
}

require("aiko.colors").paint(colorscheme)