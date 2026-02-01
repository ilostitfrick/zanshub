local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local enabled = false
local connections = {}

local function cleanCharacter(char)
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BallSocketConstraint")
        or d:IsA("NoCollisionConstraint")
        or d:IsA("HingeConstraint")
        or d:IsA("BodyVelocity")
        or d:IsA("BodyPosition")
        or d:IsA("BodyGyro") then
            d:Destroy()
        end
    end
end

local function hookCharacter(char)
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")

    table.insert(connections, hum.StateChanged:Connect(function(_, new)
        if enabled and (
            new == Enum.HumanoidStateType.Ragdoll
            or new == Enum.HumanoidStateType.Physics
            or new == Enum.HumanoidStateType.FallingDown
        ) then
            hum:ChangeState(Enum.HumanoidStateType.Running)
            root.AssemblyLinearVelocity = Vector3.zero
            cleanCharacter(char)
        end
    end))

    table.insert(connections, RunService.Heartbeat:Connect(function()
        if enabled then
            root.AssemblyLinearVelocity = Vector3.zero
        end
    end))
end

return {
    Enable = function()
        if enabled then return end
        enabled = true
        if LocalPlayer.Character then
            hookCharacter(LocalPlayer.Character)
        end
        table.insert(connections, LocalPlayer.CharacterAdded:Connect(hookCharacter))
    end,

    Disable = function()
        enabled = false
        for _, c in ipairs(connections) do pcall(function() c:Disconnect() end) end
        table.clear(connections)
    end
}
