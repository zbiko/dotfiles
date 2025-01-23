return {
  {
    "akinsho/bufferline.nvim",
    after = "catppuccin",
    config = function()
      require("bufferline").setup {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options ={
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer" ,
              text_align =  "center" ,
              separator = true
            }
          }
        }
      }
    end,
  },
}
