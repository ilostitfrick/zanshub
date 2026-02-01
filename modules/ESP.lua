local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local enabled = false
local connections = {}

local function createESP(model)
    if model:IsA("Model") and model:FindFirstChild("RootPart") then
        local root = model.RootPart
        if root:FindFirstChild("ZAN_ESP") then return end

        local gui = Instance.new("BillboardGui")
        gui.Name = "ZAN_ESP"
        gui.Size = UDim2.new(0, 100, 0, 40)
        gui.StudsOffset = Vector3.new(0, 3, 0)
        gui.AlwaysOnTop = true
        gui.Parent = root

        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.Text = model.Name
        txt.TextColor3 = Color3.new(1,1,0)
        txt.TextScaled = true
        txt.Parent = gui
    end
end

return {
    Enable = function()
        if enabled then return end
        enabled = true

        for _, m in ipairs(workspace:GetChildren()) do
            createESP(m)
        end

        table.insert(connections,
            workspace.ChildAdded:Connect(createESP)
        )
    end,

    Disable = function()
        enabled = false
        for _, c in ipairs(connections) do pcall(function() c:Disconnect() end) end
        table.clear(connections)

        for _, m in ipairs(workspace:GetDescendants()) do
            if m.Name == "ZAN_ESP" then m:Destroy() end
        end
    end
}
