-- Loading Screen
local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Name = "LoadingScreen"

-- Background
local bg = Instance.new("Frame", screenGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

-- Roblox Logo
local logo = Instance.new("ImageLabel", bg)
logo.Size = UDim2.new(0, 100, 0, 100)
logo.Position = UDim2.new(0.5, -50, 0.4, -50)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://11293764663" -- Roblox Logo

-- Progress Bar Background
local barBG = Instance.new("Frame", bg)
barBG.Size = UDim2.new(0, 300, 0, 10)
barBG.Position = UDim2.new(0.5, -150, 0.6, 0)
barBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBG.BorderSizePixel = 0

-- Progress Bar Fill
local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
barFill.BorderSizePixel = 0

-- Spin Logo + Fill Progress
task.spawn(function()
    local tweenService = game:GetService("TweenService")
    local progress = 0
    while progress < 1 do
        progress += 0.01
        logo.Rotation += 6
        barFill:TweenSize(UDim2.new(progress, 0, 1, 0), "Out", "Quad", 0.05, true)
        task.wait(0.05)
    end
    task.wait(0.3)
    screenGui:Destroy()
end)
