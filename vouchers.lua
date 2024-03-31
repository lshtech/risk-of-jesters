return {
    v_3d_printer = {
        order = 1,
        name = "3D Printer",
        config = {
            extra = 1
        },
        cost = 10,
        unlocked = true,
        discovered = true,
    },
    v_militech_printer = {
        order = 2,
        name = "Mili-Tech Printer",
        config = {
            extra = 1
        },
        requires = {
            "v_3d_printer"
        },
        cost = 10,
        unlocked = true,
        discovered = true
    }
}