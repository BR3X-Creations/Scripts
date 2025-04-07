-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DenDenZZZ/Kavo-UI-Library/main/Kavo.lua"))()
local Window = Library.CreateLib("Aimbot UI", "DarkTheme")

-- Aimbot toggle variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local aimbotEnabled = false
local switchDistance = 40
local currentTarget = nil
local indicatorGui = nil
local shootStatusLabel

-- Create visual indicator
local function createIndicator(targetPart)
    if indicatorGui then indicatorGui:Destroy() end
    indicatorGui = Instance.new("BillboardGui")
    indicatorGui.Name = "TargetIndicator"
    indicatorGui.Size = UDim2.new(0, 10.8, 0, 10.8) -- 10% smaller
    indicatorGui.AlwaysOnTop = true
    indicatorGui.StudsOffset = Vector3.new(0, 3, 0)
    indicatorGui.Parent = targetPart

    local redDot = Instance.new("Frame")
    redDot.Size = UDim2.new(1, 0, 1, 0)
    redDot.BackgroundColor3 = Color3.new(1, 0, 0)
    redDot.BackgroundTransparency = 0.2
    redDot.BorderSizePixel = 0
    redDot.Parent = indicatorGui
end

-- Shoot status UI
local function createShootStatusUI()
    shootStatusLabel = Instance.new("TextLabel")
    shootStatusLabel.Size = UDim2.new(0, 180, 0, 45) -- 10% smaller
    shootStatusLabel.Position = UDim2.new(0, 10, 0, 10)
    shootStatusLabel.BackgroundTransparency = 1
    shootStatusLabel.TextColor3 = Color3.new(1, 0, 0)
    shootStatusLabel.TextSize = 18
    shootStatusLabel.Font = Enum.Font.GothamBold
    shootStatusLabel.Text = "Shoot Status: None"
    shootStatusLabel.Parent = game:GetService("CoreGui")
end

local function getSmartTarget()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
    local myHRP = myChar.HumanoidRootPart
    local myPos = myHRP.Position

    local closestPlayer, closestDist = nil, math.huge
    local lookingAtYouPlayer = nil

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local theirHRP = player.Character.HumanoidRootPart
            local distance = (theirHRP.Position - myPos).Magnitude
            local isLookingAtYou = theirHRP.CFrame.LookVector:Dot((myPos - theirHRP.Position).Unit) > 0.7

            if isLookingAtYou and distance <= switchDistance then
                lookingAtYouPlayer = player
            end
            if distance < closestDist then
                closestDist = distance
                closestPlayer = player
            end
        end
    end

    return lookingAtYouPlayer or closestPlayer
end

local function canShootAtTarget(targetHRP)
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return false end

    local myHRP = myChar.HumanoidRootPart
    local ray = Ray.new(myHRP.Position, (targetHRP.Position - myHRP.Position).unit * 100)
    local hit, _ = workspace:FindPartOnRay(ray, myChar)

    return not hit
end

RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    local target = getSmartTarget()
    local myChar = LocalPlayer.Character

    if target and myChar and myChar:FindFirstChild("HumanoidRootPart") and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        if currentTarget ~= target then
            currentTarget = target
            createIndicator(currentTarget.Character.HumanoidRootPart)
        end

        local myHRP = myChar.HumanoidRootPart
        local targetHRP = currentTarget.Character.HumanoidRootPart
        local dir = (targetHRP.Position - myHRP.Position).Unit

        myHRP.CFrame = CFrame.new(myHRP.Position, myHRP.Position + Vector3.new(dir.X, 0, dir.Z))
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHRP.Position)

        if canShootAtTarget(targetHRP) then
            shootStatusLabel.Text = "Shoot Status: Can Shoot"
            shootStatusLabel.TextColor3 = Color3.new(0, 1, 0)
        else
            shootStatusLabel.Text = "Shoot Status: Blocked"
            shootStatusLabel.TextColor3 = Color3.new(1, 0, 0)
        end
    else
        if indicatorGui then
            indicatorGui:Destroy()
            indicatorGui = nil
        end
        currentTarget = nil
        shootStatusLabel.Text = "Shoot Status: None"
        shootStatusLabel.TextColor3 = Color3.new(1, 0, 0)
    end
end)

-- Create Shoot Status UI
createShootStatusUI()

-- Add toggle to Kavo UI
local Tab = Window:NewTab("Aimbot")
local Section = Tab:NewSection("Main")
Section:NewToggle("Enable Aimbot", "Toggles the aimbot on/off", function(state)
    aimbotEnabled = state
end)
