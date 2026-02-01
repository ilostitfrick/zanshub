-- loader.lua (legit loader pattern)

local BASE = "https://raw.githubusercontent.com/ilostitfrick/zanshub/main/"

local function fetch(path)
    local url = BASE .. path
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if not ok then
        warn("[ZANHUB] Failed to fetch:", url, res)
        return nil
    end
    return res
end

local src = fetch("main.lua")
if not src then return end

local fn, err = loadstring(src)
if not fn then
    warn("[ZANHUB] loadstring error:", err)
    return
end

return fn()
