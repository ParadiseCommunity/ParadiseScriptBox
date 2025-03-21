---Fuck skidders
local allowedUserIds = {1342600178, 8082420200, 7507393520} 

local player = game:GetService("Players").LocalPlayer

local function isAuthorized(userId)
    for _, id in ipairs(allowedUserIds) do
        if userId == id then
            return true
        end
    end
    return false
end

if isAuthorized(player.UserId) then
    print("Access granted: Executing script for " .. player.Name)
    
--------------------------------------------------------------------------------

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "Paradise V3.3 | Greenville",
    Icon = 0, 
    LoadingTitle = "Paradise | Greenville",
    LoadingSubtitle = "by 2kemmz",
    Theme = "",
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, 
 
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, 
       FileName = "Big Hub"
    },
 
 })

local HomeTab = Window:CreateTab("Home")
local PlayerTab = Window:CreateTab("Player")
local VehicleTab = Window:CreateTab("Vehicle")
local TransportTab = Window:CreateTab("Transport")
local MenusTab = Window:CreateTab("Menus")
local GriefTab = Window:CreateTab("Grief")
local AutofarmTab = Window:CreateTab("Autofarm")

HomeTab:CreateDivider()
HomeTab:CreateLabel("NOTICE | Paradise is still in development")
HomeTab:CreateLabel("If you spot any problems DM 2kemmz")
HomeTab:CreateLabel("Last Update - March 2025")

---------------------------------------------------------------

local Section = VehicleTab:CreateSection("Drift Section")
local gravityEnabled = false
VehicleTab:CreateToggle({
    Name = "Gravity Toggle",
    CurrentValue = gravityEnabled,
    Callback = function(Value)
        gravityEnabled = Value
        if gravityEnabled then
            game.Workspace.Gravity = 50
        else
            game.Workspace.Gravity = 200
        end
    end
})

VehicleTab:CreateToggle({
    Name = "Disable Weight",
    CurrentValue = false,
    Flag = "ToggleDisableWeight",
    Callback = function(Value)
        DisableWeight = Value
        local player = game.Players.LocalPlayer
        local PlayerCar = workspace.SessionVehicles:FindFirstChild(player.Name .. "-Car")
        local MainBody = PlayerCar:FindFirstChild("Body")
        local weight = MainBody:FindFirstChild("#Weight")
        if DisableWeight then
            weight.CustomPhysicalProperties = PhysicalProperties.new(0, weight.CustomPhysicalProperties.Friction, weight.CustomPhysicalProperties.Elasticity, weight.CustomPhysicalProperties.FrictionWeight, weight.CustomPhysicalProperties.ElasticityWeight)
        else
            weight.CustomPhysicalProperties = PhysicalProperties.new(1, weight.CustomPhysicalProperties.Friction, weight.CustomPhysicalProperties.Elasticity, weight.CustomPhysicalProperties.FrictionWeight, weight.CustomPhysicalProperties.ElasticityWeight)
        end
    end
})

VehicleTab:CreateToggle({
    Name = "Less Grip",
    CurrentValue = false,
    Flag = "ToggleLessGrip",
    Callback = function(Value)
        LessGrip = Value
        local player = game.Players.LocalPlayer
        local PlayerCar = workspace.SessionVehicles:FindFirstChild(player.Name .. "-Car")
        local Wheels = PlayerCar:FindFirstChild("Wheels")
        for _, wheel in ipairs(Wheels:GetChildren()) do
            local props = wheel.CustomPhysicalProperties
            wheel.CustomPhysicalProperties = PhysicalProperties.new(
                props.Density,
                Value and 0.1 or 2,
                props.Elasticity,
                100,
                props.ElasticityWeight
            )
        end
    end
})

---------------------------------------------------------------

local Section = VehicleTab:CreateSection("Car Extras")
local rs = game:GetService("ReplicatedStorage")
VehicleTab:CreateButton({
    Name = "Refuel",
    Callback = function()
        rs.Remote.Refuel:FireServer(1, os.time())
    end
})

