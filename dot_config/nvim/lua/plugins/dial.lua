return {
    "monaqa/dial.nvim",
    keys = {
        -- {"<C-A>", false, mode = "n,v"},
        -- {"g<C-A>", true, mode = "n,v"},
        -- {"<C-X>", false, mode = "n,v"},
        -- {"g<C-X>", false, mode = "n,v"},
        {
            "<C-b>",
            function()
                require("dial.map").manipulate("increment", "normal")
            end,
            desc = "Increment under the cursor",
        },
        {
            "<C-x>",
            function()
                require("dial.map").manipulate("decrement", "normal")
            end,
            desc = "Decrement under the cursor",
        },
    },
    opts = function ()
        local augend = require("dial.augend")

        local ordinal_numbers = augend.constant.new({
            -- elements through which we cycle. When we increment, we go down
            -- On decrement we go up
            elements = {
            "first",
            "second",
            "third",
            "fourth",
            "fifth",
            "sixth",
            "seventh",
            "eighth",
            "ninth",
            "tenth",
            },
            -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
            word = false,
            -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
            -- Otherwise nothing will happen when there are no further values
            cyclic = true,
        })
        local weekdays = augend.constant.new({
            elements = {
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday",
            },
            word = true,
            cyclic = true,
        })

        local months = augend.constant.new({
            elements = {
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
            },
            word = true,
            cyclic = true,
        })

        local boolean = augend.constant.new({
            elements = {
            "true",
            "false",
            },
            word = true,
            cyclic = true,
        })


        local yesno = augend.constant.new({
            elements = {
            "yes",
            "no",
            },
            word = true,
            cyclic = true,
        })

        local yesno_capital = augend.constant.new({
            elements = {
            "YES",
            "NO",
            },
            word = true,
            cyclic = true,
        })

        return {
            groups = {
                default = {
                    augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                    augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
                    ordinal_numbers,
                    weekdays,
                    months,
                    boolean,
                    yesno,
                    yesno_capital,
                },
            },
        }
    end

}
