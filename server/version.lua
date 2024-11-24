local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
local resourceName = GetCurrentResourceName()

local function checkVersion()
    -- Disabled online version check for now
    print('^2[' .. resourceName .. '] Version: ^7' .. currentVersion)
    print('^2[' .. resourceName .. '] Successfully loaded!^7')
end

CreateThread(function()
    Wait(2000) -- Wait 2 seconds before checking version
    checkVersion()
end)

-- Export version check function
exports('getVersion', function()
    return currentVersion
end)
