local QBCore = exports['qb-core']:GetCoreObject()

isBreakRoomSystemCoolDownActive = false
local ResetStress = false

QBCore.Functions.CreateCallback('qb-breakroom:playerStress', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.metadata['stress'] > 0 then
        cb(true)
    else
        cb(false)
    end
    print(json.encode(Player.PlayerData.metadata['stress']))
end)

RegisterNetEvent('qb-breakroom:server:RelieveStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not Player and Player.PlayerData.job.name == 'police' then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
end)

RegisterNetEvent('qb-breakroom:server:SetBreakRoomSystemCooldown')
AddEventHandler('qb-breakroom:server:SetBreakRoomSystemCooldown', function()
    isBreakRoomSystemCoolDownActive = true
    Wait((5 * 500) * 15)
    isBreakRoomSystemCoolDownActive = false
end)

QBCore.Functions.CreateCallback("qb-breakroom:server:BreakRoomSystemCooldown",function(_, cb)
    if isBreakRoomSystemCoolDownActive then
        cb(true)
    else
        cb(false)
    end
end)
