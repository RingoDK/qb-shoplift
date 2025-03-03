local QBCore = exports['qb-core']:GetCoreObject()
local timeOut = false

local function InitZones()
    -- Add zones for Regular Shops
    for k, v in pairs(Config.TargetLocations) do
        exports["qb-target"]:AddBoxZone("snatta_"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 1.7, 1.0, {
            name = "snatta_"..k,
            heading = v.coords.w,
            minZ = v.coords.z - 1,
            maxZ = v.coords.z + 1,
            debugPoly = false,
        }, {
            options = {
                {
                    icon = 'fas fa-user-secret',
                    label = Config.Translations.Target,
                    event = "qb-shoplift:client:startShoplift",
                    storeType = "regular",  -- Regular store
                    zoneName = k,
                },
            },
            distance = 1.5
        })
    end

    -- Add zones for Liquor Stores
    for k, v in pairs(Config.LiquorStores) do
        exports["qb-target"]:AddBoxZone("liquor_"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 1.7, 1.0, {
            name = "liquor_"..k,
            heading = v.coords.w,
            minZ = v.coords.z - 1,
            maxZ = v.coords.z + 1,
            debugPoly = false,
        }, {
            options = {
                {
                    icon = 'fas fa-cocktail',
                    label = Config.Translations.Target,
                    event = "qb-shoplift:client:startShoplift",
                    storeType = "liquor",  -- Liquor store
                    zoneName = k,
                },
            },
            distance = 1.5
        })
    end
end

local function AttemptPoliceAlert()
    if not AlertSend then
        local chance = Config.PoliceAlertChance
        if GetClockHours() >= 1 and GetClockHours() <= 6 then
            chance = Config.PoliceNightAlertChance
        end
        if math.random() <= chance then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local streetName, crossingRoad = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
            local streetLabel = GetStreetNameFromHashKey(streetName)
            if crossingRoad then
                streetLabel = streetLabel .. " & " .. GetStreetNameFromHashKey(crossingRoad)
            end

            exports["ps-dispatch"]:CustomAlert({
                coords = playerCoords,
                job = { "police" },
                message = Config.Translations.PoliceAlertMessage,
                dispatchCode = "10-31",
                description = "Possible shoplifting in progress",
                radius = 30.0,
                sprite = 156,  -- Store robbery icon
                color = 1,  -- Red
                scale = 1.2,
                length = 5000,
                sound = "ShopliftingAlert",
                blip = true
            })
        end

        AlertSend = true
        SetTimeout(Config.AlertCooldown, function()
            AlertSend = false
        end)
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    InitZones()
end)

AddEventHandler('qb-shoplift:server:setTimeout', function()
    if timeOut then return end
    timeOut = true
    CreateThread(function()
        SetTimeout(60000 * Config.Cooldown, function()
            timeOut = false
        end)
    end)
end)

AddEventHandler('qb-shoplift:client:startShoplift', function(data)
    if timeOut then 
        QBCore.Functions.Notify(Config.Translations.AlreadyShoplifted, "error", 3500) 
        return 
    end

    local storeType = data.storeType
    print("Store Type Received: ", storeType)

    -- Start shoplifting process
    AttemptPoliceAlert()
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})

    QBCore.Functions.Progressbar("shoplifting", Config.Translations.ShopliftProgressbar, 12500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        
        -- Select reward based on store type
        local reward = nil
        if storeType == "regular" then
            reward = Config.Rewards[math.random(1, #Config.Rewards)]
        elseif storeType == "liquor" then
            reward = Config.LiquorRewards[math.random(1, #Config.LiquorRewards)]
        else
            print("Error: Unknown store type!")
            return
        end

        if reward then
            print("Reward: " .. reward)
            TriggerServerEvent('qb-shoplift:server:giveItem', storeType, reward)
        else
            QBCore.Functions.Notify(Config.Translations.NoReward, "error")
        end
    end, function() -- Cancel
        timeOut = false
        QBCore.Functions.Notify(Config.Translations.canceled, "error")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)

    TriggerEvent('qb-shoplift:server:setTimeout')
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        InitZones()
    end
end)