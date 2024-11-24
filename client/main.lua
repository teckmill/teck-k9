local QBCore = exports['qb-core']:GetCoreObject()
local K9 = nil
local isK9Out = false
local following = false
local searching = false
local attacking = false

-- Initialize K9 Handler
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local Player = QBCore.Functions.GetPlayerData()
    if Config.RestrictJob and not Config.AllowedJobs[Player.job.name] then return end
    TriggerEvent('teck-k9:client:initializeK9Handler')
end)

-- Spawn K9
local function SpawnK9()
    if isK9Out then return end
    
    local model = Config.K9Model
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    
    local playerPed = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.0)
    
    K9 = CreatePed(28, model, coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, true)
    SetEntityAsMissionEntity(K9, true, true)
    SetPedHearingRange(K9, 100.0)
    SetPedSeeingRange(K9, 100.0)
    SetPedAlertness(K9, 100.0)
    SetPedFleeAttributes(K9, 0, 0)
    SetPedCombatAttributes(K9, 46, true)
    SetPedStrongOnPhysicalImpact(K9, true)
    
    isK9Out = true
    following = true
    
    -- Start following behavior
    CreateThread(function()
        while isK9Out and following do
            local playerCoords = GetEntityCoords(playerPed)
            local dogCoords = GetEntityCoords(K9)
            local distance = #(playerCoords - dogCoords)
            
            if distance > Config.FollowDistance then
                TaskGoToEntity(K9, playerPed, -1, 2.0, 7.0, 0, 0)
            end
            Wait(1000)
        end
    end)
end

-- K9 Commands
RegisterCommand(Config.CommandName, function(source, args)
    local Player = QBCore.Functions.GetPlayerData()
    if Config.RestrictJob and not Config.AllowedJobs[Player.job.name] then 
        QBCore.Functions.Notify('You are not authorized to use K9', 'error')
        return 
    end
    
    if not args[1] then
        QBCore.Functions.Notify('Usage: /' .. Config.CommandName .. ' [spawn/dismiss/attack/search/follow/stay]', 'error')
        return
    end
    
    local command = args[1]:lower()
    
    if command == 'spawn' then
        SpawnK9()
    elseif command == 'dismiss' and isK9Out then
        DeleteEntity(K9)
        isK9Out = false
    elseif command == 'attack' and isK9Out then
        local closestPlayer = GetClosestPlayer()
        if closestPlayer then
            attacking = true
            TaskCombatPed(K9, GetPlayerPed(closestPlayer), 0, 16)
        end
    elseif command == 'search' and isK9Out then
        local vehicle = GetClosestVehicle()
        if vehicle then
            searching = true
            PlayAnimation('searchhit')
            Wait(Config.SearchTime)
            TriggerServerEvent('teck-k9:server:SearchVehicle', VehToNet(vehicle))
            searching = false
        end
    elseif command == 'follow' and isK9Out then
        following = true
        attacking = false
        ClearPedTasks(K9)
    elseif command == 'stay' and isK9Out then
        following = false
        attacking = false
        ClearPedTasks(K9)
        PlayAnimation('sit')
    end
end)

-- Helper Functions
function GetClosestPlayer()
    local players = GetActivePlayers()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local closestDistance = Config.AttackDistance
    local closestPlayer = nil
    
    for _, player in ipairs(players) do
        local targetPed = GetPlayerPed(player)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(coords - targetCoords)
            if distance < closestDistance then
                closestPlayer = player
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer
end

function GetClosestVehicle()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    return vehicle ~= 0 and vehicle or nil
end

function PlayAnimation(animName)
    if not Config.Animations[animName] then return end
    
    local anim = Config.Animations[animName]
    RequestAnimDict(anim.dict)
    while not HasAnimDictLoaded(anim.dict) do Wait(0) end
    
    TaskPlayAnim(K9, anim.dict, anim.anim, 8.0, -8.0, anim.time, 1, 0, false, false, false)
end

-- Cleanup
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if isK9Out then DeleteEntity(K9) end
end)
