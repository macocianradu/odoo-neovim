local M = {}

M.base_url = "https://api.github.com/repos/odoo/odoo-ls/releases"
M.download_url = "https://github.com/odoo/odoo-ls/releases/download"

function M.get_latest_release(callback)
    vim.system({'curl', '-sL', M.base_url .. '/latest'}, { text = true }, function(out)
        vim.schedule(function()
            if out.code ~= 0 or not out.stdout then
                callback(nil, "Curl request failed")
                return
            end

            local ok, parsed = pcall(vim.fn.json_decode, out.stdout)
            if ok and parsed and parsed.tag_name then
                callback(parsed.tag_name)
            else
                callback(nil, "Failed to parse JSON")
            end
        end)
    end)
end

function M.download_asset(url, output, callback)
    vim.system({'curl', '-sL', '-o', output, url}, {}, function(out)
        vim.schedule(function()
            callback(out.code == 0)
        end)
    end)
end

return M
