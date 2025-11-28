local api = require("catalog-lens.api")
local config = require("catalog-lens.config")
local lsp = require("catalog-lens.lsp")

local M = {}

--Create user commands belongs to this plugin
local function create_user_commands()
  vim.api.nvim_create_user_command("CatalogLensEnable", api.enable, { desc = "Enable Catalog Lens" })
  vim.api.nvim_create_user_command("CatalogLensDisable", api.disable, { desc = "Disable Catalog Lens" })
  vim.api.nvim_create_user_command("CatalogLensToggle", api.toggle, { desc = "Toggle Catalog Lens" })
end

--Expose API functions
local function expose_api_functions()
  function M.enable()
    api.enable()
  end

  function M.disable()
    api.disable()
  end

  function M.toggle()
    api.toggle()
  end
end

---Setup catalog-lens
---@param opts? catalog-lens.Config
function M.setup(opts)
  config.setup(opts)

  local server_paths = vim.api.nvim_get_runtime_file("catalog-lens-lsp/server.js", false)[1]
  lsp.setup(server_paths)

  if not config.enabled then
    api.disable()
  end

  expose_api_functions()
  create_user_commands()
end

return M
