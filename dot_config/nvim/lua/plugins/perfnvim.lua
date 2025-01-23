return{
    {
        "zbiko/perfnvim",
        branch = 'update-global-values',
        config = function()
            require("perfnvim").setup()
            vim.keymap.set("n", "<leader>pa", function() require("perfnvim").P4add() end, { noremap = true, silent = true, desc = "'p4 add' current buffer" })
            vim.keymap.set("n", "<leader>pe", function() require("perfnvim").P4edit() end, { noremap = true, silent = true, desc = "'p4 edit' current buffer" })
            vim.keymap.set("n", "<leader>pR", ":!p4 revert -a %<CR>", { noremap = true, silent = true, desc = "Revert if unchanged" })
            vim.keymap.set("n", "]p", function() require("perfnvim").P4next() end, { noremap = true, silent = true, desc = "Jump to next changed line" })
            vim.keymap.set("n", "[p", function() require("perfnvim").P4prev() end, { noremap = true, silent = true, desc = "Jump to previous changed line" })
            vim.keymap.set("n", "<leader>po", function() require("perfnvim").P4opened() end, { noremap = true, silent = true, desc = "List opened files" })
            vim.keymap.set("n", "<leader>pE", function() require("perfnvim").P4enable() end, { noremap = true, silent = true, desc = "Enable perfnvim worker" })
            vim.keymap.set("n", "<leader>pD", function() require("perfnvim").P4disable() end, { noremap = true, silent = true, desc = "Disable perfnvim worker" })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        event = "VeryLazy",
        dependencies = { "zbiko/perfnvim" },
        opts = function(_, opts)
        table.insert(
            opts.sections.lualine_x,
            2,
            LazyVim.lualine.status(LazyVim.config.icons.kinds.Control, function()
                if vim.g.perfnvim_p4_changelists == nil then
                    return "error"
                end
                return (vim.g.perfnvim_thread_running and "pending") or (next(vim.g.perfnvim_p4_changelists) == nil and "error") or "ok"
            end)
        )
        end,
    },
}
