ESX = nil
local ESXP = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
    
end)

-- Add yours

Citizen.CreateThread(function()
    while not ESXP do
        TriggerEvent("esx_xp:isReady", function(ready)
            ESXP = ready
        end)
        Citizen.Wait(10)
    end

    local sleep = 1200
    local time = Config.Time
    while true do
        sleep = 5
        Wait(time)
        if ESX.PlayerData.job.name == 'police' then 
            XPExport(Config.XPJob)
            Notify(Lang['give_xp'] .. Config.XPJob .. '', 'info')
        elseif ESX.PlayerData.job.name == 'ambulance' then
            XPExport(Config.XPJob)
            Notify(Lang['give_xp'] .. Config.XPJob .. '', 'info')
		elseif ESX.PlayerData.job.name == 'mechanic' then
            XPExport(Config.XPJob)
            Notify(Lang['give_xp'] .. Config.XPJob .. '', 'info')
        else
            XPExport(Config.XPJob)
            Notify(Lang['give_xp_nonjob'] .. Config.NonJob .. '', 'info')
        end
        Wait(sleep)
    end
end) 

CreateThread(function()
    while true do
        Citizen.Wait(3)
        local xPlayer = ESX.GetPlayerData()
        local xRank = xPlayer.rank

        if xRank == 1 then
            DisablePlayerFiring(ESX.PlayerData.ped,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
            DisableControlAction(0, 24, true) -- LEFT MOUSE BUTTON
            DisableControlAction(0, 25, true) -- RIGHT MOUSE BUTTON
            DisableControlAction(0, 37, true) -- TAB
            DisableControlAction(0, 140, true)
            if Config.OxInventory then
                if IsDisabledControlJustPressed(2, 37) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 24) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 25) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 37) then
                    TriggerEvent('ox_inventory:disarm')
                end
            end
		elseif xRank == 2 then	
            DisablePlayerFiring(ESX.PlayerData.ped,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
            DisableControlAction(0, 24, true) -- LEFT MOUSE BUTTON
            DisableControlAction(0, 25, true) -- RIGHT MOUSE BUTTON
            DisableControlAction(0, 37, true) -- TAB
            DisableControlAction(0, 140, true)
            if Config.OxInventory then
                if IsDisabledControlJustPressed(2, 37) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 24) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 25) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 37) then
                    TriggerEvent('ox_inventory:disarm')
                end
            end
		elseif xRank == 3 then	
			DisablePlayerFiring(ESX.PlayerData.ped,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
            DisableControlAction(0, 24, true) -- LEFT MOUSE BUTTON
            DisableControlAction(0, 25, true) -- RIGHT MOUSE BUTTON
            DisableControlAction(0, 37, true) -- TAB
            DisableControlAction(0, 140, true)
            if Config.OxInventory then
                if IsDisabledControlJustPressed(2, 37) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 24) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 25) then
                    TriggerEvent('ox_inventory:disarm')
                end
                if IsDisabledControlJustPressed(0, 37) then
                    TriggerEvent('ox_inventory:disarm')
                end
            end
        end
    end
end)