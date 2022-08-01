Config = {}

Config.DebugPolyzone = false
Config.DebugMode = false
Config.RelieveIntervals = math.random(7500, 8500)

Config.BreakZones = {
    [1] = {
        label = "mrpdbreakroom", -- MRPD 1st Floor Break Room
        zones = vector4(461.65, -979.71, 30.69, 88.0),
        length = 5,
        width = 7,
    
    },
    [2] = {
        label = "mrpdmeetingroom", -- MRPD 2nd Floor Meeting Room
        zones = vector4(444.88, -985.59, 34.97, 86.95),
        length = 11,
        width = 10,
    },
}