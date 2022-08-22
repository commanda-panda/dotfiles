local modules = require("aiko.ui.statusline.modules")

local M = {}

M.statusline = function()
  return table.concat({
    modules.mode(),
    modules.file_info(),
    modules.git(),
    "%=",
    modules.lsp_progress(),
    "%=",
    modules.lsp_diagnostics(),
    modules.lsp_status(),
    modules.cwd(),
    modules.cursor_position(),
  })
end

M.winbar = function()
  return table.concat({
    modules.file_info(),
    modules.lsp_location(),
    "%=",
    modules.filetype(),
  })
end

M.tabline = function()
  return table.concat({
    modules.tablist(),
    "%=",
  })
end

return M
