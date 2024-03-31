return {
    bl_loop = {
        order = 1,
        name = "The Loop",
        dollars = 5,
        mult = 2,
        boss = {
            min = 1,
            max = 10
        },
        boss_colour = HEX("aadeed"),
        discovered = true,
        alerted = true
    },
    bl_void = {
        order = 2,
        name = "The Void",
        dollars = 5,
        mult = 2,
        boss = {
            min = 1,
            max = 10
        },
        boss_colour = HEX("9e52b7"),
        discovered = true,
        alerted = true
    },
    bl_final_hammer = {
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
        discovered = true,
        alerted = true
    },
    bl_final_crab = {
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
        discovered = true,
        alerted = true
    }
}