local blinds = {
    {
        slug = "loop",
        order = 1,
        name = "The Loop",
        dollars = 5,
        mult = 2,
        boss = {
            min = 1,
            max = 10
        },
        boss_colour = HEX("aadeed"),
        discovered = false,
        alerted = true
    },
    {
        slug = "void",
        order = 2,
        name = "The Void",
        dollars = 5,
        mult = 2,
        boss = {
            min = 1,
            max = 10
        },
        boss_colour = HEX("9e52b7"),
        discovered = false,
        alerted = true
    },
    {
        slug = "final_hammer",
        order = 3,
        name = "Glaucous Hammer",
        dollars = 8,
        mult = 2,
        vars = {
            1.05
        },
        boss = {
            showdown = true,
            min = 10,
            max = 10
        },
        boss_colour = HEX("6082b6"),
        discovered = false,
        alerted = true
    },
    {
        slug = "final_crab",
        order = 4,
        name = "Tyrian Crab",
        dollars = 8,
        mult = 2,
        vars = {
            1.5
        },
        boss = {
            showdown = true,
            min = 10,
            max = 10
        },
        boss_colour = HEX("cb75e3"),
        discovered = false,
        alerted = true
    }
}

table.sort(blinds, function (a, b) return a.order < b.order end)

return blinds