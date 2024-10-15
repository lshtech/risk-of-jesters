local function printer_redeem(center_table)
    if center_table.name == "3D Printer" or center_table.name == "Mili-Tech Printer" then
        G.GAME.pack_choices = G.GAME.pack_choices + 1
    end
end

local vouchers = {
    {
        slug = "3d_printer",
        order = 1,
        name = "3D Printer",
        config = {
            extra = 1
        },
        cost = 10,
        unlocked = true,
        discovered = false,
        redeem = printer_redeem
    },
    {
        slug = "militech_printer",
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
        discovered = false,
        redeem = printer_redeem
    }
}

table.sort(vouchers, function (a, b) return a.order < b.order end)

return vouchers