-- This file provides the default configuration for the 'odoo_ls' server.
local util = require("lspconfig.util")

local odoo_ls_locations = {
    vim.fn.expand('$HOME/.local/share/nvim/odoo/odoo_ls_server'),
    "odoo_ls_server"
}

local executable = ''

for _, location in ipairs(odoo_ls_locations) do
    if vim.fn.executable(location) == 1 then
        executable = location
    end
end

return {
    cmd = {executable},
    filetypes = { 'python', 'xml' },
    settings = {
        Odoo = {
            selectedProfile = 'main',
        }
    },
    root_dir = util.root_pattern(".git"),

    on_init = function(_, config)
        local cmd = config.cmd

        local cfg = config.config or {}

        if cfg.config_path then
            table.insert(cmd, "--config-path")
            table.insert(cmd, cfg.config_path)
        end

        if cfg.stdlib then
            table.insert(cmd, "--stdlib")
            table.insert(cmd, cfg.stdlib)
        end
    end
}
