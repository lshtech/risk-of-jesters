local function calculate_egocentrism(self, context)
    if context.setting_blind and not self.getting_sliced and not context.blueprint then
        local convertables = {}
        local egocentrisms = {}
        for _, v in ipairs(G.jokers.cards) do
            if not v.getting_sliced then
                table.insert(v.ability.name == "Egocentrism" and egocentrisms or convertables, v)
            end
        end

        if #convertables > 0 and not (context.blueprint_card or self).getting_sliced then
            local joker = pseudorandom_element(convertables, pseudoseed("egocentrism"))
            joker.getting_sliced = true

            G.E_MANAGER:add_event(Event({
                func = function()
                    local new = copy_card(egocentrisms[1], nil, nil, nil)

                    self:juice_up(0.8, 0.8)

                    new:set_edition(joker.edition, true)
                    joker:start_dissolve({HEX("4d97cb")}, nil, 1.6)
                    new:start_materialize()
                    new:add_to_deck()
                    G.jokers:emplace(new)

                    return true
                end
            }))

            card_eval_status_text(self, "extra", nil, nil, nil, {
                message = localize("k_converted_ex")
            })
        end
    elseif SMODS.end_calculate_context(context) then
        local count = 0

        for _, joker in ipairs(G.jokers.cards) do
            if joker.ability.set == "Joker" and joker.ability.name == "Egocentrism" then
                count = count + 1
            end
        end

        return {
            message = localize{
                type = "variable",
                key = "a_chips",
                vars = {
                    self.ability.extra * count
                }
            },
            chip_mod = self.ability.extra * count
        }
    end
end

local function calculate_snake_eyes(self, context)
    if context.wheel_failed then
        self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.mult_mod
        G.E_MANAGER:add_event(Event({
            func = function()
                card_eval_status_text(self, "extra", nil, nil, nil, {
                    message = localize("k_upgrade_ex")
                })

                return true
            end
        }))
    elseif SMODS.end_calculate_context(context) then
        return {
            message = localize{
                type = "variable",
                key = "a_mult",
                vars = {
                    self.ability.extra.mult
                }
            },
            mult_mod = self.ability.extra.mult
        }
    end
end

local function calculate_bungus(self, context)
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint
    and not self.getting_sliced then
        self.ability.bungus_rounds = self.ability.bungus_rounds + 1
        if self.ability.bungus_rounds == self.ability.extra then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local pos = nil
                    for i, v in ipairs(G.jokers.cards) do
                        if v == self then
                            pos = i
                            break
                        end
                    end

                    if not pos then
                        return
                    end

                    self:juice_up(0.8, 0.8)

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

        if self.ability.bungus_rounds <= self.ability.extra then
            return {
                message = self.ability.bungus_rounds < self.ability.extra and self.ability.bungus_rounds.."/"..self.ability.extra or localize("k_active_ex"),
                colour = G.C.FILTER
            }
        end
    end
end

local function calculate_duplicator(self, context)
    if context.joker_added and not (context.blueprint_card or self).getting_sliced then
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = copy_card(context.added, nil, nil, nil)
                card.ability.temporary = true

                (context.blueprint_card or self):juice_up(0.8, 0.8)

                card:set_edition({negative = true}, true)
                card:set_eternal(false)
                card:start_materialize()
                card:add_to_deck()
                G.jokers:emplace(card)

                return true
            end
        }))

        card_eval_status_text(context.blueprint_card or self, "extra", nil, nil, nil, {
            message = localize("k_duplicated_ex")
        })
    end
end

local function calculate_happiest_mask(self, context)
    if context.any_card_destroyed and pseudorandom("happiest") < G.GAME.probabilities.normal / self.ability.extra
    and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
    and not (context.blueprint_card or self).getting_sliced then
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

        card_eval_status_text(context.blueprint_card or self, "extra", nil, nil, nil, {
            message = localize("k_plus_spectral"),
            colour = G.C.SECONDARY_SET.Spectral
        })
    end
end

