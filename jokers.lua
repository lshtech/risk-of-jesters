SMODS.Atlas {
    key = "egocentrism",
    atlas_table = "ASSET_ATLAS",
    path = "j_egocentrism.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'egocentrism',
	loc_txt = {
        name = "Egocentrism",
        text = {
            "{C:chips}+#1#{} Chips for each",
            "{C:attention}Egocentrism{}. Convert a",
            "random {C:attention}Joker{} into {C:attention}Egocentrism",
            "when {C:attention}Blind{} is selected",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
        }
	},
    config = {
        extra = 40
    },
    rarity = 1,
    cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'egocentrism',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        local count = 0

        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.set == "Joker" and joker.config.center.key == "j_roj_egocentrism" then
                    count = count + 1
                end
            end
        end

        return { vars =  {card.ability.extra, count * card.ability.extra}}
    end,
	calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local convertables = {}
            local egocentrisms = {}
            for _, v in ipairs(G.jokers.cards) do
                if not v.getting_sliced then
                    table.insert(v.config.center.key == "j_roj_egocentrism" and egocentrisms or convertables, v)
                end
            end

            if #convertables > 0 and not (context.blueprint_card or card).getting_sliced then
                local joker = pseudorandom_element(convertables, pseudoseed("egocentrism"))
                joker.getting_sliced = true

                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new = copy_card(egocentrisms[1], nil, nil, nil)

                        card:juice_up(0.8, 0.8)

                        new:set_edition(joker.edition, true)
                        joker:start_dissolve({HEX("4d97cb")}, nil, 1.6)
                        new:start_materialize()
                        new:add_to_deck()
                        G.jokers:emplace(new)

                        return true
                    end
                }))

                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_converted_ex")
                })
            end
        elseif context.joker_main then
            local count = 0

            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.set == "Joker" and joker.config.center.key == "j_roj_egocentrism" then
                    count = count + 1
                end
            end

            return {
                message = localize{
                    type = "variable",
                    key = "a_chips",
                    vars = {
                        card.ability.extra * count
                    }
                },
                chip_mod = card.ability.extra * count
            }
        end
	end
}

SMODS.Atlas {
    key = "eulogy",
    atlas_table = "ASSET_ATLAS",
    path = "j_eulogy.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'eulogy',
	loc_txt = {
        name = "Eulogy Zero",
        text = {
            "{C:attention}Shop{} cards have {C:green}#1# in #2#",
            "chance of being {C:attention}half",
            "{C:attention}price{} and {C:attention}flipped"
        }
	},
    config = {
        extra = 2
    },
    rarity = 2,
    cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'eulogy',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars =  { ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra }}
    end,
}

SMODS.Atlas {
    key = "bungus",
    atlas_table = "ASSET_ATLAS",
    path = "j_bungus.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'bungus',
	loc_txt = {
        name = "Bustling Fungus",
        text = {
            "After {C:attention}#1#{} rounds, add",
            "{C:dark_edition}Foil{} to base edition",
            "Jokers on both sides",
            "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
        }
	},
    config = {
        extra = 5
    },
    rarity = 1,
    cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'bungus',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        return { vars =  { card.ability.extra, card.ability.bungus_rounds }}
    end,
	calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint
        and not card.getting_sliced then
            card.ability.bungus_rounds = card.ability.bungus_rounds + 1
            if card.ability.bungus_rounds == card.ability.extra then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local pos = nil
                        for i, v in ipairs(G.jokers.cards) do
                            if v == card then
                                pos = i
                                break
                            end
                        end

                        if not pos then
                            return
                        end

                        card:juice_up(0.8, 0.8)

                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                if G.jokers.cards[pos - 1] and not G.jokers.cards[pos - 1].edition then
                                    G.jokers.cards[pos - 1]:set_edition({foil = true}, true)
                                end
                                if G.jokers.cards[pos + 1] and not G.jokers.cards[pos + 1].edition then
                                    G.jokers.cards[pos + 1]:set_edition({foil = true}, true)
                                end

                                return true
                            end
                        }))

                        return true
                    end
                }))
            end

            if card.ability.bungus_rounds <= card.ability.extra then
                return {
                    message = card.ability.bungus_rounds < card.ability.extra and card.ability.bungus_rounds.."/"..card.ability.extra or localize("k_active_ex"),
                    colour = G.C.FILTER
                }
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.bungus_rounds = 0
    end
}

