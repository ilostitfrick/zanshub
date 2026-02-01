local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local enabled = false
local conn

return {
    Enable = function()
        if enabled then return end
        enabled = true

        conn = RunService.Heartbeat:Connect(function()
            if not enabled then return end
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt")
                and v.Enabled
                and v.HoldDuration > 0 then
                    local p = v.Parent
                    if p and (p.Position - hrp.Position).Magnitude <= 20 then
                        pcall(function()
                            fireproximityprompt(v, 0)
                        end)
                    end
                end
            end
        end)
    end,

    Disable = function()
        enabled = false
        if conn then conn:Disconnect() conn = nil end
    end
}
