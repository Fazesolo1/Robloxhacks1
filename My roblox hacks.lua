-- Main function to display credits and info
function info(txt)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Credits = Instance.new("TextLabel")
    pcall(function() game.CoreGui.Revit:Destroy() end)
    task.wait(.1)
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Name = 'Revit'
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    
    spawn(function()
        Credits.Parent = ScreenGui
        Credits.Font = Enum.Font.Arcade
        Credits.TextColor3 = Color3.new(1,1,1)
        Credits.Position = UDim2.new(0,0,0,0)
        Credits.TextSize = 35
        Credits.Size = UDim2.new(1,0,.1,0)
        Credits.Text = ''
        Credits.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Credits.BorderColor3 = Color3.fromRGB(255, 0, 0)
    end)
    
    function tw(var,s)
        local a = ""
        local s_l = #s
        for i = 1, s_l do
            local c = string.sub(s, i, i)
            a = a .. c
            var.Text = a
            if c == "." then
                wait(.6)
            elseif c == ";" then
                wait(.3)
            elseif c == "," then
                wait(.3)
            elseif c == "!" then
                wait(.3)
            end
            wait(.03)
        end
    end
    
    tw(Credits,txt)
    task.wait(2)
    ScreenGui:Destroy()
end

-- Display the info with your text
spawn(function()
    info('sub to my YT darkc0er')
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Create the ScreenGui for the main functionality
local MainScreenGui = Instance.new("ScreenGui")
MainScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Create the frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.15, 0, 0.2, 0)
Frame.Position = UDim2.new(0.425, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = MainScreenGui

-- Create the close button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.1, 0, 0.1, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Font = Enum.Font.Arcade
CloseButton.Text = "X"
CloseButton.Parent = Frame

CloseButton.MouseButton1Click:Connect(function()
    MainScreenGui:Destroy()
end)

-- Create button to highlight players and show distance
local HighlightButton = Instance.new("TextButton")
HighlightButton.Size = UDim2.new(0.8, 0, 0.2, 0)
HighlightButton.Position = UDim2.new(0.1, 0, 0.1, 0)
HighlightButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HighlightButton.TextColor3 = Color3.fromRGB(255, 0, 0)
HighlightButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
HighlightButton.Font = Enum.Font.Arcade
HighlightButton.Text = "Highlight Players"
HighlightButton.Parent = Frame

-- Create button to enable infinite jumping
local JumpButton = Instance.new("TextButton")
JumpButton.Size = UDim2.new(0.8, 0, 0.2, 0)
JumpButton.Position = UDim2.new(0.1, 0, 0.4, 0)
JumpButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
JumpButton.TextColor3 = Color3.fromRGB(255, 0, 0)
JumpButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
JumpButton.Font = Enum.Font.Arcade
JumpButton.Text = "Infinite Jump"
JumpButton.Parent = Frame

-- Create button to walk through walls
local NoClipButton = Instance.new("TextButton")
NoClipButton.Size = UDim2.new(0.8, 0, 0.2, 0)
NoClipButton.Position = UDim2.new(0.1, 0, 0.7, 0)
NoClipButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
NoClipButton.TextColor3 = Color3.fromRGB(255, 0, 0)
NoClipButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
NoClipButton.Font = Enum.Font.Arcade
NoClipButton.Text = "Walk Through Walls"
NoClipButton.Parent = Frame

-- Variables to store the state of each functionality
local highlightEnabled = false
local infiniteJumpEnabled = false
local noclipEnabled = false
local distanceLabels = {}

-- Create a function to update distance labels
local function updateDistanceLabels()
    if highlightEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                
                -- Create or update the distance label
                if not distanceLabels[player] then
                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Size = UDim2.new(0, 100, 0, 50)
                    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
                    billboardGui.Adornee = player.Character.Head
                    billboardGui.Parent = player.Character

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextColor3 = Color3.new(0, 0, 0)
                    textLabel.TextScaled = true
                    textLabel.TextSize = 14 -- Set text size smaller
                    textLabel.Parent = billboardGui
                    
                    distanceLabels[player] = textLabel
                end
                
                distanceLabels[player].Text = player.Name .. ": " .. math.floor(distance) .. " studs"
                
                -- Add highlight to player
                if not player.Character:FindFirstChild("PlayerHighlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = player.Character
                    highlight.FillColor = Color3.new(1, 0, 0) -- red color
                    highlight.OutlineColor = Color3.new(1, 1, 1) -- white outline
                    highlight.Name = "PlayerHighlight"
                    highlight.Parent = player.Character
                end
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if distanceLabels[player] then
                distanceLabels[player].Parent:Destroy()
                distanceLabels[player] = nil
            end

            local highlight = player.Character:FindFirstChild("PlayerHighlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
end

HighlightButton.MouseButton1Click:Connect(function()
    highlightEnabled = not highlightEnabled
    updateDistanceLabels()
end)

-- Function to enable infinite jump
local function toggleInfiniteJump()
    if infiniteJumpEnabled then
        infiniteJumpEnabled = false
        JumpButton.Text = "Infinite Jump"
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
        end
    else
        infiniteJumpEnabled = true
        JumpButton.Text = "Disable Infinite Jump"
        infiniteJumpConnection = mouse.KeyDown:Connect(function(key)
            if key == " " then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

JumpButton.MouseButton1Click:Connect(toggleInfiniteJump)

-- Function to enable walking through walls
local function toggleWalkThroughWalls()
    local character = game.Players.LocalPlayer.Character
    if noclipEnabled then
        noclipEnabled = false
        NoClipButton.Text = "Walk Through Walls"