local function calculate_benthic(self, context)
    if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss
    and not (context.blueprint_card or self).getting_sliced then
        local upgradables = {}
        for _, v in ipairs(G.jokers.cards) do
            if v ~= (context.blueprint_card or self) and not v.getting_sliced and v.config.center.rarity <= 3 then
                table.insert(upgradables, v)
            end
        end

        if #upgradables > 0 then
            local joker = pseudorandom_element(upgradables, pseudoseed("benthic"))
            local rarity = joker.config.center.rarity
            joker.getting_sliced = true

            G.E_MANAGER:add_event(Event({
                func = function()
                    (context.blueprint_card or self):juice_up(0.8, 0.8)

                    local card = create_card("Joker", G.jokers, rarity == 3, rarity == 1 and 0.9 or 1, nil, nil, nil, "benthic")

                    card:set_edition(joker.edition, true)
                    joker:start_dissolve({HEX("bf0ef8")}, nil, 1.6)
                    card:start_materialize()
                    card:add_to_deck()
                    G.jokers:emplace(card)

                    return true
                end
            }))

            return {
                message = localize("k_upgrade_ex")
            }
        end
    end
end

local function calculate_encrusted(self, context)
    if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss
    and not (context.blueprint_card or self).getting_sliced then
        self.getting_sliced = true

        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag("tag_coupon"))
                play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)

                play_sound("tarot1")
                self.T.r = -0.2
                (context.blueprint_card or self):juice_up(0.3, 0.4)
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
    end
end

local function calculate_daisy(self, context)
    if SMODS.end_calculate_context(context) and context.cardarea == G.jokers then
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
                        self.ability.extra * count
                    }
                },
                chip_mod = self.ability.extra * count
            }
        end
    end
end

local function calculate_kjaro(self, context)
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint
    and not (context.blueprint_card or self).getting_sliced then
        if G.GAME.chips >= G.GAME.blind.chips * 4 then
            if not self.ability.enabled then
                self.ability.enabled = true
                juice_card_until(self, function(card)
                    return card.ability.enabled
                end, true)
            end

            return {
                message = localize("k_active_ex"),
                colour = G.C.FILTER
            }
        else
            self.ability.enabled = false
        end
    elseif SMODS.end_calculate_context(context) and self.ability.enabled then
        return {
            message = localize{
                type = "variable",
                key = "a_xmult",
                vars = {
                    self.ability.extra.Xmult
                }
            },
            Xmult_mod = self.ability.extra.Xmult
        }
    end
end

return {
    j_egocentrism = {
        order = 9,
        name = "Egocentrism",
        config = {
            extra = 40
        },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        calculate = calculate_egocentrism
    },
    j_eulogy = {
        order = 10,
        name = "Eulogy Zero",
        config = {
            extra = 2
        },
        rarity = 2,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true,
        calculate = nil
    },
    j_bungus = {
        order = 1,
        name = "Bustling Fungus",
        config = {
            extra = 5
        },
        rarity = 1,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true,
        calculate = calculate_bungus
    },
    j_snake_eyes = {
        order = 2,
        name = "Snake Eyes",
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
        blueprint_compat = true,
        eternal_compat = true,
        calculate = calculate_snake_eyes
    },
    j_daisy = {
        order = 3,
        name = "Lepton Daisy",
        config = {
            extra = 50
        },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        calculate = calculate_daisy
    },
    j_kjaro = {
        order = 4,
        name = "Kjaro's Band",
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
        blueprint_compat = true,
        eternal_compat = true,
        calculate = calculate_kjaro
    },
    j_duplicator = {
        order = 5,
        name = "Substandard Duplicator",
        rarity = 3,
        cost = 10,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        calculate = calculate_duplicator
    },
    j_happiest_mask = {
        order = 6,
        name = "Happiest Mask",
        config = {
            extra = 2
        },
        rarity = 3,
        cost = 9,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        calculate = calculate_happiest_mask
    },
    j_benthic = {
        order = 7,
        name = "Benthic Bloom",
        rarity = 3,
        cost = 8,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        calculate = calculate_benthic
    },
    j_encrusted = {
        order = 8,
        name = "Encrusted Key",
        rarity = 1,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = false,
        calculate = calculate_encrusted
    }
}