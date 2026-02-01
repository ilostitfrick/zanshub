local source = game:HttpGet(
    "https://raw.githubusercontent.com/ilostitfrick/zanshub/main/main.lua"
)

local fn = loadstring(source)
if fn then
    fn()
else
    warn("Failed to load ZansHub")
end
