# catalog-len.nvim

Show inlay version and go-to-definition for PNPM/Yarn/Bun catalogs.

## ✨ Features

- Show inline version information for package catalogs
- Go-to-definition support for catalog entries
- Works with PNPM, Yarn, and Bun catalogs

## ⚡️ Requirements

- Neovim >= 0.10.0

## 📦 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "Daydreamer-riri/catalog-len.nvim",
  opts = {},
}
```

## ⚙️ Configuration

**catalog-len.nvim** comes with the following defaults:

```lua
{
  -- Enable the plugin
  enabled = true,
  -- Debounce time in milliseconds for virtual text updates
  debounce = 200,
  -- Virtual text style
  virtual_text = {
    prefix = " ",
    hl_group = "Comment",
  },
}
```

## 🚀 Usage

The plugin will automatically detect package catalogs and show inline
version information.

## 📝 License

MIT
