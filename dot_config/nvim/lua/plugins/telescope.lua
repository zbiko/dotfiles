return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
        "nvim-telescope/telescope-live-grep-args.nvim" ,
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
    },
  },

  opts = function(_, opts)
    local lga_actions = require("telescope-live-grep-args.actions")
    opts.extensions = {
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ["<C-K>"] = lga_actions.quote_prompt(),
            ["<C-I>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      },
    };
    opts.defaults = {
            shorten_path = false,
      path_display = { "truncate" },
    }
  end,
  keys = {
    {
      "<leader>sC",
      -- telescope function to search only in *.cpp *.h and *.cu files
      function()
        require("telescope.builtin").live_grep({
          prompt_title = "CPP/CUDA Search in Rebel_Main",
          glob_pattern = {'*.c','*.cpp','*.h','*.cu'},
          search_dirs = { "~/p4/zk-linux/sw/devtools/Agora/Dev/Rebel_Main/" },
        })
      end,
      desc = "Search CPP/CUDA Files in Rebel_Main",
    },
    {
      "<leader>so",
      -- telescope function to use live_grep_args
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      desc = "Grep (root dir) with live_grep_args",
    },
  },

  -- require("telescope.builtin").find_files{ path_display = { "truncate" } }

  -- change some options
  --opts = {
  --  defaults = {
  --    layout_strategy = "horizontal",
  --    layout_config = { prompt_position = "top" },
  --    sorting_strategy = "ascending",
  --    winblend = 0,
  --  },
  --}
}
