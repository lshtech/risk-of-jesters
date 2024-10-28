SMODS.Atlas {
    key = "3d_printer",
    path = "v_3d_printer.png",
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}
local printer1 = SMODS.Voucher {
    key = '3d_printer',
    loc_txt = {
        name = "3D Printer",
        text = {
            "All {C:attention}Booster Packs",
            "have {C:attention}1{} more option"
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = 1
    },
    cost = 10,
    discovered = true,
    redeem = function(self)
    end,
    atlas = "3d_printer"
}

SMODS.Atlas {
    key = "militech_printer",
    path = "v_militech_printer.png",
    px = 71,
    py = 95,
    atlas_table = 'ASSET_ATLAS',
}
local printer2 = SMODS.Voucher {
    key = 'militech_printer',
    loc_txt = {
        name = "Mili-Tech Printer",
        text = {
            "Can choose {C:attention}1{} more",
            "card from all",
            "{C:attention}Booster Packs"
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = 1
    },
    requires = {
        "v_3d_printer"
    },
    cost = 10,
    discovered = true,
    redeem = function(self)
    end,
    atlas = "militech_printer"
}


local card_openref = Card.open
function Card:open()
    card_openref(self)
    if self.ability.set == "Booster" then
        if G.GAME.used_vouchers[printer1.key] then
            G.GAME.pack_choices = G.GAME.pack_choices + 1
        end
        if G.GAME.used_vouchers[printer2.key] then
            G.GAME.pack_choices = G.GAME.pack_choices + 1
        end
    end
end