VehicleTab:CreateToggle({
    Name = "More Grip",
    CurrentValue = false,
    Flag = "ToggleMoreGrip",
    Callback = function(Value)
        MoreGrip = Value
        local player = game.Players.LocalPlayer
        local PlayerCar = workspace.SessionVehicles:FindFirstChild(player.Name .. "-Car")
        local Wheels = PlayerCar:FindFirstChild("Wheels")
        for _, wheel in ipairs(Wheels:GetChildren()) do
            local props = wheel.CustomPhysicalProperties
            wheel.CustomPhysicalProperties = PhysicalProperties.new(
                props.Density,
                Value and 2 or 0.5,
                props.Elasticity,
                100,
                props.ElasticityWeight
            )
        end
    end
})

local tiltEnabled = false
local function tiltCar()
    local player = game.Players.LocalPlayer
    if not player then return end
    
    local character = player.Character or player.CharacterAdded:Wait()
    if not character then return end
    
    local vehicle = character.Parent
    if not vehicle or not vehicle:IsA("Model") then return end
    
    local rootPart = vehicle:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    if tiltEnabled then
        -- Apply BodyGyro for tilting
        local gyro = Instance.new("BodyGyro")
        gyro.Parent = rootPart
        gyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        gyro.CFrame = rootPart.CFrame * CFrame.Angles(0, 0, math.rad(75)) -- Tilt angle

        game.Workspace.Gravity = 30

        task.delay(5, function()
            if gyro then
                gyro:Destroy()
            end
            game.Workspace.Gravity = 196.2
        end)
    end
end

---------------------------------------------------------------

local Section = VehicleTab:CreateSection("Suspension")
VehicleTab:CreateToggle({
    Name = "Show Springs",
    CurrentValue = false,
    Flag = "ShowSpringsToggle",
    Callback = function(v)
        local Character = LocalPlayer.Character
        if Character and typeof(Character) == "Instance" then
            local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
            if Humanoid and typeof(Humanoid) == "Instance" then
                local SeatPart = Humanoid.SeatPart
                if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
                    local Vehicle = GetVehicleFromDescendant(SeatPart)
                    if Vehicle then
                        for _, SpringConstraint in pairs(Vehicle:GetDescendants()) do
                            if SpringConstraint:IsA("SpringConstraint") then
                                SpringConstraint.Visible = v
                            end
                        end
                    end
                end
            end
        end
    end
})

VehicleTab:CreateToggle({
    Name = "Maybach Bounce",
    CurrentValue = gravityEnabled,
    Callback = function(Value)
        gravityEnabled = Value
        
        if gravityEnabled and not isLooping then
            isLooping = true
            task.spawn(function() 
                while gravityEnabled do
                    game.Workspace.Gravity = 320
                    wait(0.28)  
                    game.Workspace.Gravity = 200
                    wait(0.28)
                end
                isLooping = false 
            end)
        else
            game.Workspace.Gravity = 200 
            isLooping = false 
        end
    end
})

local gravityEnabled = false
VehicleTab:CreateToggle({
    Name = "Riding Low Mode",
    CurrentValue = gravityEnabled,
    Callback = function(Value)
        gravityEnabled = Value
        if gravityEnabled then
            game.Workspace.Gravity = 1000
        else
            game.Workspace.Gravity = 200
        end
    end
})

local gravityEnabled = false
VehicleTab:CreateToggle({
    Name = "Street Mode",
    CurrentValue = gravityEnabled,
    Callback = function(Value)
        gravityEnabled = Value
        if gravityEnabled then
            game.Workspace.Gravity = 500
        else
            game.Workspace.Gravity = 200
        end
    end
})

local gravityEnabled = false
VehicleTab:CreateToggle({
    Name = "Offroad Mode",
    CurrentValue = gravityEnabled,
    Callback = function(Value)
        gravityEnabled = Value
        if gravityEnabled then
            game.Workspace.Gravity = 100
        else
            game.Workspace.Gravity = 200
        end
    end
})

---------------------------------------------------------------

local Section = VehicleTab:CreateSection("Model Spawner")