SMODS.Atlas {
    key = "snake_eyes",
    atlas_table = "ASSET_ATLAS",
    path = "j_snake_eyes.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'snake_eyes',
	loc_txt = {
        name = "Snake Eyes",
        text = {
            "Gains {C:mult}+#1#{} Mult if",
            "{C:tarot}The Wheel of Fortune{} fails",
            "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)"
        }
	},
    config = {
        extra = {
            mult = 2,
            mult_mod = 6
        }
    },
    rarity = 1,
    cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'snake_eyes',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars =  { card.ability.extra.mult_mod, card.ability.extra.mult }}
    end,
	calculate = function(self, card, context)
        if context.wheel_failed then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            G.E_MANAGER:add_event(Event({
                func = function()
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize("k_upgrade_ex")
                    })

                    return true
                end
            }))
        elseif context.joker_main then
            return {
                message = localize{
                    type = "variable",
                    key = "a_mult",
                    vars = {
                        card.ability.extra.mult
                    }
                },
                mult_mod = card.ability.extra.mult
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
    end
}

SMODS.Atlas {
    key = "daisy",
    atlas_table = "ASSET_ATLAS",
    path = "j_daisy.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'daisy',
	loc_txt = {
        name = "Lepton Daisy",
        text = {
            "{C:chips}+#1#{} Chips for each",
            "{C:attention}debuffed{} card",
            "in played hand",
        }
	},
    config = {
        extra = 50
    },
    rarity = 2,
    cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'daisy',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars =  { card.ability.extra }}
    end,
	calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            local count = 0
            for _, v in pairs(context.full_hand) do
                if v.debuff then
                    count = count + 1
                end
            end

            if count > 0 then
                return {
                    message = localize{
                        type = "variable",
                        key = "a_chips",
                        vars = {
                            card.ability.extra * count
                        }
                    },
                    chip_mod = card.ability.extra * count
                }
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
    end
}

SMODS.Atlas {
    key = "kjaro",
    atlas_table = "ASSET_ATLAS",
    path = "j_kjaro.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'kjaro',
	loc_txt = {
        name = "Kjaro's Band",
        text = {
            "{X:mult,C:white} X#1# {} Mult if Chips",
            "scored in last round",
            "were more than {C:attention}X#2#",
            "of required Chips"
        }
	},
    config = {
        extra = {
            Xmult = 4,
            required = 4
        }
    },
    rarity = 2,
    cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'kjaro',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        if G.GAME and card.area and card.area == G.jokers then
            main_end = {
                {n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
                    {n=G.UIT.C, config={ref_table = card, align = "m", colour = card.ability.enabled and G.C.GREEN or G.C.RED, r = 0.05, padding = 0.06}, nodes={
                        {n=G.UIT.T, config={text = ' '..localize(card.ability.enabled and "k_active" or "ph_kjaro_disabled").." ",colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.9}},
                    }}
                }}
            }
        end
        return { vars =  { card.ability.extra.Xmult, card.ability.extra.required }}
    end,
	calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint
        and not (context.blueprint_card or card).getting_sliced then
            if G.GAME.chips >= G.GAME.blind.chips * 4 then
                if not card.ability.enabled then
                    card.ability.enabled = true
                    juice_card_until(card, function(card)
                        return card.ability.enabled
                    end, true)
                end

                return {
                    message = localize("k_active_ex"),
                    colour = G.C.FILTER
                }
            else
                card.ability.enabled = false
            end
        elseif context.joker_main and card.ability.enabled then
            return {
                message = localize{
                    type = "variable",
                    key = "a_xmult",
                    vars = {
                        card.ability.extra.Xmult
                    }
                },
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.enabled = false
    end
}

SMODS.Atlas {
    key = "duplicator",
    atlas_table = "ASSET_ATLAS",
    path = "j_duplicator.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'duplicator',
	loc_txt = {
        name = "Substandard Duplicator",
        text = {
            "When gain a {C:attention}Joker{},",
            "create a {C:dark_edition}Negative",
            "{C:dark_edition}Temporary{} copy of it"
        }
	},
    config = { },
    rarity = 3,
    cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'duplicator',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = {
            key = "temporary",
            set = "Other"
        }
        return { vars =  { }}
    end,
	calculate = function(self, card, context)
        if context.joker_added and not (context.blueprint_card or card).getting_sliced then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local new_card = copy_card(context.added, nil, nil, nil)
                    new_card.ability.temporary = true

                    (context.blueprint_card or card):juice_up(0.8, 0.8)

                    new_card:set_edition({negative = true}, true)
                    new_card:set_eternal(false)
                    new_card:start_materialize()
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)

                    return true
                end
            }))

            card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                message = localize("k_duplicated_ex")
            })
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
    end
}

