CreateThread(function()
    local riskLevel = 4 -- 1 zielony / 2 pomaranczowy / 3 czerwony / 4 czarny
    local choicedPed = {}
    local preChoicedLoc = 0
    local choicedLoc = {}
    local spawnedPed = {}
    local currentPosK = 0
    local currentPosV = nil
    local blip = {}
    local locations = {}
    locations[1] = {
        name = "Pacific Standard",
        blip = {
            type = 108,
            color = 25,
            coords = vec3(245.36, 221.22, 150.0)
        },
        peds = {
            models = {
                `cs_prolsec_02`,
                `csb_prolsec`,
                `s_m_m_security_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {1, 3, 5, 7},
        gunTypes = {
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`
        },
        isGunHold = {false, false, false, true},
        spawnPoints = {
            vec4(232.63, 220.4, 106.29, 250.47),
            vec4(236.12, 212.54, 106.29, 340.14),
            vec4(244.94, 211.17, 106.29, 75.24),
            vec4(251.57, 212.36, 106.29, 341.33),
            vec4(263.91, 208.2, 106.28, 30.23),
            vec4(259.86, 218.16, 106.29, 116.21),
            vec4(268.8, 222.22, 110.28, 62.71),
            vec4(235.28, 212.9, 110.28, 313.06),
            vec4(234.93, 227.28, 110.28, 201.71),
            vec4(239.25, 221.31, 106.29, 268.67),
            vec4(228.9, 217.47, 105.55, 117.65),
            vec4(254.36, 205.58, 110.28, 25.45),
            vec4(261.85, 217.22, 106.28, 192.54),
            vec4(263.87, 220.24, 101.68, 24.71)
        }
    }
    locations[2] = {
        name = "Fleeca Bank", -- Alta
        blip = {
            type = 108,
            color = 2,
            coords = vec3(314.41, -279.15, 54.17)
        },
        peds = {
            models = {
                `cs_prolsec_02`, 
                `csb_prolsec`, 
                `s_m_m_security_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {1, 1, 2, 3},
        gunTypes = {
            `weapon_stungun_mp`,
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`
        },
        isGunHold = {false, false, false, true},
        spawnPoints = {
            vec4(317.48, -278.93, 54.16, 69.44),
            vec4(313.23, -274.58, 53.93, 339.16),
            vec4(309.56, -275.12, 54.16, 214.0),
            vec4(306.61, -282.28, 54.16, 288.27)
        }
    }
    locations[3] = {
        name = "Fleeca Bank", -- Burton
        blip = {
            type = 108,
            color = 2,
            coords = vec3(-351.04, -49.87, 49.04)
        },
        peds = {
            models = {
                `cs_prolsec_02`, 
                `csb_prolsec`, 
                `s_m_m_security_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {1, 1, 2, 3},
        gunTypes = {
            `weapon_stungun_mp`,
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`
        },
        isGunHold = {false, false, false, true},
        spawnPoints = {
            vec4(-347.68, -49.87, 49.04, 72.16),
            vec4(-355.69, -46.15, 49.04, 198.39),
            vec4(-358.45, -53.18, 49.04, 298.47),
            vec4(-347.85, -46.98, 49.04, 343.29)
        }
    }
    locations[4] = {
        name = "Fleeca Bank", -- Pillbox Hill
        blip = {
            type = 108,
            color = 2,
            coords = vec3(149.82, -1040.75, 29.37)
        },
        peds = {
            models = {
                `cs_prolsec_02`, 
                `csb_prolsec`, 
                `s_m_m_security_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {1, 1, 2, 3},
        gunTypes = {
            `weapon_stungun_mp`,
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`
        },
        isGunHold = {false, false, false, true},
        spawnPoints = {
            vec4(152.54, -1041.5, 29.37, 28.43),
            vec4(145.35, -1036.82, 29.37, 208.16),
            vec4(142.41, -1043.82, 29.37, 298.01),
            vec4(153.12, -1037.79, 29.33, 344.93)
        }
    }
    locations[5] = {
        name = "Fleeca Bank", -- Rockford Hills
        blip = {
            type = 108,
            color = 2,
            coords = vec3(-1212.66, -330.22, 37.79)
        },
        peds = {
            models = {
                `cs_prolsec_02`, 
                `csb_prolsec`, 
                `s_m_m_security_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {1, 1, 2, 3},
        gunTypes = {
            `weapon_stungun_mp`,
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`
        },
        isGunHold = {false, false, false, true},
        spawnPoints = {
            vec4(-1210.3, -329.3, 37.78, 74.37),
            vec4(-1216.53, -329.8, 37.78, 209.12),
            vec4(-1217.2, -326.71, 37.64, 31.04),
            vec4(-1215.45, -338.2, 37.78, 345.31)
        }
    }
    locations[6] = {
        name = "Fleeca Bank", -- Great Ocean Hwy
        blip = {
            type = 108,
            color = 2,
            coords = vec3(-2962.45, 482.87, 15.7)
        },
        peds = {
            models = {
                `cs_prolsec_02`, 
                `csb_prolsec`, 
                `s_m_m_security_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {1, 1, 2, 3},
        gunTypes = {
            `weapon_stungun_mp`,
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`
        },
        isGunHold = {false, false, false, true},
        spawnPoints = {
            vec4(-2964.43, 486.04, 15.7, 192.89),
            vec4(-2967.52, 480.17, 15.47, 88.47),
            vec4(-2965.01, 477.19, 15.7, 320.83),
            vec4(-2957.19, 476.63, 15.7, 47.06)
        }
    }
    locations[7] = {
        name = "Fleeca Bank", -- Route 68
        blip = {
            type = 108,
            color = 2,
            coords = vec3(1174.74, 2706.62, 38.09)
        },
        peds = {
            models = {
                `cs_prolsec_02`, 
                `csb_prolsec`, 
                `s_m_m_security_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {1, 1, 2, 3},
        gunTypes = {
            `weapon_stungun_mp`,
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`
        },
        isGunHold = {false, false, false, true},
        spawnPoints = {
            vec4(1177.64, 2702.97, 38.17, 184.11),
            vec4(1172.07, 2706.84, 38.09, 228.63),
            vec4(1180.63, 2704.82, 38.09, 54.19),
            vec4(1181.03, 2712.3, 38.09, 131.28)
        }
    }
    locations[8] = {
        name = "Blaine County Savings Bank", -- Paleto Bay
        blip = {
            type = 108,
            color = 25,
            coords = vec3(-112.23, 6468.88, 31.63)
        },
        peds = {
            models = {
                `cs_prolsec_02`, 
                `csb_prolsec`, 
                `s_m_m_security_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {1, 2, 3, 4},
        gunTypes = {
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`
        },
        isGunHold = {false, false, false, true},
        spawnPoints = {
            vec4(-118.07, 6469.5, 31.63, 249.15),
            vec4(-113.18, 6465.19, 31.63, 355.9),
            vec4(-113.58, 6462.95, 31.48, 223.9),
            vec4(-99.78, 6461.82, 31.63, 44.43),
            vec4(-102.06, 6468.59, 31.63, 41.52)
        }
    }
    locations[9] = {
        name = "Vangelico Jeweller", -- Jeweller Rockford Hills
        blip = {
            type = 617,
            color = 5,
            coords = vec3(-628.14, -235.16, 38.0)
        },
        peds = {
            models = {
                `s_m_m_highsec_01`,
                `s_m_m_highsec_02`,
                `u_m_m_jewelsec_01`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
            }
        },
        bodyguards = {1, 2, 3, 4},
        gunTypes = {
            `weapon_stungun_mp`,
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_combatpistol`
        },
        isGunHold = {false, false, false, false},
        spawnPoints = {
            vec4(-631.77, -234.82, 38.06, 306.29),
            vec4(-627.98, -239.81, 38.06, 342.08),
            vec4(-620.68, -231.09, 38.06, 120.01),
            vec4(-617.28, -227.23, 38.06, 122.89),
            vec4(-618.89, -237.77, 38.06, 352.12),
            vec4(-630.47, -239.93, 38.14, 128.28),
            vec4(-627.06, -224.58, 38.06, 230.5)
        }
    }
    locations[10] = {
        name = "Union Depository", -- Union Depository Pillbox Hill
        blip = {
            type = 500,
            color = 11,
            coords = vec3(8.55, -661.81, 35.0)
        },
        peds = {
            models = {
                `cs_casey`,
                `ig_casey`,
                `s_m_m_armoured_01`,
                `s_m_m_armoured_02`
            },
            animations = {
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_COP_IDLES",
                "WORLD_HUMAN_SMOKING",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_CLIPBOARD"
            }
        },
        bodyguards = {2, 3, 4, 5},
        gunTypes = {
            `weapon_pistol`,
            `weapon_combatpistol`,
            `weapon_pumpshotgun`,
            `weapon_carbinerifle`
        },
        isGunHold = {false, false, true, true},
        spawnPoints = {
            vec4(-3.96, -659.16, 33.48, 183.98),
            vec4(-0.21, -655.03, 33.45, 155.45),
            vec4(11.85, -663.13, 33.45, 91.17),
            vec4(-11.18, -661.25, 33.48, 276.76),
            vec4(3.56, -661.6, 33.45, 314.82),
            vec4(10.98, -702.31, 16.13, 72.84),
            vec4(-12.84, -695.23, 16.13, 247.39),
            vec4(-0.26, -694.63, 16.13, 69.19),
            vec4(3.45, -707.62, 16.13, 297.1),
            vec4(-6.63, -686.24, 16.13, 203.68)
        }
    }

    AddRelationshipGroup("NPC")

    local j = 1
    while j <= #locations do
        Wait(0)
        blip[j] = AddBlipForCoord(locations[j]["blip"]["coords"])
        SetBlipSprite(blip[j], locations[j]["blip"]["type"])
	    SetBlipColour(blip[j], locations[j]["blip"]["color"])
        SetBlipScale(blip[j], 0.8)
        SetBlipAsShortRange(blip[j], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(locations[j]["name"])
        EndTextCommandSetBlipName(blip[j])

        j=j+1
    end
    
    local i = 0

    while true do
        Wait(0)
        local PlayerCoords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(locations) do
            if #(v["blip"]["coords"] - PlayerCoords) < 150.0 then
                if currentPosK ~= k then
                    i = 0
                end
                currentPosK = k
                currentPosV = v["blip"]["coords"]
            end
            if currentPosV ~= nil then
                if #(currentPosV - PlayerCoords) > 150.0 then
                    local o = 0
                    while o < #spawnedPed+1 do
                        Wait(0)
                        DeleteEntity(spawnedPed[o])

                        o=o+1
                    end
                    currentPosV = nil
                    currentPosK = 0
                end
            end
        end

        if currentPosK ~= 0 then
            local g = 1
            while g <= #locations[currentPosK]["spawnPoints"] do
                DrawMarker(27, locations[currentPosK]["spawnPoints"][g].x, locations[currentPosK]["spawnPoints"][g].y, locations[currentPosK]["spawnPoints"][g].z-0.95, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, true, nil, nil, false)

                SetTextScale(0.3, 0.3)
                SetTextProportional(1)
                SetTextColour(255, 255, 255, 150)
                SetTextOutline()
                SetTextEntry("STRING")
                SetTextCentre(1)
                AddTextComponentString(g.."/"..#locations[currentPosK]["spawnPoints"])
                SetDrawOrigin(locations[currentPosK]["spawnPoints"][g].x, locations[currentPosK]["spawnPoints"][g].y, locations[currentPosK]["spawnPoints"][g].z-0.75, 0)
                DrawText(0.0, 0.0)
                ClearDrawOrigin()

                g=g+1
            end

            while i < locations[currentPosK]["bodyguards"][riskLevel] do
                Wait(0)
                choicedPed[i] = locations[currentPosK]["peds"]["models"][math.random(1,#locations[currentPosK]["peds"]["models"])]
                choicedLoc[i] = locations[currentPosK]["spawnPoints"][math.random(1,#locations[currentPosK]["spawnPoints"])]
                if not IsPositionOccupied(choicedLoc[i].x, choicedLoc[i].y, choicedLoc[i].z, 1.0, false, false, true) then
                    RequestModel(choicedPed[i])
                    spawnedPed[i] = CreatePed(4, choicedPed[i], choicedLoc[i], true, true)
                    
                    local tries = 0
                    local success = true
                    while true do
                        Wait(200)
                        if DoesEntityExist(spawnedPed[i]) then break else 
                            tries = tries + 1 
                            spawnedPed[i] = CreatePed(4, choicedPed[i], choicedLoc[i], true, true)
                        end
                        if tries >=5 then success = false break end
                    end
            
                    if locations[currentPosK]["isGunHold"][riskLevel] == false then
                        TaskStartScenarioInPlace(spawnedPed[i], locations[currentPosK]["peds"]["animations"][math.random(1,#locations[currentPosK]["peds"]["animations"])])
                    end
                    SetEntityHealth(spawnedPed[i], 200)
                    SetPedArmour(spawnedPed[i], 100)
                    SetPedPropIndex(spawnedPed[i], 0, math.random(0,2), 0, true)
                    SetPedPropIndex(spawnedPed[i], 1, math.random(0,1), 0, true)
                    GiveWeaponToPed(spawnedPed[i], locations[currentPosK]["gunTypes"][riskLevel], 128, true, locations[currentPosK]["isGunHold"][riskLevel])
                    SetCurrentPedWeapon(spawnedPed[i], locations[currentPosK]["gunTypes"][riskLevel], locations[currentPosK]["isGunHold"][riskLevel])
                    SetRelationshipBetweenGroups(0, `NPC`, `NPC`)
                    SetPedRelationshipGroupHash(spawnedPed[i], `NPC`)
                    AddBlipForEntity(spawnedPed[i])
                    
                    i=i+1
                end
            end
        end
    end
end)