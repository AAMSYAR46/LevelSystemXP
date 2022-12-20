Config = {}

Config.Locale = 'en'

Config.Time = 60000 -- Time berfore get xp
Config.OxInventory  = true -- Use ox inventory?
Config.XPJob = 3
Config.NonJob = 1

-- XP Exports
function XPExport(xp)
    exports.esx_xp:ESXP_Add(xp)
end
-- Set Notify
function Notify(msg, time, type)
    ESX.ShowNotification(msg, type)
end