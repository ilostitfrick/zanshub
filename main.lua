-- =========================
-- ZAN HUB - MAIN ENTRY
-- =========================

if _G.__ZANHUB_LOADED then
    warn("ZANHUB already loaded")
    return
end
_G.__ZANHUB_LOADED = true

-- services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- cleanup old gui
if PlayerGui:FindFirstChild("ZANHUB") then
    PlayerGui.ZANHUB:Destroy()
end

-- =========================
-- GUI ROOT
-- =========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZANHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- expose for modules if needed
_G.ZANHUB_GUI = ScreenGui

-- =========================
-- LOAD MODULES
-- =========================

local Modules = {
    local Modules = {
    AntiRagdoll = loadstring(game:HttpGet("https://raw.githubusercontent.com/ilostitfrick/zanshub/main/modules/AntiRagdoll.lua"))(),
    AutoGrab = loadstring(game:HttpGet("https://raw.githubusercontent.com/ilostitfrick/zanshub/main/modules/AutoGrab.lua"))(),
    AutoSteal = loadstring(game:HttpGet("https://raw.githubusercontent.com/ilostitfrick/zanshub/main/modules/AutoSteal.lua"))(),
    ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/ilostitfrick/zanshub/main/modules/ESP.lua"))(),
    Finder = loadstring(game:HttpGet("https://raw.githubusercontent.com/ilostitfrick/zanshub/main/modules/Finder.lua"))(),
    InstantSteal = loadstring(game:HttpGet("https://raw.githubusercontent.com/ilostitfrick/zanshub/main/modules/InstantSteal.lua"))(),
}

local ModulesFolder = script:WaitForChild("modules")

for _, module in ipairs(ModulesFolder:GetChildren()) do
    if module:IsA("ModuleScript") then
        local ok, mod = pcall(require, module)
        if ok then
            Modules[module.Name] = mod

            -- auto-init pattern
            if type(mod) == "table" and type(mod.Init) == "function" then
                task.spawn(function()
                    mod.Init(ScreenGui)
                end)
            end
        else
            warn("Failed to load module:", module.Name)
        end
    end
end

print("ZANHUB loaded successfully")