local function GetGroundPosition(startPosition)
    local ray = Ray.new(startPosition, Vector3.new(0, -100, 0))
    local part, position = workspace:FindPartOnRay(ray)
    
    if part then
        return position + Vector3.new(0, 2, 0)
    else
        return startPosition
    end
end

local function SpawnCar(assetId)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local spawnPosition = character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)

    local finalPosition = GetGroundPosition(spawnPosition)

    local success, carModel = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)

    if success and carModel then
        local localCarFolder = game.Workspace:FindFirstChild("ClientSideCars")
        if not localCarFolder then
            localCarFolder = Instance.new("Folder")
            localCarFolder.Name = "ClientSideCars"
            localCarFolder.Parent = game.Workspace
        end

        carModel.Parent = localCarFolder
        carModel:MoveTo(finalPosition)

        task.wait(0.5)

        local primaryPart = carModel.PrimaryPart or carModel:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            primaryPart.Anchored = false
            for _, part in ipairs(carModel:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = false
                    if part.Name == "Roof" then
                        part.CanCollide = false
                    else
                        part.CanCollide = true
                    end
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = primaryPart
                    weld.Part1 = part
                    weld.Parent = primaryPart
                end
            end

            local vehicleSeat = carModel:FindFirstChildWhichIsA("VehicleSeat")
            if vehicleSeat then
                vehicleSeat.Disabled = false
            end
        end
    else
    end
end

local function DespawnCars()
    local localCarFolder = game.Workspace:FindFirstChild("ClientSideCars")
    if localCarFolder then
        localCarFolder:Destroy()
    else
    end
end

VehicleTab:CreateButton({
    Name = "Spawn Koenigsegg Jesko (White)",
    Callback = function()
        SpawnCar(6810376207)
    end
})

VehicleTab:CreateButton({
    Name = "Spawn M3 G80 (Gray)",
    Callback = function()
        SpawnCar(17471437951)
    end
})

VehicleTab:CreateButton({
    Name = "Despawn Cars",
    Callback = function()
        DespawnCars()
    end
})

---------------------------------------------------------------

local Section = PlayerTab:CreateSection("Dashcam")
local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local activeView = nil  -- Stores the active camera view

local function toggleCamera(viewName, positionOffset, fov, toggleState)
    if toggleState then
        -- Activate the camera view
        if activeView == viewName then return end  -- Prevent setting the same view
        activeView = viewName
        camera.CameraType = Enum.CameraType.Scriptable
        camera.FieldOfView = fov or 70

        -- Create a task to keep the camera in place while the view is active
        task.spawn(function()
            while activeView == viewName do
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local hrp = character.HumanoidRootPart
                    camera.CFrame = hrp.CFrame * CFrame.new(positionOffset)
                end
                task.wait()
            end
        end)

        Rayfield:Notify({
            Title = "Camera View Activated",
            Content = viewName .. " activated.",
            Duration = 3
        })
    else
        -- Deactivate the camera view
        if activeView == viewName then
            activeView = nil
            camera.CameraType = Enum.CameraType.Custom
            camera.FieldOfView = 70
            Rayfield:Notify({
                Title = "Camera Disabled",
                Content = "Reset to default view.",
                Duration = 3
            })
        end
    end
end

PlayerTab:CreateToggle({
    Name = "Dashcam View (1)",
    Default = false,
    Callback = function(toggleState)
        toggleCamera("1st View", Vector3.new(1, 1.5, -4), 100, toggleState) 
    end
})

PlayerTab:CreateToggle({
    Name = "Dashcam View (2)",
    Default = false,
    Callback = function(toggleState)
        toggleCamera("2nd View", Vector3.new(1.5, 1.5, -3), 100, toggleState) 
    end
})

PlayerTab:CreateToggle({
    Name = "Dashcam View (3)",
    Default = false,
    Callback = function(toggleState)
        toggleCamera("3rd View", Vector3.new(1, 1.8, -3.5), 100, toggleState) 
    end
})

PlayerTab:CreateToggle({
    Name = "Dashcam View (4)",
    Default = false,
    Callback = function(toggleState)
        toggleCamera("4th View", Vector3.new(0.73, 1.5, -4.5), 100, toggleState) 
    end
})

PlayerTab:CreateToggle({
    Name = "Plate View",
    Default = false,
    Callback = function(toggleState)
        toggleCamera("Plate View", Vector3.new(2, -5, -15), 100, toggleState) 
    end
})

---------------------------------------------------------------

local Section = VehicleTab:CreateSection("Radar")
local detectionEnabled = false

VehicleTab:CreateToggle({
    Name = "Enable Radar Detector",
    CurrentValue = false,
    Callback = function(value)
        detectionEnabled = value
    end
})

local targetRoles = {"Wisconsin State Patrol", "Outagamie County Sherrif's Office", "Fox Valley Metro Police Department"}  
local soundId = "rbxassetid://5020637878" 

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
character:WaitForChild("HumanoidRootPart") 
local sound = Instance.new("Sound", character.HumanoidRootPart)
sound.SoundId = soundId
sound.Looped = true
sound.Volume = 2 

local detectionRange = 850

local function sendNotification(role, distance, username)
    Rayfield:Notify({
        Title = "Radar Detection",
        Content = string.format("User: %s\nRole: %s\nStuds Away: %.2f", username, role, distance),
        Duration = 5,
        Type = "info"
    })
end

local function checkProximity()
    while wait(1) do
        if not detectionEnabled then
            sound.Playing = false
            continue
        end

        local playerPosition = character.PrimaryPart.Position
        local found = false

        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Team and table.find(targetRoles, otherPlayer.Team.Name) then
                local otherCharacter = otherPlayer.Character
                if otherCharacter and otherCharacter:FindFirstChild("HumanoidRootPart") then
                    local distance = (otherCharacter.HumanoidRootPart.Position - playerPosition).Magnitude
                    if distance <= detectionRange then 
                        found = true
                        sendNotification(otherPlayer.Team.Name, distance, otherPlayer.Name)
                        break
                    end
                end
            end
        end

        if found then
            if not sound.IsPlaying then
                sound.Playing = true
            end
        else
            sound:Stop()
        end
    end
end

task.spawn(checkProximity)

---------------------------------------------------------------

local Section = VehicleTab:CreateSection("Speed")
local AccelerationEnabled = false
local DecelerationEnabled = false
local speedhaxforce = 1000  
local brakehaxforce = 1000 

VehicleTab:CreateToggle({
    Name = "Enable Acceleration",
    CurrentValue = false,
    Flag = "ToggleAcceleration",
    Callback = function(Value)
        AccelerationEnabled = Value
    end
})

VehicleTab:CreateToggle({
    Name = "Enable Deceleration",
    CurrentValue = false,
    Flag = "ToggleDeceleration",
    Callback = function(Value)
        DecelerationEnabled = Value
    end
})

VehicleTab:CreateSlider({
    Name = "Acceleration",
    Range = {1, 10000},
    Increment = 1,
    Suffix = "Acceleration",
    CurrentValue = 1000,
    Flag = "SpeedHacksSpeed",
    Callback = function(Value)
        speedhaxforce = Value
    end
})

VehicleTab:CreateSlider({
    Name = "Deceleration",
    Range = {1, 10000},
    Increment = 1,
    Suffix = "Brake Force",
    CurrentValue = 1000,
    Flag = "BrakeHacksForce",
    Callback = function(Value)
        brakehaxforce = Value
    end
})

VehicleTab:CreateButton({
    Name = "Inject Hacks",
    Callback = function()
        local player = game.Players.LocalPlayer
        local userInputService = game:GetService("UserInputService")
        local runService = game:GetService("RunService")
        local vehicle = workspace.SessionVehicles:FindFirstChild(player.Name .. "-Car")

        if vehicle and vehicle.PrimaryPart then
            local primaryPart = vehicle.PrimaryPart
            local attachment = primaryPart:FindFirstChild("ForceAttachment")
            if not attachment then
                attachment = Instance.new("Attachment")
                attachment.Name = "ForceAttachment"
                attachment.Parent = primaryPart
            end

            local force = Instance.new("VectorForce")
            force.Parent = vehicle
            force.RelativeTo = Enum.ActuatorRelativeTo.World
            force.Attachment0 = attachment
            force.ApplyAtCenterOfMass = true
            force.Force = Vector3.new(0, 0, 0)

            local isPressingW = false
            local isPressingS = false

            runService.RenderStepped:Connect(function()
                if vehicle and vehicle.PrimaryPart then
                    local velocity = vehicle.PrimaryPart.Velocity:Dot(vehicle.PrimaryPart.CFrame.LookVector)

                    if isPressingW and AccelerationEnabled then
                        force.Force = vehicle.PrimaryPart.CFrame.LookVector * speedhaxforce
                    elseif isPressingS and DecelerationEnabled then
                        if velocity > 0 then
                            force.Force = vehicle.PrimaryPart.CFrame.LookVector * -brakehaxforce
                        else
                            force.Force = Vector3.new(0, 0, 0)
                        end
                    else
                        force.Force = Vector3.new(0, 0, 0)
                    end
                end
            end)

            local function onInputBegan(input, gameProcessed)
                if gameProcessed then return end
                if input.KeyCode == Enum.KeyCode.W then
                    isPressingW = true
                elseif input.KeyCode == Enum.KeyCode.S then
                    isPressingS = true
                end
            end

            local function onInputEnded(input, gameProcessed)
                if gameProcessed then return end
                if input.KeyCode == Enum.KeyCode.W then
                    isPressingW = false
                elseif input.KeyCode == Enum.KeyCode.S then
                    isPressingS = false
                end
            end

            userInputService.InputBegan:Connect(onInputBegan)
            userInputService.InputEnded:Connect(onInputEnded)
        end
    end
})

---------------------------------------------------------------

local Section = PlayerTab:CreateSection("Nametag")

local function createNameTag(character, nameText)
    local head = character:FindFirstChild("Head")
    if not head then return end

    -- Remove existing nametag if it exists
    local existingTag = head:FindFirstChild("CustomNameTag")
    if existingTag then existingTag:Destroy() end

    -- Only create a new tag if there's text to display
    if nameText ~= "" then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "CustomNameTag"
        billboard.Parent = head
        billboard.Size = UDim2.new(4, 0, 1, 0)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboard
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamSemibold
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 0.5
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.Text = nameText
    end
end

local NameInput = PlayerTab:CreateInput({
    Name = "Change Display Name",
    PlaceholderText = "Enter new name",
    RemoveTextAfterFocusLost = false,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.DisplayName = Value 
                createNameTag(character, Value) 
            end
        end
    end
})

local SpectateSection = PlayerTab:CreateSection("Spectate")
local spectatePlayer = ""

local function findClosestUsername(input)
    input = input:lower()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name:lower():sub(1, #input) == input then
            return player.Name
        end
    end
    return nil
end

PlayerTab:CreateInput({
    Name = "Spectate Player",
    PlaceholderText = "Enter Username",
    Flag = "SpectateInput",
    Callback = function(Value)
        spectatePlayer = findClosestUsername(Value) or Value

        if spectatePlayer == "" then
            game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            return
        end
        
        local targetPlayer = game.Players:FindFirstChild(spectatePlayer)
        if targetPlayer then
            game.Workspace.CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid")
        else
            Rayfield:Notify({
                Title = "Spectate Error",
                Content = "Player not found!",
                Duration = 5,
            })
        end
    end
})

---------------------------------------------------------------

AutofarmTab:CreateDivider()

AutofarmTab:CreateLabel("Autofarms are in development please be patient")

AutofarmTab:CreateDivider()

AutofarmTab:CreateToggle({
    Name = "(In Dev) Driving Autofarm",
    CurrentValue = false,
    Flag = "ToggleAutofarm",
    Callback = function(Value)
        Autofarm = Value
        if not Autofarm then return end

        local player = game.Players.LocalPlayer
        local vehicle = workspace.SessionVehicles:FindFirstChild(player.Name .. "-Car")
        local startPosition = Vector3.new(-1801, -80, -10686.6)
        local endPosition = Vector3.new(-1130, -80, -10743)
        local speed = 112
        vehicle:SetPrimaryPartCFrame(CFrame.new(startPosition) * CFrame.Angles(0, math.rad(90), 0))
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = vehicle.PrimaryPart
        local targetPos = endPosition

        while Autofarm do
            while (vehicle.PrimaryPart.Position - targetPos).Magnitude > 1 and Autofarm do
                local direction = (targetPos - vehicle.PrimaryPart.Position).unit
                bodyVelocity.Velocity = direction * speed
                wait(0.02)
                local finalPosition = Vector3.new(vehicle.PrimaryPart.Position.X, -80, vehicle.PrimaryPart.Position.Z)
                vehicle:SetPrimaryPartCFrame(CFrame.new(finalPosition) * CFrame.Angles(0, math.rad(90), 0))
            end
            if targetPos == startPosition then
                targetPos = endPosition
            else
                targetPos = startPosition
            end
        end
        bodyVelocity:Destroy()
    end
})

---------------------------------------------------------------
local Section = GriefTab:CreateSection("Grief")
GriefTab:CreateLabel("Go next to a car and click any of these buttons!")

GriefTab:CreateButton({
    Name = "Goofy Wheels",
    Callback = function()
        for _, player in ipairs(game.Players:GetPlayers()) do
            print(player.Name)
            local PlayerCar = workspace.SessionVehicles:FindFirstChild(player.Name .. "-Car")
            if PlayerCar then
                local Wheels = PlayerCar:FindFirstChild("Wheels")
                if Wheels then
                    for _, wheel in ipairs(Wheels:GetChildren()) do
                        local spring = wheel:FindFirstChild("Spring")
                        if spring then
                            spring.MinLength = 5
                            spring.MaxLength = 15
                            print(wheel.Name)
                        end
                    end
                end
            end
        end
    end
})

GriefTab:CreateButton({
    Name = "Break Car Seat",
    Callback = function()
        for _, player in ipairs(game.Players:GetPlayers()) do
            print(player.Name)
            local PlayerCar = workspace.SessionVehicles:FindFirstChild(player.Name .. "-Car")
            if PlayerCar then
                local seat = PlayerCar:FindFirstChild("DriveSeat")
                if seat then
                    seat:Destroy()
                end
            end
        end
    end
})

GriefTab:CreateButton({
    Name = "Break Car",
    Callback = function()
        for _, player in ipairs(game.Players:GetPlayers()) do
            print(player.Name)
            local PlayerCar = workspace.SessionVehicles:FindFirstChild(player.Name .. "-Car")
            if PlayerCar then
                local Wheels = PlayerCar:FindFirstChild("Wheels")
                if Wheels then
                    for _, wheel in ipairs(Wheels:GetChildren()) do
                        local spring = wheel:FindFirstChild("Spring")
                        if spring then
                            spring.MinLength = 15
                            spring.MaxLength = 30
                            print(wheel.Name)
                        end
                    end
                end
            end
        end
    end
})

---------------------------------------------------------------

TransportTab:CreateDivider()

TransportTab:CreateButton({
    Name = "Roadmap",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(-1584.9815673828125, -71.16507720947266, -11396.05078125))) 
        end
    end
})
TransportTab:CreateButton({
    Name = "Ron Rivers",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(-3526.211669921875, -100.32514190673828, -1834.55859375))) 
        end
    end
})
TransportTab:CreateButton({
    Name = "Horton",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(-1566.75146484375, -97.36862182617188, 4074.514892578125))) 
        end
    end
})

