local QBCore = exports['qb-core']:GetCoreObject()

-- Register Key Bindings
RegisterKeyMapping('k9menu', 'Open K9 Menu', 'keyboard', 'K')

-- K9 Menu Command
RegisterCommand('k9menu', function()
    local Player = QBCore.Functions.GetPlayerData()
    if Config.RestrictJob and not Config.AllowedJobs[Player.job.name] then return end
    
    if not isK9Out then
        QBCore.Functions.Notify('You need to spawn your K9 first! Use /k9 spawn', 'error')
        return
    end
    
    -- Add your menu implementation here if you want to use a menu system
    -- Example with qb-menu:
    -- exports['qb-menu']:openMenu({
    --     {
    --         header = "K9 Commands",
    --         isMenuHeader = true
    --     },
    --     {
    --         header = "Attack",
    --         txt = "Order K9 to attack nearest threat",
    --         params = {
    --             event = "teck-k9:client:attack"
    --         }
    --     },
    --     -- Add more menu options
    -- })
end)

-- Register Events for Menu Integration
RegisterNetEvent('teck-k9:client:attack', function()
    ExecuteCommand('k9 attack')
end)

RegisterNetEvent('teck-k9:client:search', function()
    ExecuteCommand('k9 search')
end)

RegisterNetEvent('teck-k9:client:follow', function()
    ExecuteCommand('k9 follow')
end)

RegisterNetEvent('teck-k9:client:stay', function()
    ExecuteCommand('k9 stay')
end)

RegisterNetEvent('teck-k9:client:dismiss', function()
    ExecuteCommand('k9 dismiss')
end)
