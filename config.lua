Config = {}

Config.Locale = 'en'

Config.Time = 60000        -- Time in ms before receiving XP (60000 = 1 minute)
Config.OxInventory = true  -- Use ox_inventory disarm event?
Config.XPJob = 3           -- XP awarded to whitelisted jobs
Config.NonJob = 1          -- XP awarded to all other jobs

-- Weapon restriction settings
Config.MaxRestrictedRank = 3 -- Players with rank 1 up to this rank cannot equip/fire weapons

-- Jobs that receive Config.XPJob instead of Config.NonJob
Config.WhitelistedJobs = {
    ['police'] = true,
    ['ambulance'] = true,
    ['mechanic'] = true
}

-- XP Export
function XPExport(xp)
    if xp and xp > 0 then
        exports.esx_xp:ESXP_Add(xp)
    end
end

-- Notification Wrapper (Fixed parameter order: msg, type, time)
function Notify(msg, type, time)
    type = type or 'info'
    time = time or 5000

    if ESX then
        ESX.ShowNotification(msg, type, time)
    end
end