TransportTab:CreateDivider()

TransportTab:CreateButton({
    Name = "Nextstop (Cenex)",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(376.912353515625, -107.4207992553711, -2253.1884765625))) 
        end
    end
})
TransportTab:CreateButton({
    Name = "Nextstop 2 (Cenex)",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(-2884.218017578125, -104.79378509521484, -1863.9017333984375))) 
        end
    end
})
TransportTab:CreateButton({
    Name = "AG Gasoline (Burgerhous)",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(-23.227296829223633, -73.07791900634766, -10493.2041015625))) 
        end
    end
})
TransportTab:CreateButton({
    Name = "AG Gasoline (Horton)",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(-3867.20068359375, -103.64537811279297, 1448.864013671875))) 
        end
    end
})
TransportTab:CreateButton({
    Name = "Clam (Burgerknight)",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(4343.37109375, -74.03206634521484, -11074.876953125))) 
        end
    end
})
TransportTab:CreateButton({
    Name = "Fuel (Airport)",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            player.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(5186.7763671875, -74.65316009521484, -9020.0126953125))) 
        end
    end
})

---------------------------------------------------------------

MenusTab:CreateDivider()

local Section = MenusTab:CreateSection("Hidden Menus")

MenusTab:CreateButton({
    Name = "Show Drag",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") 
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") 
                if screenGui then
                    local dragMenu = screenGui:FindFirstChild("Drag") 
                    if dragMenu then
                        dragMenu.Visible = true 
                    end
                end
            end
        end
    end
})

