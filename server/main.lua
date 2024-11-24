local QBCore = exports['qb-core']:GetCoreObject()

-- Search Vehicle Event
RegisterNetEvent('teck-k9:server:SearchVehicle', function(netId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    if Config.RestrictJob and not Config.AllowedJobs[Player.job.name] then 
        return 
    end
    
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not vehicle then return end
    
    local trunk = GetVehicleTrunkInventoryItems(netId)
    local contraband = false
    
    for _, item in pairs(trunk) do
        if Config.DetectableItems[item.name] then
            contraband = true
            break
        end
    end
    
    TriggerClientEvent('QBCore:Notify', src, contraband and 'K9 indicates presence of contraband!' or 'K9 found nothing suspicious', contraband and 'success' or 'error')
end)

-- Helper function to get trunk items (integrate with your inventory system)
function GetVehicleTrunkInventoryItems(netId)
    -- This should be integrated with your specific inventory system
    -- Below is a placeholder implementation
    local items = {}
    -- Add logic to get items from vehicle trunk
    return items
end

-- Version Check
local function CheckVersion()
    PerformHttpRequest('https://api.github.com/repos/teck-scripts/teck-k9/releases/latest', function(err, text, headers)
        if err == 200 then
            local data = json.decode(text)
            local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
            if data.tag_name ~= currentVersion then
                print('^1[teck-k9]^7 New version available: ' .. data.tag_name)
                print('^1[teck-k9]^7 Download: ' .. data.html_url)
            end
        end
    end, 'GET')
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    CheckVersion()
end)
