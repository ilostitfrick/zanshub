local AutoSteal = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOU/zanshub/main/modules/AutoSteal.lua"))()

local humanoid
local speedEnabled = false
local speedValue = 16

RunService.Heartbeat:Connect(function()
    if speedEnabled and humanoid then
        humanoid.WalkSpeed = speedValue
    end
end)


RunService.Stepped:Connect(function()
    if noclipEnabled and character then
        for _,v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

local AutoSteal = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/ilostitfrick/zanshub/main/modules/AutoSteal.lua"
))()

CreateToggle("Auto Steal", function(state)
    if state then
        AutoSteal.Enable()
    else
        AutoSteal.Disable()
    end
end)
