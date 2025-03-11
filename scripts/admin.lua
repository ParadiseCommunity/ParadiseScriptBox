-- From nexus, bet ya are
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "Fly Script",
    LoadingTitle = "Rayfield UI",
    LoadingSubtitle = "by YourName",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

-- Create Tab
local MainTab = Window:CreateTab("Admin") -- Using an icon ID

-- Fly Variables
local flying = false
local speed = 50
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local flyVelocity, flyGyro

-- Function to Start Flying
local function startFly()
    if flying then return end
    flying = true
    
    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.Velocity = Vector3.new(0, speed, 0)
    flyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyVelocity.Parent = hrp
    
    flyGyro = Instance.new("BodyGyro")
    flyGyro.CFrame = hrp.CFrame
    flyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyGyro.Parent = hrp
    
    -- Movement Control
    game:GetService("RunService").RenderStepped:Connect(function()
        if flying then
            flyVelocity.Velocity = (hrp.CFrame.LookVector * speed) + Vector3.new(0, speed, 0)
            flyGyro.CFrame = hrp.CFrame
        end
    end)
end

-- Function to Stop Flying
local function stopFly()
    flying = false
    if flyVelocity then flyVelocity:Destroy() end
    if flyGyro then flyGyro:Destroy() end
end

local AdminPanelSection = MainTab:CreateSection("Admin Panel")

-- Add Toggle Button
MainTab:CreateToggle({
    Name = "Fly Mode",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(state)
        if state then
            startFly()
        else
            stopFly()
        end
    end
})

Rayfield:LoadConfiguration()