MenusTab:CreateButton({
    Name = "Show Renault",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") 
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") 
                if screenGui then
                    local dragMenu = screenGui:FindFirstChild("Renault") 
                    if dragMenu then
                        dragMenu.Visible = true 
                    end
                end
            end
        end
    end
})

MenusTab:CreateButton({
    Name = "Show Renault Info",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") 
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") 
                if screenGui then
                    local dragMenu = screenGui:FindFirstChild("RenaultInfo") 
                    if dragMenu then
                        dragMenu.Visible = true 
                    end
                end
            end
        end
    end
})

MenusTab:CreateButton({
    Name = "Show Welcome Pack",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") 
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") 
                if screenGui then
                    local dragMenu = screenGui:FindFirstChild("WelcomePack") 
                    if dragMenu then
                        dragMenu.Visible = true 
                    end
                end
            end
        end
    end
})

MenusTab:CreateButton({
    Name = "Show Delivery List",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") 
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") 
                if screenGui then
                    local dragMenu = screenGui:FindFirstChild("DeliveryList") 
                    if dragMenu then
                        dragMenu.Visible = true 
                    end
                end
            end
        end
    end
})

MenusTab:CreateButton({
    Name = "Show Race",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") 
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") 
                if screenGui then
                    local dragMenu = screenGui:FindFirstChild("Race") 
                    if dragMenu then
                        dragMenu.Visible = true 
                    end
                end
            end
        end
    end
})

