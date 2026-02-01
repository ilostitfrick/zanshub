-- =========================
-- ZANS HUB - SAFE INIT FIX
-- =========================

-- prevent double execution
if _G.__ZANSHUB_LOADED then
    warn("ZansHub already loaded")
    return
end
_G.__ZANSHUB_LOADED = true

-- services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- cleanup old gui if exists
if PlayerGui:FindFirstChild("ZansHub") then
    PlayerGui.ZansHub:Destroy()
end

-- =========================
-- YOUR UI CODE STARTS HERE
-- =========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZansHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇
-- KEEP EVERYTHING BELOW
-- EXACTLY HOW YOU HAD IT
-- ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇

-- example:
-- local Frame = Instance.new("Frame")
-- Frame.Parent = ScreenGui
-- your toggles, buttons, callbacks etc stay unchanged