SMODS.Atlas {
    key = "happiest_mask",
    atlas_table = "ASSET_ATLAS",
    path = "j_happiest_mask.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'happiest_mask',
	loc_txt = {
        name = "Happiest Mask",
        text = {
            "{C:green}#1# in #2#{} chance to create",
            "a random {C:spectral}Spectral{} card",
            "when any card is destroyed",
            "{C:inactive}(Must have room)"
        }
	},
    config = {
        extra = 2
    },
    rarity = 3,
    cost = 9,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'happiest_mask',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars =  { ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra}}
    end,
	calculate = function(self, card, context)
        if context.any_card_destroyed and pseudorandom("happiest") < G.GAME.probabilities.normal / card.ability.extra
        and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
        and not (context.blueprint_card or card).getting_sliced then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.0,
                func = function()
                    local spectral = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "happiest")

                    spectral:add_to_deck()
                    G.consumeables:emplace(spectral)
                    G.GAME.consumeable_buffer = 0

                    return true
                end
            }))

            card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                message = localize("k_plus_spectral"),
                colour = G.C.SECONDARY_SET.Spectral
            })
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
    end
}

SMODS.Atlas {
    key = "benthic",
    atlas_table = "ASSET_ATLAS",
    path = "j_benthic.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'benthic',
	loc_txt = {
        name = "Benthic Bloom",
        text = {
            "Upgrade {C:attention}1{} random {C:attention}Joker{}",
            "into {C:attention}Joker{} of the next",
            "{C:attention}higher rarity{} when",
            "{C:attention}Boss Blind{} is defeated"
        }
	},
    config = { },
    rarity = 3,
    cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'benthic',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars =  { }}
    end,
	calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss
        and not (context.blueprint_card or card).getting_sliced then
            local upgradables = {}
            for _, v in ipairs(G.jokers.cards) do
                if v ~= (context.blueprint_card or card) and not v.getting_sliced and v.config.center.rarity <= 3 then
                    table.insert(upgradables, v)
                end
            end

            if #upgradables > 0 then
                local joker = pseudorandom_element(upgradables, pseudoseed("benthic"))
                local rarity = joker.config.center.rarity
                joker.getting_sliced = true

                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)

                        local new_card = create_card("Joker", G.jokers, rarity == 3, rarity == 1 and 0.9 or 1, nil, nil, nil, "benthic")

                        new_card:set_edition(joker.edition, true)
                        joker:start_dissolve({HEX("bf0ef8")}, nil, 1.6)
                        new_card:start_materialize()
                        new_card:add_to_deck()
                        G.jokers:emplace(new_card)

                        return true
                    end
                }))

                return {
                    message = localize("k_upgrade_ex")
                }
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
    end
}

SMODS.Atlas {
    key = "encrusted",
    atlas_table = "ASSET_ATLAS",
    path = "j_encrusted.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'encrusted',
	loc_txt = {
        name = "Encrusted Key",
        text = {
            "After defeating the",
            "{C:attention}Boss Blind{}, this card",
            "is destroyed and gain",
            "a {C:attention}#1#"
        }
	},
    config = { },
    rarity = 1,
    cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'encrusted',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {
            key = "tag_coupon",
            set = "Tag"
        }
        return { vars = {localize{type = "name_text", set = "Tag", key = "tag_coupon", nodes = {}}}}
    end,
	calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss
        and not (context.blueprint_card or card).getting_sliced then
            card.getting_sliced = true

            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag("tag_coupon"))
                    play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)

                    play_sound("tarot1")
                    card.T.r = -0.2
                    (context.blueprint_card or card):juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true

                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            card = nil

                            return true
                        end
                    }))

                    return true
                end
            }))
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
    end
}