MenusTab:CreateButton({
    Name = "Show Wires",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") 
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") 
                if screenGui then
                    local dragMenu = screenGui:FindFirstChild("Wires") 
                    if dragMenu then
                        dragMenu.Visible = true 
                    end
                end
            end
        end
    end
})

MenusTab:CreateButton({
    Name = "Show Load Truck",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") 
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") 
                if screenGui then
                    local dragMenu = screenGui:FindFirstChild("LoadTruck") 
                    if dragMenu then
                        dragMenu.Visible = true 
                    end
                end
            end
        end
    end
})

local Section = MenusTab:CreateSection("Close Menus")

MenusTab:CreateButton({
    Name = "Close All GUIs",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player then
            local playerGui = player:FindFirstChild("PlayerGui") -- Get PlayerGui
            if playerGui then
                local screenGui = playerGui:FindFirstChild("ScreenGui") -- Find ScreenGui
                if screenGui then
                    for _, gui in pairs(screenGui:GetChildren()) do
                        if gui:IsA("Frame") or gui:IsA("TextLabel") or gui:IsA("ImageLabel") or gui:IsA("ScrollingFrame") then
                            gui.Visible = false -- Hide all GUI elements inside ScreenGui
                        end
                    end
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "GUIs Closed",
                        Text = "All opened GUIs are now hidden!",
                        Duration = 2
                    })
                end
            end
        end
    end
})

---------------------------------------------------------------

Rayfield:LoadConfiguration()

--------------------------------------------------------------------------------

else
    print("Access denied: You are not authorized to execute this script.")
    return -- Stops execution
end
