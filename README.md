# Neovim

Neovim client for the Odools language server

![screenshot](https://i.imgur.com/wuqsF9q.png)

## Important ⚠️
This plugin is still in its early development stage. Don't hesitate to submit bugs, issues and/or
feedbacks to improve the user experience.

This repository give some snippet example to make the [odoo-ls](https://github.com/odoo/odoo-ls)
working inside Neovim.

This will later become a true plugin managing the download of the server executable and dependencies

## Requirements
We recommend using nvim version `0.11.0` or later to benefit from the builtin lsp config helpers.
Working with `< 0.11` will require installing [lspconfig](https://github.com/neovim/nvim-lspconfig)

## Configs

There are 2 configuration parts needed. One for the server directly, and one for neovim. This
later should be integrated in the future plugin.

### odools.toml
 ```toml
name = "main"
odoo_path = "odoo"
addons_path = ["/home/user/src/enterprise"]
python_path = "/home/user/.pyenv/shims/python"
additional_stubs = ["/home/user/.local/nvim/odoo/typeshed/stubs"]
```

### nvim

The server need a bit of configuration to work smothly with neovim. Here is the minimal suggested config.

```lua
-- Defined in <rtp>/lsp/odools.lua
local server = '/home/user/.local/share/nvim/odoo/odoo_ls_server'
-- Get the default client capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Add your custom capability
capabilities.general.markdown = {
  parser = 'marked',
  version = ''
}
return {
  cmd = {server, '--stdlib', vim.fn.fnamemodify(server, ':h') .. '/typeshed/stdlib'},
  root_dir = '/home/whe/.local/share/nvim/odoo',
  filetypes = { 'python' },
  workspace_folders = {{
      uri = vim.uri_from_fname('/home/whe/src'),
      name = 'main_folder',
  }},
  capabilities = capabilities,
  settings = {
      Odoo = {
          selectedProfile = 'main',
      }
  },
}
```