SMODS.Atlas {
    key = "executive_card",
    atlas_table = "ASSET_ATLAS",
    path = "j_executive_card.png",
    px = 71,
    py = 95
}
SMODS.Joker {
	key = 'executive_card',
	loc_txt = {
        name = "Executive Card",
        text = {
            "After opening",
            "{C:attention}#1# Booster Packs{},",
            "can choose all cards",
            "from next one",
            "{C:inactive}#2#"
        }
	},
    config = {
        extra = 6
    },
    rarity = 2,
    cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat=true,
	atlas = 'executive_card',
	pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra, localize{
            type = "variable",
            key = card.ability.executive_remaining == 0 and "loyalty_active" or "loyalty_inactive",
            vars = {card.ability.executive_remaining}
        }}}
    end,
	calculate = function(self, card, context)
        if context.open_booster and not context.blueprint then -- this context is called after the booster pack is all set up
            card.ability.executive_remaining = card.ability.executive_remaining - 1
    
            if card.ability.executive_remaining == 0 then -- prepared
                juice_card_until(card, function(card) return card.ability.executive_remaining == 0 end, true)
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_active_ex"),
                    colour = G.C.FILTER
                })
            elseif card.ability.executive_remaining < 0 then -- used
                card.ability.executive_remaining = card.ability.extra
                G.GAME.pack_choices = G.GAME.pack_size
            else
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = card.ability.executive_remaining.."/"..card.ability.extra,
                    colour = G.C.FILTER
                })
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.executive_remaining = card.ability.extra
    end
}

local create_card_for_shop_ref = create_card_for_shop
function create_card_for_shop(area)
    local card = create_card_for_shop_ref(area)
    local eulogy = find_joker("j_roj_eulogy")

    if #eulogy > 0 and pseudorandom("eulogy") < G.GAME.probabilities.normal / eulogy[1].ability.extra then
        card.ability.eulogyed = true
    end

    return card
end

local attention_text_ref = attention_text
function attention_text(args)
    attention_text_ref(args)

    if args.text and args.text == localize("k_nope_ex") and args.major and args.major.ability.name == 'The Wheel of Fortune' then
        for _, v in ipairs(G.jokers.cards) do
            v:calculate_joker({
                wheel_failed = true
            })
        end
    end
end

local copy_card_ref = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
    local new = copy_card_ref(other, new_card, card_scale, playing_card, strip_edition)

    if new.ability.bungus_rounds then
        new.ability.bungus_rounds = 0
    elseif new.ability.enabled then
        new.ability.enabled = false
    elseif new.ability.executive_remaining then
        new.ability.executive_remaining = new.ability.extra
    end

    return new
end

local add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    add_to_deck_ref(self, from_debuff)

    if self.ability.set == "Joker" and not self.ability.temporary then
        for _, v in ipairs(G.jokers.cards) do
            v:calculate_joker({
                joker_added = true,
                added = self
            })
        end
    end
end

local calculate_joker_ref = Card.calculate_joker
function Card:calculate_joker(context)
    if self.ability.set == "Joker" and context.end_of_round and not context.individual and not context.repetition then
        if self.ability.temporary then
            self.getting_sliced = true

            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    self.T.r = -0.2
                    self:juice_up(0.3, 0.4)
                    self.states.drag.is = true
                    self.children.center.pinch.x = true

                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(self)
                            self:remove()
                            self = nil

                            return true
                        end
                    }))

                    return true
                end
            }))

            return {
                message = localize("k_broken_ex")
            }
        end
    end

    return calculate_joker_ref(self, context)
end

local remove_from_deck_ref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    local flag = (self.added_to_deck and not self.ability.consumable_used and not self.ability.sold) or (G.playing_cards and self.playing_card) and G.jokers

    remove_from_deck_ref(self, from_debuff)

    if flag then
        for _, v in ipairs(G.jokers.cards) do
            if v ~= self then
                v:calculate_joker({
                    any_card_destroyed = true,
                    card = self
                })
            end
        end
    end

end

-- Flag if the card is consumable and used to properly check Happiest Mask's ability
local use_consumeable_ref = Card.use_consumeable
function Card:use_consumeable(area, copier)
    if not self.debuff then
        self.ability.consumable_used = true
    end

    use_consumeable_ref(self, area, copier)
end

-- Same here
local sell_card_ref = Card.sell_card
function Card:sell_card()
    self.ability.sold = true

    sell_card_ref(self)
end

local set_cost_ref = Card.set_cost
function Card:set_cost()
    set_cost_ref(self)

    if self.ability.temporary then
        self.sell_cost = 0
    elseif self.ability.eulogyed then
        self.cost = math.floor(self.cost * 0.5)
        self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
    end

    self.sell_cost_label = self.facing == "back" and "?" or self.sell_cost
end

local emplace_ref = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    emplace_ref(self, card, location, stay_flipped)

    if card.ability.eulogyed then
        if self == G.shop_jokers then
            card:flip() -- Unflipping is handled in emplace_ref()
            card:set_cost()
        end
    end
end

local get_badge_colour_ref = get_badge_colour
function get_badge_colour(key)
    if key == "temporary" then
        return G.C.GREY
    end

    return get_badge_colour_ref(key)
end