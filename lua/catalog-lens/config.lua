---@class catalog-lens.config: catalog-lens.Config
local M = {}

M.ns = vim.api.nvim_create_namespace("catalog-lens")

---@class catalog-lens.Config
local defaults = {
  -- Enable the plugin
  enabled = true,
  -- Virtual text style
  virtual_text = {
    prefix = " ",
    hl_group = "Comment",
  },
}

local config = vim.deepcopy(defaults) --[[@as catalog-lens.Config]]
M.augroup = vim.api.nvim_create_augroup("catalog-lens", { clear = true })

---@param opts? catalog-lens.Config
function M.setup(opts)
  config = vim.tbl_deep_extend("force", {}, vim.deepcopy(defaults), opts or {})
end

setmetatable(M, {
  __index = function(_, key)
    return config[key]
  end,
})

return M
