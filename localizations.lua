return {
    descriptions = {
        Joker = {
            j_egocentrism = {
                name = "Egocentrism",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "{C:attention}Egocentrism{}. Convert a",
                    "random {C:attention}Joker{} into {C:attention}Egocentrism",
                    "when {C:attention}Blind{} is selected",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_eulogy = {
                name = "Eulogy Zero",
                text = {
                    "{C:attention}Shop{} cards have {C:green}#1# in #2#",
                    "chance of being {C:attention}half",
                    "{C:attention}price{} and {C:attention}flipped"
                }
            },
            j_crown = {
                name = "Brittle Crown",
                text = {
                    "Played cards have a {C:green}#1# in #2#",
                    "chance to give {C:money}$#3#{} when scored",
                    "Lose {C:money}$#3#{} per remaining {C:attention}hand{} and",
                    "{C:attention}discard{} by end of round"
                }
            },
            j_shaped = {
                name = "Shaped Glass",
                text = {
                    "Retrigger all played",
                    "{C:attention}Glass{} cards, but",
                    "increase their destroy",
                    "chance to {C:green}#1# in #2#{}"
                }
            },
            j_snake_eyes = {
                name = "Snake Eyes",
                text = {
                    "Gains {C:mult}+#1#{} Mult if",
                    "{C:tarot}The Wheel of Fortune{} fails",
                    "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)"
                }
            },
            j_bungus = {
                name = "Bustling Fungus",
                text = {
                    "After {C:attention}#1#{} rounds, add",
                    "{C:dark_edition}Foil{} to base edition",
                    "Jokers on both sides",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
                }
            },
            j_benthic = {
                name = "Benthic Bloom",
                text = {
                    "Upgrade {C:attention}1{} random {C:attention}Joker{}",
                    "into {C:attention}Joker{} of the next",
                    "{C:attention}higher rarity{} when",
                    "{C:attention}Boss Blind{} is defeated"
                }
            },
            j_encrusted = {
                name = "Encrusted Key",
                text = {
                    "After defeating the",
                    "{C:attention}Boss Blind{}, this card",
                    "is destroyed and gain",
                    "a {C:attention}#1#"
                }
            },
            j_kjaro = {
                name = "Kjaro's Band",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if Chips",
                    "scored in last round",
                    "were more than {C:attention}X#2#",
                    "of required Chips"
                }
            },
            j_daisy = {
                name = "Lepton Daisy",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "{C:attention}debuffed{} card",
                    "in played hand",
                }
            },
            j_duplicator = {
                name = "Substandard Duplicator",
                text = {
                    "When gain a {C:attention}Joker{},",
                    "create a {C:dark_edition}Negative",
                    "{C:dark_edition}Temporary{} copy of it"
                }
            },
            j_happiest_mask = {
                name = "Happiest Mask",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a random {C:spectral}Spectral{} card",
                    "when any card is destroyed",
                    "{C:inactive}(Must have room)"
                }
            }
        },
        Blind = {
            bl_loop = {
                name = "The Loop",
                text = {
                    "Random Joker disabled",
                    "after playing 2 hands"
                }
            },
            bl_void = {
                name = "The Void",
                text = {
                    "Set all Jokers' sell",
                    "value to 0 when defeated"
                }
            },
            bl_bag = {
                name = "The Bag",
                text = {

                }
            },
            bl_final_hammer = {
                name = "Glaucous Hammer",
                text = {
                    "Start with random half",
                    "of the deck debuffed",
                }
            },
            bl_final_crab = {
                name = "Tyrian Crab",
                text = {
                    "X1.5 required Chips",
                    "after each hand played",
                }
            }
        },
        Voucher = {
            v_3d_printer = {
                name = "3D Printer",
                text = {
                    "All {C:attention}Booster Packs",
                    "have {C:attention}1{} more option"
                }
            },
            v_militech_printer = {
                name = "Mili-Tech Printer",
                text = {
                    "Can choose {C:attention}1{} more",
                    "card from all",
                    "{C:attention}Booster Packs"
                }
            }
        },
        Other = {
            temporary = {
                name = "Temporary",
                text = {
                    "Gets destroyed at",
                    "end of round and",
                    "has no sell value"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_broken_ex = "Broken!",
            k_converted_ex = "Converted!",
            k_voided_ex = "Voided!",
            ph_kjaro_disabled = "not enough chips"
        },
        labels = {
            temporary = "Temporary"
        }
    }
}, {
    descriptions = {
        Joker = {
            j_egocentrism = {
                name = "자기중심성",
                text = {
                    "{C:attention}자기중심성{} 하나마다",
                    "칩 {C:chips}+#1#{}개를 획득합니다. {C:attention}블라인드{}를",
                    "선택하면 무작위 조커를",
                    "{C:attention}자기중심성{}으로 전환합니다",
                    "{C:inactive}(현재 칩 {C:chips}+#2#{C:inactive}개)"
                }
            },
            j_eulogy = {
                name = "0의 찬미가",
                text = {
                    "{C:attention}상점{} 카드들이 {C:green}#1#/#2#{} 확률로",
                    "가격이 {C:attention}절반{}이 되고",
                    "{C:attention}뒤집혀서{} 나타납니다"
                }
            },
            j_crown = {
                name = "Brittle Crown",
                text = {
                    "Played cards have a {C:green}#1# in #2#",
                    "chance to give {C:money}$1{} when scored",
                    "Lose {C:money}$1{} per remaining {C:attention}hand and",
                    "{C:attention}discard{} by end of round"
                }
            },
            j_shaped = {
                name = "Shaped Glass",
                text = {
                    "Retrigger all played",
                    "{C:attention}Glass{} cards, but",
                    "increase their destroy",
                    "chance to {C:green}#1# in #2#{}"
                }
            },
            j_snake_eyes = {
                name = "뱀의 눈",
                text = {
                    "{C:tarot}운명의 수레바퀴{} 발동에 실패하면",
                    "배수 획득량이 {C:mult}+#1#{} 증가합니다",
                    "{C:inactive}(현재 {C:red}+#2#{C:inactive} 배수)"
                }
            },
            j_bungus = {
                name = "뿜뿜 버섯",
                text = {
                    "{C:attention}#1#{} 라운드 후 양옆의",
                    "에디션 없는 조커들에",
                    "{C:dark_edition}포일{}을 추가합니다",
                    "{C:inactive}(현재 {C:attention}#2#{C:inactive}/#1# 라운드)"
                }
            },
            j_benthic = {
                name = "물속의 꽃",
                text = {
                    "{C:attention}보스 블라인드{}에 승리하면",
                    "무작위 {C:attention}조커 1{}장을 한 단계",
                    "{C:attention}높은 등급{}의 {C:attention}조커{}로",
                    "업그레이드합니다"
                }
            },
            j_encrusted = {
                name = "뭔가에 덮인 열쇠",
                text = {
                    "{C:attention}보스 블라인드{}에 승리하면",
                    "{C:attention}#1#{}를 획득하고",
                    "이 카드를 파괴합니다"
                }
            },
            j_kjaro = {
                name = "캬로의 반지",
                text = {
                    "이전 라운드에서 획득한 칩이",
                    "필요한 칩의 {C:attention}#2#{}배 이상이었다면",
                    "{X:mult,C:white} X#1# {} 배수를 획득합니다"
                }
            },
            j_daisy = {
                name = "렙톤 데이지",
                text = {
                    "플레이한 핸드에 포함된",
                    "{C:attention}디버프{}된 카드마다",
                    "칩 {C:chips}+#1#{}개를 획득합니다",
                }
            },
            j_duplicator = {
                name = "하급 복제 장치",
                text = {
                    "{C:attention}조커{}를 획득하면",
                    "{C:dark_edition}네거티브 임시",
                    "복사본을 생성합니다"
                }
            },
            j_happiest_mask = {
                name = "행복한 가면",
                text = {
                    "카드가 파괴될 때마다",
                    "{C:green}#1#/#2#{} 확률로",
                    "{C:spectral}유령{} 카드를 생성합니다",
                    "{C:inactive}(공간이 있어야 합니다)"
                }
            }
        },
        Blind = {
            bl_loop = {
                name = "고리",
                text = {
                    "핸드를 2번 플레이하면",
                    "무작위 조커가 비활성화됩니다"
                }
            },
            bl_void = {
                name = "공허",
                text = {
                    "승리하면 모든 조커의",
                    "판매 가치가 0이 됩니다"
                }
            },
            bl_final_hammer = {
                name = "청회색 망치",
                text = {
                    "덱의 무작위 절반이",
                    "디버프되고 시작합니다"
                }
            },
            bl_final_crab = {
                name = "자주색 게",
                text = {
                    "각 핸드 플레이 후 칩",
                    "요구량이 1.5배 증가합니다"
                }
            }
        },
        Voucher = {
            v_3d_printer = {
                name = "3D 프린터",
                text = {
                    "모든 {C:attention}부스터 팩{}에서",
                    "카드 {C:attention}#1#{}장이 추가로",
                    "제시됩니다"
                }
            },
            v_militech_printer = {
                name = "군용 프린터",
                text = {
                    "모든 {C:attention}부스터 팩{}에서",
                    "카드 {C:attention}#1#{}장을 추가로",
                    "선택할 수 있습니다"
                }
            }
        },
        Other = {
            temporary = {
                name = "임시",
                text = {
                    "라운드 종료 시",
                    "파괴되고 판매 가치가",
                    "없습니다"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_broken_ex = "부서짐!",
            k_converted_ex = "전환됨!",
            k_voided_ex = "공허해짐!",
            ph_kjaro_disabled = "칩 부족"
        },
        labels = {
            temporary = "임시"
        }
    }
}