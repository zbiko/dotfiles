return{
    "nvim-lualine/lualine.nvim",
    opts = {
        sections = {
            lualine_c = {
                LazyVim.lualine.root_dir(),
                {
                    "diagnostics",
                    symbols = {
                        error = LazyVim.config.icons.diagnostics.Error,
                        warn = LazyVim.config.icons.diagnostics.Warn,
                        info = LazyVim.config.icons.diagnostics.Info,
                        hint = LazyVim.config.icons.diagnostics.Hint,
                    },
                },
                { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                { LazyVim.lualine.pretty_path({length=9})},
            },
            lualine_b = {
                {
                    function()
                        local file_path = vim.fn.expand('%:p')
                        -- check if file_path is in global map value p4_opened_files
                        if not vim.g.opened_files_printed then
                            print(vim.inspect(vim.g.perfnvim_p4_opened_files))
                            vim.g.opened_files_printed=true;
                        end
                        if not vim.g.perfnvim_p4_opened_files then
                            return " "
                        end
                        if vim.g.perfnvim_p4_opened_files[file_path] then
                            local changelist = vim.g.perfnvim_p4_opened_files[file_path]
                            if changelist == "default" then
                                return  " # DEFAULT "
                            end
                            local changelist_desc = vim.g.perfnvim_p4_changelists[changelist]
                            local truncated_desc = changelist_desc:match("^(.-)  ") or changelist_desc
                            return  " # " .. changelist .. " -> " .. truncated_desc
                        else
                            return " "
                        end
                    end
                }
            },
        },
    }
}
