-- This file provides the default configuration for the 'odoo_ls' server.

local odoo_ls_locations = {vim.fn.expand('$HOME/.local/share/nvim/odoo/odoo_ls_server')}

local executable = ''
if vim.fn.executable('odoo_ls_server') then
    executable = 'odoo_ls_server'
end


for _, location in ipairs(odoo_ls_locations) do
    local file = io.open(location, "r")
    if file ~= nil then
        io.close(file)
        executable = location
    end
end

return {
    cmd = {
        executable,
    },
    filetypes = { 'python' },
    workspace_folders = { {
        uri = vim.uri_from_fname(vim.fn.getcwd()),
        name = 'main_folder'
    } },
    settings = {
        Odoo = {
            selectedProfile = 'main',
        }
    },
}
