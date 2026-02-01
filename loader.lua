-- Zan Hub Loader
local base = "https://raw.githubusercontent.com/ilostitfrick/zanshub/main/"

local function fetch(path)
    return game:HttpGet(base .. path)
end

local main = loadstring(fetch("main.lua"))
return main()
