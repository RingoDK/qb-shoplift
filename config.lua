Config = Config or {}

Config.AlertCooldown = 10000 -- 10 seconds cooldown for alert reset
Config.PoliceAlertChance = 0.75 -- Daytime police alert chance
Config.PoliceNightAlertChance = 0.50 -- Nighttime alert chance (01:00 - 06:00)
Config.Cooldown = 0 -- In minutes
Config.Chance = 100 -- 100% chance of successfully stealing something

Config.Translations = {
    Target = "Shoplift",
    PoliceAlertMessage = "Ongoing shoplifting",
    AlreadyShoplifted = "You have recently shoplifted",
    ShopliftProgressbar = "Trying to steal something...",
    canceled = "Canceled",
    NothingFound = "You did not find anything special to steal...",
}

-- 🏪 Regular Shops
Config.TargetLocations = {
    ["Shop1"] = {["coords"] = vector4(30.94, -1345.33, 29.51, 271.66)},
    ["Shop2"] = {["coords"] = vector4(28.21, -1345.191, 29.51, 271.66)},
    ["Shop3"] = {["coords"] = vector4(-709.75, -912.34, 19.26, 131.63)},
    ["Shop4"] = {["coords"] = vector4(-713.7043, -913.0905, 19.28019, 131.63)},
    ["Shop5"] = {["coords"] = vector4(-712.2653, -911.6414, 19.2957, 131.63)},
    ["Shop6"] = {["coords"] = vector4(-715.6313, -911.6693, 19.29983, 131.63)},
    ["Shop7"] = {["coords"] = vector4(-48.75, -1754.39, 28.87, 193.1)},
    ["Shop8"] = {["coords"] = vector4(-50.41, -1752.62, 28.76, 8.74)},
    ["Shop9"] = {["coords"] = vector4(-52.5, -1752.55, 28.24, 4.43)},
    ["Shop10"] = {["coords"] = vector4(-52.66, -1750.5, 28.39, 188.71)},
    ["Shop11"] = {["coords"] = vector4(1160.87, -322.4, 68.42, 60.04)},
    ["Shop12"] = {["coords"] = vector4(1158.04, -322.0, 68.11, 57.99)},
    ["Shop13"] = {["coords"] = vector4(1156.76, -323.95, 68.02, 52.13)},
    ["Shop14"] = {["coords"] = vector4(1155.05, -322.35, 68.28, 51.35)},
    ["Shop15"] = {["coords"] = vector4(379.58, 326.59, 102.53, 81.86)},
    ["Shop16"] = {["coords"] = vector4(376.68, 327.93, 102.39, 260.29)},
    ["Shop17"] = {["coords"] = vector4(-3041.99, 587.4, 7.34, 20.07)},
    ["Shop18"] = {["coords"] = vector4(-3042.81, 590.32, 6.73, 197.87)},
    ["Shop19"] = {["coords"] = vector4(-3243.55, 1006.64, 11.67, 180.25)},
    ["Shop20"] = {["coords"] = vector4(-3243.65, 1003.84, 11.48, 176.38)},
    ["Shop21"] = {["coords"] = vector4(543.01, 2668.73, 41.06, 278.03)},
    ["Shop22"] = {["coords"] = vector4(545.73, 2669.11, 40.93, 279.29)},
    ["Shop23"] = {["coords"] = vector4(2677.73, 3283.77, 53.97, 335.86)},
    ["Shop24"] = {["coords"] = vector4(2679.28, 3286.42, 54.15, 331.07)},
    ["Shop25"] = {["coords"] = vector4(1962.32, 3743.5, 31.81, 299.17)},
    ["Shop26"] = {["coords"] = vector4(1964.77, 3745.22, 31.34, 296.34)},
    ["Shop27"] = {["coords"] = vector4(1701.1, 4925.04, 41.43, 280.56)},
    ["Shop28"] = {["coords"] = vector4(1703.21, 4927.04, 41.03, 281.66)},
    ["Shop29"] = {["coords"] = vector4(1702.87, 4929.2, 40.94, 278.6)},
    ["Shop30"] = {["coords"] = vector4(1704.82, 4929.62, 41.03, 284.03)},
    ["Shop31"] = {["coords"] = vector4(1732.14, 6415.44, 34.4, 245.97)},
    ["Shop32"] = {["coords"] = vector4(1734.59, 6414.19, 33.8, 244.71)},
    ["Shop33"] = {["coords"] = vector4(164.43, 6640.74, 31.02, 226.48)},
    ["Shop34"] = {["coords"] = vector4(166.76, 6638.48, 30.88, 225.38)},
}

-- 🍾 Liquor Stores (Separated)
Config.LiquorStores = {
    ["Liquor1"] = {["coords"] = vector4(-1223.14, -904.82, 11.25, 306.14)},
    ["Liquor2"] = {["coords"] = vector4(1137.9, -982.48, 45.3, 189.49)},
    ["Liquor3"] = {["coords"] = vector4(-1489.08, -379.89, 38.97, 226.59)},
    ["Liquor4"] = {["coords"] = vector4(-2969.92, 392.0, 14.16, 356.62)},
    ["Liquor5"] = {["coords"] = vector4(1164.98, 2707.19, 37.07, 91.95)},
    ["Liquor6"] = {["coords"] = vector4(1390.3, 3600.95, 34.47, 109.14)},
}

-- 🎁 Stolen Items for Regular Shops
Config.Rewards = {
    "sandwich",
    "water_bottle",
    "tosti",
    "twerks_candy",
    "snikkel_candy",
}

-- 🍾 Stolen Items for Liquor Stores (Separate Section)
Config.LiquorRewards = {
    "beer",
    "vodka",
    "whiskey",
    "tequila",
    "rum",
    "gin",
    "champagne",
    "wine",
}

-- 🛑 Safety Check for Invalid Items (Added for better debugging and safety)
--[[Config.SafeCheck = function(item)
    if not item then
        print("Error: Invalid item!")
        return false
    end
    if not QBCore.Shared.Items[item] then
        print("Error: Item not found in shared items list: " .. item)
        return false
    end
    return true
end--]]