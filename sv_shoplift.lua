local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-shoplift:server:giveItem", function(storeType, reward)
    local chance = math.random(100)

    -- Chance to find nothing, 30% chance to fail
    if chance <= 30 then 
        TriggerClientEvent('QBCore:Notify', source, Config.Translations.NothingFound, "error") 
        print("No reward found (chance: " .. chance .. "%)")  -- Debug message
        return 
    end

    -- Get player data
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Debugging the storeType and reward
    print("Store Type: " .. storeType)  -- Store type received
    print("Reward: " .. reward)  -- Reward selected

    -- Check if the item is valid before proceeding
    if not reward or not QBCore.Shared.Items[reward] then
        print("Error: Invalid reward item!")  -- Debugging case where the reward item doesn't exist
        return
    end

    -- Random amount between 1 and 4 for the item
    local amount = math.random(1, 4)

    -- Add the item to the player's inventory using ox_inventory
    local item = QBCore.Shared.Items[reward]  -- Getting the item data
    if item then
        local success = exports.ox_inventory:AddItem(src, reward, amount)  -- Use ox_inventory's AddItem function

        if success then
            -- Notify the player and show the item in the inventory UI
            TriggerClientEvent('QBCore:Notify', src, 'You successfully stole a ' .. reward, 'success')
            TriggerClientEvent('ox_inventory:client:ItemBox', src, item, "add")
            print("Reward successfully given to player: " .. reward)  -- Debug message
        else
            -- If there was an issue adding the item, notify the player
            TriggerClientEvent('QBCore:Notify', src, 'Error: Could not give item', 'error')
            print("Error: Could not add the item to the player's inventory.")  -- Debug message
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Invalid reward item!', 'error')
        print("Invalid item selected: " .. reward)  -- Debug message
    end
end)