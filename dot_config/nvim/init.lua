-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

----------------------------- P4 configuration ----------------------------------------------
-- Define the Lua function to run `p4 edit`
-- function p4_edit()
--   local current_file = vim.fn.expand("%:p")
--   if current_file ~= "" then
--     vim.cmd("silent !p4 edit " .. current_file)
--     vim.notify("p4 edit " .. current_file)
--   else
--     vim.notify("No file to edit")
--   end
-- end
--
-- function p4_add()
--   local current_file = vim.fn.expand("%:p")
--   if current_file ~= "" then
--     vim.cmd("silent !p4 add " .. current_file)
--     vim.notify("p4 add " .. current_file)
--   else
--     vim.notify("No file to add")
--   end
-- end
--
--
-- -- Create a custom command to run `p4 edit`
-- vim.cmd([[
--   command! P4Add :lua p4_add()
-- ]])
--
-- vim.cmd([[
--   command! P4Edit :lua p4_edit()
-- ]])
--
-- -- Define P4 commands
-- vim.api.nvim_set_keymap("n", "<leader>pa", ":P4Add<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>pe", ":P4Edit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>pd", ":tabnew % | Vp4Diff<CR>", { noremap = true, silent = true })
--
-- -- Trigger an action when trying to save a write-protected file
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",  -- Apply to all files
--   callback = function()
--     local filepath = vim.fn.expand("%:p")
--     if vim.bo.readonly then
--       if string.find(filepath, "/Rebel_Main/") then
--         p4_edit()
--       end
--     end
--     if vim.fn.filereadable(filepath) == 0 then
--       if string.find(filepath, "/Rebel_Main/") then
--         p4_add()
--       end
--     end
--   end,
-- })

----------------------------- P4 configuration ----------------------------------------------

----------------------------- Harpoon setup -------------------------------------------------
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-A-K>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-A-U>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-A-I>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-A-O>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-A-P>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-A-J>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-A-L>", function() harpoon:list():next() end)
----------------------------- Harpoon setup -------------------------------------------------

-- Copy to clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+yg_', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', { noremap = true, silent = true })

-- Paste from clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>P", '"+P', { noremap = true, silent = true })

vim.api.nvim_create_user_command("ReloadConfig", "luafile ~/.config/nvim/init.lua", {})

-- toggle white characters diff
vim.api.nvim_create_user_command("ToggleWhiteDiff", function()
  if string.find(vim.o.diffopt, "iwhiteall") then
    vim.o.diffopt = string.gsub(vim.o.diffopt, "iwhiteall,", "")
    vim.o.diffopt = string.gsub(vim.o.diffopt, ",iwhiteall", "")
    vim.o.diffopt = string.gsub(vim.o.diffopt, "iwhiteall", "")
  else
    vim.o.diffopt = vim.o.diffopt .. ",iwhiteall"
  end
end, {})

vim.api.nvim_create_user_command("SetDiffUnit", function(opts)
  vim.g.DiffUnit = opts.args
end, { nargs = 1 })

vim.api.nvim_set_keymap("n", "<leader>dw", ":ToggleWhiteDiff<CR>", { noremap = true, silent = true })

-- copy current file to clipboard
-- Define the function to copy the file path to clipboard

function copy_filepath_to_clipboard()
  vim.cmd("let @+=expand('%:p')")
end
 
-- Set the keybinding
vim.api.nvim_set_keymap('n', '<leader>fy', ':lua copy_filepath_to_clipboard()<CR>', {noremap = true, silent = true})

-- Keybinding to exit insert mode
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'kj', '<Esc>', {noremap = true, silent = true})

-- keybind to open all quickfix entries
vim.api.nvim_set_keymap('n', '<leader>oq', ':silent cfdo %<CR>', {noremap = true, silent = true})

-- tab indentation options
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.opt.cinoptions = {'N0', 'g0'} -- Indentation options for C code
