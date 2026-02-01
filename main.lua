-- main.lua (legit bootstrap)

local BASE = "https://raw.githubusercontent.com/ilostitfrick/zanshub/main/modules/"

local function fetchModule(name)
    local url = BASE .. name .. ".lua"
    local src = game:HttpGet(url)
    local fn = assert(loadstring(src), "Failed to load module: " .. name)
    return fn()
end

local UI = fetchModule("ui")

-- Example: load “speed” + “noclip” modules that are written for YOUR OWN game
local Speed = fetchModule("speed")
local Noclip = fetchModule("noclip")

local app = UI.create({
    title = "ZAN HUB • v1.0",
    tabs = {"Main", "Movement"},
})

app:addToggle("Movement", "Speed", false, function(on)
    if on then Speed.enable() else Speed.disable() end
end)

app:addSlider("Movement", "Speed Amount", 16, 60, 1, 16, function(value)
    Speed.set(value)
end)

app:addToggle("Movement", "Noclip", false, function(on)
    if on then Noclip.enable() else Noclip.disable() end
end)

app:show()

return true
