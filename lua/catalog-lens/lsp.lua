local M = {}
local Config = require("catalog-lens.config")

---@param server_path string
function M.setup(server_path)
  vim.lsp.config["catalog_ls"] = {
    cmd = { "node", server_path, "--stdio" },
    filetypes = { "json", "yaml" },
    root_markers = { { "pnpm-workspace.yaml" }, ".git" },
  }

  vim.lsp.enable("catalog_ls")

  local ns = vim.api.nvim_create_namespace("catalog_inlay_hints")

  local color_util = require("catalog-lens.color")

  if Config.useOriginalInlayHint then
    return
  end

  local orig_handler = vim.lsp.handlers["textDocument/inlayHint"]
  vim.lsp.handlers["textDocument/inlayHint"] = function(err, result, ctx, config)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client or client.name ~= "catalog_ls" then
      return orig_handler(err, result, ctx, config)
    end

    vim.api.nvim_buf_clear_namespace(ctx.bufnr, ns, 0, -1)

    if not result then
      return
    end

    for _, hint in ipairs(result) do
      local l = hint.position.line
      local c = hint.position.character

      local label = hint.label
      if type(label) == "table" then
        label = ""
        for _, part in ipairs(hint.label) do
          label = label .. part.value
        end
      end

      ---@type string
      local color = Config.namedCatalogsColors and hint.extraData.color or "#f69220"
      ---@type string
      local catalog = hint.extraData.catalog
      vim.api.nvim_buf_set_extmark(ctx.bufnr, ns, l, c, {
        virt_text = { { label, color_util.ensure_hl(color) } },
        virt_text_pos = "inline",
      })
      if catalog ~= "default" then
        vim.api.nvim_buf_set_extmark(ctx.bufnr, ns, l, c - #catalog, {
          end_col = c,
          hl_group = color_util.ensure_fg_hl(color),
        })
      end
    end
  end
end

return M
