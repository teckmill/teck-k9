-- Animation Dictionary Cache
local loadedAnimDicts = {}

-- Load Animation Dictionary
local function LoadAnimDict(dict)
    if not loadedAnimDicts[dict] then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
        loadedAnimDicts[dict] = true
    end
end

-- Unload Animation Dictionary
local function UnloadAnimDict(dict)
    if loadedAnimDicts[dict] then
        RemoveAnimDict(dict)
        loadedAnimDicts[dict] = nil
    end
end

-- Play K9 Animation
function PlayK9Animation(k9Ped, animName)
    if not Config.Animations[animName] then return end
    
    local anim = Config.Animations[animName]
    LoadAnimDict(anim.dict)
    
    TaskPlayAnim(k9Ped, anim.dict, anim.anim, 8.0, -8.0, anim.time, 1, 0, false, false, false)
    
    if anim.time > 0 then
        SetTimeout(anim.time, function()
            UnloadAnimDict(anim.dict)
        end)
    end
end

-- Play K9 Attack Animation
function PlayK9AttackAnimation(k9Ped)
    local dict = Config.K9Config.attack.animation
    LoadAnimDict(dict)
    TaskPlayAnim(k9Ped, dict, "attack", 8.0, -8.0, -1, 1, 0, false, false, false)
end

-- Play K9 Search Animation
function PlayK9SearchAnimation(k9Ped)
    local dict = Config.K9Config.search.animation
    LoadAnimDict(dict)
    TaskPlayAnim(k9Ped, dict, "indicate_high", 8.0, -8.0, Config.SearchTime, 1, 0, false, false, false)
    
    SetTimeout(Config.SearchTime, function()
        UnloadAnimDict(dict)
    end)
end

-- Play K9 Follow Animation
function PlayK9FollowAnimation(k9Ped)
    local dict = Config.K9Config.follow.animation
    LoadAnimDict(dict)
    TaskPlayAnim(k9Ped, dict, "run", 8.0, -8.0, -1, 1, 0, false, false, false)
end

-- Play K9 Stay Animation
function PlayK9StayAnimation(k9Ped)
    local dict = Config.K9Config.stay.animation
    LoadAnimDict(dict)
    TaskPlayAnim(k9Ped, dict, "base", 8.0, -8.0, -1, 1, 0, false, false, false)
end

-- Cleanup animations on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    for dict, _ in pairs(loadedAnimDicts) do
        UnloadAnimDict(dict)
    end
end)
