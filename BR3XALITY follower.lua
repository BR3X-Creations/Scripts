--------------------------------------------------------------------------------
-- DYLAN SCRIPT UI: A Custom Window with Three Teleport Buttons (Auto-Teleport Toggle)
--------------------------------------------------------------------------------

-- "Hello" Notification on Load
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "subscribe https://github.com/BR3XALITY!",
    Text = "Hello stalker or me if you're a fan or sub, great!",
    Duration = 5
})

-- ScreenGui & Main Frame
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DylanScriptUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 300, 0, 200)
box.Position = UDim2.new(0.5, -150, 0.5, -100)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
box.BorderSizePixel = 1
box.Name = "MainBox"
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.ClipsDescendants = true
box.Parent = screenGui

local TweenService = game:GetService("TweenService")
local originalSize = UDim2.new(0, 300, 0, 200)
local collapsedSize = UDim2.new(0, 300, 0, 30)
local isCollapsed = false

-- Title Label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Dylan Script"
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.Parent = box

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Parent = box
closeButton.MouseButton1Click:Connect(function()
    box.Visible = false
end)

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 0)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Text = "➖"
minimizeButton.TextSize = 20
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeButton.Parent = box
minimizeButton.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    local goal = isCollapsed and collapsedSize or originalSize
    TweenService:Create(box, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = goal}):Play()
end)

-- Drag Functionality
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    box.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

box.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = box.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

box.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Toggle Variables
local autoTele_SV = false
local autoTele_sVA = false
local autoTele_YLC = false

-- Auto-Teleport Function
local function autoTeleportLoop(targetName, toggleVarName, liftAmount, delay)
    local localPlayer = game.Players.LocalPlayer
    while _G[toggleVarName] do
        local target = game.Players:FindFirstChild(targetName)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and
           localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame =
                target.Character.HumanoidRootPart.CFrame + Vector3.new(0, liftAmount, 0)
        end
        wait(delay)
    end
end

-- Buttons Frame
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Size = UDim2.new(1, 0, 0, 160)
buttonsFrame.Position = UDim2.new(0, 0, 0, 40)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = box

-- Button A: Sito_Vega
local button1 = Instance.new("TextButton")
button1.Text = "Teleport to Sito_Vega"
button1.Size = UDim2.new(0, 200, 0, 40)
button1.Position = UDim2.new(0.5, -100, 0, 10)
button1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.TextSize = 18
button1.Font = Enum.Font.GothamBold
button1.Parent = buttonsFrame
button1.MouseButton1Click:Connect(function()
    autoTele_SV = not autoTele_SV
    _G.autoTele_SV = autoTele_SV
    if autoTele_SV then
        button1.Text = "Auto-Teleporting..."
        spawn(function()
            autoTeleportLoop("Sito_Vega", "autoTele_SV", 5, 0.01)
            button1.Text = "Teleport to Sito_Vega"
        end)
    else
        button1.Text = "Teleport to Sito_Vega"
    end
end)

-- Button B: sitovegaalt
local button2 = Instance.new("TextButton")
button2.Text = "Teleport to sitovegaalt"
button2.Size = UDim2.new(0, 200, 0, 40)
button2.Position = UDim2.new(0.5, -100, 0, 60)
button2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.TextSize = 18
button2.Font = Enum.Font.GothamBold
button2.Parent = buttonsFrame
button2.MouseButton1Click:Connect(function()
    autoTele_sVA = not autoTele_sVA
    _G.autoTele_sVA = autoTele_sVA
    if autoTele_sVA then
        button2.Text = "Auto-Teleporting..."
        spawn(function()
            autoTeleportLoop("sitovegaalt", "autoTele_sVA", 5, 0.01)
            button2.Text = "Teleport to sitovegaalt"
        end)
    else
        button2.Text = "Teleport to sitovegaalt"
    end
end)

-- Button C: Strong Teleport to YourLocalCornball
local button3 = Instance.new("TextButton")
button3.Text = "Strong Teleport to YourLocalCornball"
button3.Size = UDim2.new(0, 200, 0, 40)
button3.Position = UDim2.new(0.5, -100, 0, 110)
button3.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
button3.TextColor3 = Color3.fromRGB(255, 255, 255)
button3.TextSize = 18
button3.Font = Enum.Font.GothamBold
button3.Parent = buttonsFrame
button3.MouseButton1Click:Connect(function()
    autoTele_YLC = not autoTele_YLC
    _G.autoTele_YLC = autoTele_YLC
    if autoTele_YLC then
        button3.Text = "STRONG TELEPORTING..."
        spawn(function()
            autoTeleportLoop("YourLocalCornball", "autoTele_YLC", 10, 0.005)
            button3.Text = "Strong Teleport to YourLocalCornball"
        end)
    else
        button3.Text = "Strong Teleport to YourLocalCornball"
    end
end)
