local QBCore = exports['qb-core']:GetCoreObject() 

-- Script Locals
local PlayerData = QBCore.Functions.GetPlayerData()
local stressed = false
local stress = 0

-- Function
function StressCheck()
    QBCore.Functions.TriggerCallback('qb-breakroom:playerStress', function(cb)
        if cb then
                stressed = true
                RelieveStress()
            if Config.DebugMode then
                print('Stressed')
            end 
        else
            if Config.DebugMode then
                print('Not Stressed')
            end
        end
    end)
end

function RelieveStress()
    if stressed then
        Citizen.Wait(Config.RelieveIntervals)
        TriggerServerEvent('hud:server:RelieveStress', 100)
        if Config.DebugMode == true then
            print('qb-breakroom: Entered Zone')
        end
    else
        QBCore.Functions.Notify(Lang:t("error.break_not_needed"), "error")
        if Config.DebugMode == true then
            print('qb-breakroom: Break Not Needed')
        end
    end
end


--Threads
CreateThread(function()
    for k, v in pairs(Config.BreakZones) do
        local BreakZone = BoxZone:Create(vector4(vector4(v.zones.x, v.zones.y, v.zones.z, v.zones.w)), Config.BreakZones[k].length, Config.BreakZones[k].width, {
            name= Config.BreakZones[k].label,
			debugPoly = Config.DebugPolyzone,
            heading = v.zones.w,
            minZ = v.zones.z - 2,
            maxZ = v.zones.z + 2,
        })

        BreakZone:onPlayerInOut(function(isPointInside)
			if isPointInside then
                inZone = Config.BreakZones[k].label
                if inZone ~= 0 then
                    StressCheck()
                end
            else
                inZone = 0
                stressed = false
                if Config.DebugMode == true then
                    print('qb-breakroom: Left Zone')
                    print(stressed)
                end
                Wait(250)
                QBCore.Functions.TriggerCallback('qb-breakroom:server:BreakRoomSystemCooldown', function(result)
                    if not result then
                        QBCore.Functions.Notify(Lang:t("success.left_room"), "success")
                        TriggerServerEvent('qb-breakroom:server:SetBreakRoomSystemCooldown')
                    end
                end)
            end
		end)
    end
end)

-- Events
RegisterCommand('setstress', function()
    if Config.DebugMode == true then
        TriggerServerEvent('hud:server:GainStress', 100)
    else
        QBCore.Functions.Notify(Lang:t("error.debugmode_off"), "error")
    end
end)


RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)


