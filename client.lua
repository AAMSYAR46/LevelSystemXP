ESX = nil -- Kept global so config.lua's Notify() can access ESX.ShowNotification

local ESXP = false
local PlayerLoaded = false
local PlayerData = {}
local CurrentRank = 0

-- 1. Initialize ESX (supports both ESX Legacy and older versions)
CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        local ok, obj = pcall(function()
            return exports['es_extended']:getSharedObject()
        end)
        if ok and obj then
            ESX = obj
        end
    end

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(100)
    end

    if ESX.IsPlayerLoaded() then
        PlayerData = ESX.GetPlayerData()
        CurrentRank = PlayerData.rank or 0
        PlayerLoaded = true
    end
end)

-- 2. Keep player job & rank synced dynamically
RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    CurrentRank = xPlayer.rank or 0
    PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:setPlayerData', function(key, val)
    PlayerData[key] = val
    if key == 'rank' then
        CurrentRank = val or 0
    end
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    PlayerLoaded = false
    PlayerData = {}
    CurrentRank = 0
end)

-- 3. Periodic XP Reward Loop
CreateThread(function()
    while not ESXP do
        TriggerEvent('esx_xp:isReady', function(ready)
            ESXP = ready
        end)
        Wait(100)
    end

    while not PlayerLoaded do
        Wait(250)
    end

    local interval = Config.Time or 60000

    while true do
        Wait(interval)

        if PlayerLoaded and PlayerData.job then
            if Config.WhitelistedJobs[PlayerData.job.name] then
                XPExport(Config.XPJob)
                Notify(Lang['give_xp'] .. Config.XPJob, 'info')
            else
                XPExport(Config.NonJob)
                Notify(Lang['give_xp_nonjob'] .. Config.NonJob, 'info')
            end
        end
    end
end)

-- 4. Lightweight Rank Sync Fallback (runs once per second instead of every 3ms)
CreateThread(function()
    while true do
        if PlayerLoaded and ESX then
            local data = ESX.GetPlayerData()
            if data and data.rank ~= nil then
                CurrentRank = data.rank
            end
        end
        Wait(1000)
    end
end)

-- 5. Weapon & Firing Restriction for Restricted Ranks
CreateThread(function()
    local maxRank = Config.MaxRestrictedRank or 3

    while true do
        if PlayerLoaded and CurrentRank >= 1 and CurrentRank <= maxRank then
            local ped = PlayerPedId()

            DisablePlayerFiring(ped, true)
            DisableControlAction(0, 24, true)  -- Left Mouse Button (Attack)
            DisableControlAction(0, 25, true)  -- Right Mouse Button (Aim)
            DisableControlAction(0, 37, true)  -- Tab (Weapon Wheel)
            DisableControlAction(0, 140, true) -- R (Light Melee)

            if Config.OxInventory then
                if IsDisabledControlJustPressed(0, 24)
                    or IsDisabledControlJustPressed(0, 25)
                    or IsDisabledControlJustPressed(0, 37)
                    or IsDisabledControlJustPressed(2, 37)
                then
                    TriggerEvent('ox_inventory:disarm')
                end
            end

            Wait(0)
        else
            Wait(1000)
        end
    end
end)
