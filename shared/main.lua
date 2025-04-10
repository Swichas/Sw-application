Config = {}

Config.UseTarget = true
Config.Areas = {
    {
        label = "Police Application",
        Coords = vector3(441.0975, -980.4554, 31.0620),
        job = "police", 
        Blip = {
            enabled = false,
            sprite = 1,
            size = 0.7,
            colour = 1,
        },
        TargetSettings = { 
            radius = 2,
            debug = false,
            icon = "fa-solid fa-list-check",
            label = "Police Application"
        },
        MarkerSettings = { 
            DrawMarker = true,
            size = vec3(1, 1, 1),
            rotation = vec3(1, 1, 1),
            type = 21,
            Distance = 10.0,
            colour = {r = 50, g = 200, b = 50, a = 200},
            TextUI = "[E] -> Police Applications"
        },
    }
}

Config.ApplicationSettings = {
    Cooldown = {
        enabled = true,
        time = 5 * 60000 
    },
}
