local config = require("catalog-lens.config")

local M = {}

function M.enable()
  config.enabled = true
  vim.lsp.enable("catalog_ls", true)
end

function M.disable()
  config.enabled = false
  vim.lsp.enable("catalog_ls", false)
end

function M.toggle()
  if config.enabled then
    M.disable()
  else
    M.enable()
  end
end

return M
