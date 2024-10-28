SMODS.Atlas({
    key = "loop",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21,
    path = "bl_loop.png",
    px = 34,
    py = 34
})
SMODS.Blind{
    key = 'loop',
    loc_txt = {
        name = "The Loop",
        text = {
            "Random Joker disabled",
            "after playing 2 hands"
        }
    },
    boss = {min = 3},
    boss_colour = HEX("aadeed"),
    discovered = false,
    alerted = true,
    pos = {x = 0, y = 0},
    atlas = 'loop',
    dollars = 5,
    mult = 2,
    drawn_to_hand = function(self)
        if G.GAME.current_round.hands_played > 0 and math.fmod(G.GAME.current_round.hands_played,2) == 0 and #G.jokers.cards > 0 then
            local jokers = {}
            for _, v in ipairs(G.jokers.cards) do
                table.insert(jokers, v)
            end
            local card = pseudorandom_element(jokers, pseudoseed("the_loop"))
            if card then
                card:set_debuff(true)
                card:juice_up()
                G.GAME.blind:wiggle()
            end
        end
    end,
}

SMODS.Atlas({
    key = "void",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21,
    path = "bl_void.png",
    px = 34,
    py = 34
})
SMODS.Blind{
    key = 'void',
    loc_txt = {
        name = "The Void",
        text = {
            "Set all Jokers' sell",
            "value to 0 when defeated"
        }
    },
    boss = {
        min = 1,
        max = 10
    },
    boss_colour = HEX("9e52b7"),
    discovered = false,
    alerted = true,
    pos = {x = 0, y = 0},
    atlas = 'void',
    dollars = 5,
    mult = 2,
    defeat = function(self)
        if not G.GAME.blind.disabled then
            for i,_ in ipairs(G.jokers.cards) do
                G.jokers.cards[i].sell_cost = 0
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind:wiggle()
                        return true
                    end
                }))
            end
            return {
                message = localize("k_voided_ex")
            }
        end
    end,
}

SMODS.Atlas({
    key = "final_hammer",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21,
    path = "bl_final_hammer.png",
    px = 34,
    py = 34
})
SMODS.Blind{
    key = 'final_hammer',
    loc_txt = {
        name = "Glaucous Hammer",
        text = {
            "Start with random half",
            "of the deck debuffed",
        }
    },
    boss = {
        showdown = true,
        min = 10,
        max = 10
    },
    boss_colour = HEX("6082b6"),
    discovered = false,
    alerted = true,
    pos = {x = 0, y = 0},
    atlas = 'final_hammer',
    dollars = 8,
    mult = 2,
    vars = {
        1.05
    },
    set_blind = function(self, reset, silent)
        if not reset then
            local cards = {}
            for _, v in ipairs(G.playing_cards) do
                table.insert(cards, v)
            end

            table.sort(cards, function (a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
            pseudoshuffle(cards, pseudoseed("glaucous"))

            for i = 1, math.floor(#G.playing_cards * 0.5) do
                cards[i].ability.hammered = true
            end

            for _, v in ipairs(G.playing_cards) do
                self:debuff_card(v)
            end
        end
    end,
    debuff_card = function(self, card, from_blind)
        if not G.GAME.blind.disabled and card.area ~= G.jokers and card.ability.hammered then
            card:set_debuff(true)
            return true
        end
        return false
    end,
}

SMODS.Atlas({
    key = "final_crab",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21,
    path = "bl_final_crab.png",
    px = 34,
    py = 34
})
SMODS.Blind{
    key = 'final_crab',
    loc_txt = {
        name = "Tyrian Crab",
        text = {
            "X1.5 required Chips",
            "after each hand played",
        }
    },
    boss = {
        showdown = true,
        min = 10,
        max = 10
    },
    boss_colour = HEX("cb75e3"),
    discovered = false,
    alerted = true,
    pos = {x = 0, y = 0},
    atlas = 'final_crab',
    dollars = 8,
    mult = 2,
    vars = {
        1.5
    },
    set_blind = function(self, reset, silent)
        G.GAME.blind.prepped = nil
    end,
    press_play = function(self)
        if not G.GAME.blind.disabled then
            G.GAME.blind.prepped = true
        end
    end,
    drawn_to_hand = function(self)
        if not G.GAME.blind.disabled and G.GAME.blind.prepped then
            ease_required_chips(G.GAME.blind.chips * 1.5)
            G.GAME.blind:wiggle()
        end
    end,
    disable = function(self)
        ease_required_chips(get_blind_amount(G.GAME.round_resets.ante) * G.GAME.blind.mult * G.GAME.starting_params.ante_scaling)
    end
}

function ease_required_chips(mod)
    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            local chip_UI = G.hand_text_area.blind_chips

            G.E_MANAGER:add_event(Event({
                trigger = "ease",
                blockable = false,
                ref_table = G.GAME.blind,
                ref_value = "chips",
                ease_to = mod or 0,
                delay = 0.3,
                func = function(t)
                    local val = math.floor(t)
                    G.GAME.blind.chip_text = number_format(val)

                    return val
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.5,
                blockable = false,
                func = function()
                    save_run()

                    return true
                end
            }))

            chip_UI:juice_up()

            return true
        end
      }))
end