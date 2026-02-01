-- ZAN HUB v1.0 (UI + Module System)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Cleanup
pcall(function()
    CoreGui:FindFirstChild("ZAN_HUB"):Destroy()
end)

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "ZAN_HUB"
Gui.Parent = CoreGui
Gui.ResetOnSpawn = false

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 520, 0, 360)
Main.Position = UDim2.new(0.5, -260, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Text = "ZAN HUB • v1.0"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(220,220,255)
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 8)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Left

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 120, 1, -60)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(20,20,26)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- Content
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -150, 1, -60)
Content.Position = UDim2.new(0, 140, 0, 50)
Content.BackgroundColor3 = Color3.fromRGB(22,22,30)
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 10)

-- Tabs system
local Tabs = {}
local CurrentTab

local function createTab(name)
    local frame = Instance.new("Frame", Content)
    frame.Size = UDim2.new(1, -20, 1, -20)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.Visible = false
    frame.BackgroundTransparency = 1
    Tabs[name] = frame
    return frame
end

local function switchTab(name)
    if CurrentTab then Tabs[CurrentTab].Visible = false end
    Tabs[name].Visible = true
    CurrentTab = name
end

-- Sidebar button
local function sideButton(text, y, tab)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(1, -16, 0, 36)
    b.Position = UDim2.new(0, 8, 0, y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BackgroundColor3 = Color3.fromRGB(30,30,40)
    b.TextColor3 = Color3.fromRGB(230,230,255)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        switchTab(tab)
    end)
end

-- Create Tabs
local MainTab = createTab("Main")
local StealTab = createTab("Steal")
local ESPTab = createTab("ESP")
local FinderTab = createTab("Finder")

sideButton("Main", 10, "Main")
sideButton("Steal", 54, "Steal")
sideButton("ESP", 98, "ESP")
sideButton("Finder", 142, "Finder")

switchTab("Main")

-- Toggle template
local function Toggle(parent, text, y, callback)
    local holder = Instance.new("Frame", parent)
    holder.Size = UDim2.new(1, -20, 0, 40)
    holder.Position = UDim2.new(0, 10, 0, y)
    holder.BackgroundColor3 = Color3.fromRGB(28,28,38)
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel", holder)
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(230,230,255)
    label.Size = UDim2.new(1, -70, 1, 0)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Left

    local state = false
    local btn = Instance.new("TextButton", holder)
    btn.Size = UDim2.new(0, 50, 0, 22)
    btn.Position = UDim2.new(1, -60, 0.5, -11)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", btn)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(220,220,255)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    btn.MouseButton1Click:Connect(function()
        state = not state
        knob.Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        btn.BackgroundColor3 = state and Color3.fromRGB(0,170,255) or Color3.fromRGB(60,60,80)
        callback(state)
    end)
end

-- SLIDER (Speed)
local function Slider(parent, text, y, min, max, callback)
    local label = Instance.new("TextLabel", parent)
    label.Text = text
    label.Position = UDim2.new(0, 10, 0, y)
    label.Size = UDim2.new(1, -20, 0, 20)
    label.TextColor3 = Color3.fromRGB(230,230,255)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Left

    local bar = Instance.new("Frame", parent)
    bar.Position = UDim2.new(0, 10, 0, y + 22)
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.BackgroundColor3 = Color3.fromRGB(60,60,80)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)

    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            local x = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * x)
            fill.Size = UDim2.new(x, 0, 1, 0)
            callback(value)
        end
    end)
end

-- MODULE HOOKS (PUT YOUR LOGIC HERE)
local Modules = {
    AutoSteal = {Enable=function() end, Disable=function() end},
    AutoGrab  = {Enable=function() end, Disable=function() end},
    ESP       = {Enable=function() end, Disable=function() end},
    Noclip    = {Enable=function() end, Disable=function() end},
    Speed     = {Set=function(v)
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = v end
    end}
}

-- UI Controls
Toggle(MainTab, "Noclip", 10, function(on)
    on and Modules.Noclip.Enable() or Modules.Noclip.Disable()
end)

Slider(MainTab, "Speed (0–60)", 60, 0, 60, function(v)
    Modules.Speed.Set(v)
end)

Toggle(StealTab, "Instant Steal", 10, function(on)
    on and Modules.AutoSteal.Enable() or Modules.AutoSteal.Disable()
end)

Toggle(StealTab, "Auto Grab", 60, function(on)
    on and Modules.AutoGrab.Enable() or Modules.AutoGrab.Disable()
end)

Toggle(ESPTab, "ESP", 10, function(on)
    on and Modules.ESP.Enable() or Modules.ESP.Disable()
end)

print("[ZAN HUB] Loaded successfully")

