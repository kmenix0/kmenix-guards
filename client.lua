robberyInProgress = false

function robberyInProgress(status)
    robberyInProgress = status
end

CreateThread(function()
    local isPedAttacking = {}
    local choicedPed = {}
    local preChoicedLoc = 0
    local choicedLoc = {}
    local spawnedPed = {}
    local currentPosK = 0
    local currentPosV = nil

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
            -- local g = 1
            -- while g <= #locations[currentPosK]["spawnPoints"] do
            --     DrawMarker(27, locations[currentPosK]["spawnPoints"][g].x, locations[currentPosK]["spawnPoints"][g].y, locations[currentPosK]["spawnPoints"][g].z-0.95, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, true, nil, nil, false)

            --     SetTextScale(0.3, 0.3)
            --     SetTextProportional(1)
            --     SetTextColour(255, 255, 255, 150)
            --     SetTextOutline()
            --     SetTextEntry("STRING")
            --     SetTextCentre(1)
            --     AddTextComponentString(g.."/"..#locations[currentPosK]["spawnPoints"])
            --     SetDrawOrigin(locations[currentPosK]["spawnPoints"][g].x, locations[currentPosK]["spawnPoints"][g].y, locations[currentPosK]["spawnPoints"][g].z-0.75, 0)
            --     DrawText(0.0, 0.0)
            --     ClearDrawOrigin()

            --     g=g+1
            -- end

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
                    AddRelationshipGroup("SECURITY_GUARD")
                    SetEntityHealth(spawnedPed[i], 200)
                    SetPedArmour(spawnedPed[i], 100)
                    SetPedPropIndex(spawnedPed[i], 0, math.random(0,2), 0, true)
                    SetPedPropIndex(spawnedPed[i], 1, math.random(0,1), 0, true)
                    GiveWeaponToPed(spawnedPed[i], locations[currentPosK]["gunTypes"][riskLevel], 128, true, locations[currentPosK]["isGunHold"][riskLevel])
                    GiveWeaponComponentToPed(spawnedPed[i], locations[currentPosK]["gunTypes"][riskLevel], `COMPONENT_AT_PI_FLSH`)
                    SetFlashLightEnabled(spawnedPed[i], false)
                    SetCurrentPedWeapon(spawnedPed[i], locations[currentPosK]["gunTypes"][riskLevel], locations[currentPosK]["isGunHold"][riskLevel])
                    SetRelationshipBetweenGroups(0, `SECURITY_GUARD`, `SECURITY_GUARD`)
                    SetPedRelationshipGroupHash(spawnedPed[i], `SECURITY_GUARD`)
                    AddBlipForEntity(spawnedPed[i])
                    SetPedCombatAttributes(spawnedPed[i], 5, true)
                    SetPedCombatAttributes(spawnedPed[i], 46, true)
                    SetPedCombatAttributes(spawnedPed[i], 0, true)
                    SetPedCombatAttributes(spawnedPed[i], 2, true)
                    SetPedCombatAttributes(spawnedPed[i], 52, true)
                    SetPedCombatRange(spawnedPed[i], 0)
                    SetPedCombatMovement(spawnedPed[i], 2)
                    
                    i=i+1
                end
            end

            if robberyInProgress==true then
                local PlayerPedId = PlayerPedId()
                local j = 0
                while j <= #spawnedPed do
                    TaskCombatPed(spawnedPed[j], PlayerPedId, 1, 16)
                    j=j+1
                end
            end
        end
    end
end)

CreateThread(function()
    local spawnedCar = 0
    local currentPosK = 0
    local currentPosV = 0
    local spawnedPed = {}

    function GetRandomNearbyPositionOnRoad(x, y, z, radius)
        local found, spawnPos, spawnHeading
        for k = 1, 15 do
            local randomOffsetX = math.random(-radius, radius)
            local randomOffsetY = math.random(-radius, radius)
            found, spawnPos, spawnHeading = GetNthClosestVehicleNodeWithHeading(x + randomOffsetX, y + randomOffsetY, z, 1, 0, 0, 0)
            if found then break end
        end
        return found, spawnPos, spawnHeading
    end

    function GetVehicleOccupancy(vehicle)
        local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
        local occupiedSeats = 0
        
        for seatIndex = -1, maxSeats - 1 do
            local pedInSeat = GetPedInVehicleSeat(vehicle, seatIndex)
            if pedInSeat ~= 0 and pedInSeat ~= PlayerPedId() then
                occupiedSeats = occupiedSeats + 1
            end
        end
        
        return occupiedSeats
    end

    function startRobberyWithAlarm(robberHere)
        local finishCarModel = security["vehicles"][math.random(1,#security["vehicles"])]
        local finishPedModel = {}
        if not IsModelInCdimage(finishCarModel) then return end
            RequestModel(finishCarModel)
        local found, spawnPos, spawnHeading = GetRandomNearbyPositionOnRoad(robberHere["parking"].x, robberHere["parking"].y, robberHere["parking"].z, 250)
        if found then
            spawnedCar = CreateVehicle(finishCarModel, spawnPos.x, spawnPos.y, spawnPos.z, spawnHeading, true, false)
            SetVehicleEngineOn(spawnedCar, true, true, true)
            SetVehicleSiren(spawnedCar, true)

            local i = 1
            while i <= security["bodyguards"][riskLevel] do
                finishPedModel[i] = security["peds"][math.random(1,#security["peds"])]
                if not IsModelInCdimage(finishPedModel[i]) then return end
                    RequestModel(finishPedModel[i])
                spawnedPed[i] = CreatePed(4, finishPedModel[i], true, true)
                AddRelationshipGroup("SECURITY_GUARD")
                SetEntityHealth(spawnedPed[i], 200)
                SetPedArmour(spawnedPed[i], 100)
                SetPedPropIndex(spawnedPed[i], 0, math.random(0,2), 0, true)
                SetPedPropIndex(spawnedPed[i], 1, math.random(0,1), 0, true)
                GiveWeaponToPed(spawnedPed[i], security["gunTypes"][riskLevel], 128, true, security["isGunHold"][riskLevel])
                GiveWeaponComponentToPed(spawnedPed[i], security["gunTypes"][riskLevel], `COMPONENT_AT_PI_FLSH`)
                GiveWeaponToPed(spawnedPed[i], `WEAPON_FLASHLIGHT`, 1, true, locations[currentPosK]["isGunHold"][riskLevel])
                SetFlashLightEnabled(spawnedPed[i], false)
                SetRelationshipBetweenGroups(0, `SECURITY_GUARD`, `SECURITY_GUARD`)
                SetPedRelationshipGroupHash(spawnedPed[i], `SECURITY_GUARD`)
                AddBlipForEntity(spawnedPed[i])
                SetPedCombatAttributes(spawnedPed[i], 5, true)
                SetPedCombatAttributes(spawnedPed[i], 46, true)
                SetPedCombatAttributes(spawnedPed[i], 0, true)
                SetPedCombatAttributes(spawnedPed[i], 2, true)
                SetPedCombatAttributes(spawnedPed[i], 52, true)
                SetPedCombatRange(spawnedPed[i], 0)
                SetPedCombatMovement(spawnedPed[i], 2)
                TaskWarpPedIntoVehicle(spawnedPed[i], spawnedCar, i-2)

                i=i+1
            end
            Wait(10)

            SetDriverAbility(spawnedPed[1], 1.0)
            TaskVehicleDriveToCoordLongrange(spawnedPed[1], spawnedCar, robberHere["parking"], 25.0, 1074528293, 5.0)
            local carLocation = 0
            local pedCoords = {}
            local vehicleFull = false
            local occupiedSeatsF = 0
            local j = 1
            local p = 1
            while j <= security["bodyguards"][riskLevel] or p <= security["bodyguards"][riskLevel] do
                Wait(0)
                carLocation = GetEntityCoords(spawnedCar)
                if #(robberHere["parking"]-carLocation) < 7.5 then
                    Wait(2000)
                    while j <= security["bodyguards"][riskLevel] do
                        if robberyInProgress==true then
                            local PlayerPedId = PlayerPedId()
                            local k = 0
                            while k <= #spawnedPed do
                                TaskCombatPed(spawnedPed[k], PlayerPedId, 1, 16)
                                k=k+1
                            end
                        end
                        TaskLeaveVehicle(spawnedPed[j], spawnedCar, 1)
                        Wait(750)
                        SetCurrentPedWeapon(spawnedPed[j], security["gunTypes"][riskLevel], security["isGunHold"][riskLevel])
                        TaskGoToCoordAnyMeans(spawnedPed[j], robberHere["safe"], 1.0, 0, 0, 786603, 0xbf800000)

                        j=j+1
                    end

                    while p <= security["bodyguards"][riskLevel] do
                        Wait(0)
                        pedCoords[p] = GetEntityCoords(spawnedPed[p])

                        if #(pedCoords[p]-robberHere["safe"]) < 1.5 then
                            Wait(2500)
                            TaskEnterVehicle(spawnedPed[p], spawnedCar, -1, p-2, 1.0, 1)

                            p=p+1
                        end
                    end

                    while not vehicleFull do
                        Wait(0)
                        occupiedSeatsF = GetVehicleOccupancy(spawnedCar)
                        if security["bodyguards"][riskLevel] == occupiedSeatsF then
                            vehicleFull = true
                            Wait(2000)
                            TaskVehicleDriveWander(spawnedPed[1],spawnedCar, 15.0, 956)
                            Wait(30000)
                            DeleteEntity(spawnedCar)
                            DeletePed(spawnedPed[1])
                            DeletePed(spawnedPed[2])
                            DeletePed(spawnedPed[3])
                            DeletePed(spawnedPed[4])
                        end
                    end
                end
            end
        end
    end

    while true do
        Wait(0)
        local PlayerCoords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(locations) do
            if #(v["safe"] - PlayerCoords) < 25.0 then
                currentPosK = k
                currentPosV = v["safe"]
            end
        end

        if currentPosK ~= 0 then
            if #(locations[currentPosK]["safe"]-PlayerCoords) < 20.0 then
                DrawMarker(27, currentPosV-vec3(0.0,0.0,0.95), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.0, 255, 25, 25, 100, false, true, 2, true, nil, nil, false)
                if #(locations[currentPosK]["safe"] - PlayerCoords) < 1.5/2 then
                    BeginTextCommandDisplayHelp('STRING')
                    AddTextComponentSubstringPlayerName("Naciśnij ~INPUT_CONTEXT~ aby ~r~rozpocząć rabunek~w~ "..locations[currentPosK]["name"])
                    EndTextCommandDisplayHelp(0, false, true, 0)
                    if IsControlJustPressed(0, 38) then
                        robberyInProgress(false)
                        startRobberyWithAlarm(locations[currentPosK])
                    end
                end
            end
        end
    end
end)