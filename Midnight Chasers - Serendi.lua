local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/only1mf/Serendi-Lua-UI/refs/heads/main/Serendi.lua'))()
local Window = UILib.new("Midnight Chasers", game.Players.LocalPlayer.UserId, "Made by Norma")

local Category1 = Window:Category("Player", "http://www.roblox.com/asset/?id=6031075938") -
local Category2 = Window:Category("Visuals", "http://www.roblox.com/asset/?id=6031763426")
local Category3 = Window:Category("Car", "http://www.roblox.com/asset/?id=6031302953") 
local Category4 = Window:Category("World", "http://www.roblox.com/asset/?id=6035078889") 

local SubButton1 = Category1:Button("Local", "http://www.roblox.com/asset/?id=6034509993") -
local SubButton2 = Category1:Button("Combat", "http://www.roblox.com/asset/?id=6034996695") 
local SubButton3 = Category1:Button("Online", "http://www.roblox.com/asset/?id=6034996720") 

local SubButton7 = Category2:Button("ESP", "http://www.roblox.com/asset/?id=6031763426") 

local SubButton4 = Category3:Button("Mods", "http://www.roblox.com/asset/?id=6031763426") 
local SubButton5 = Category3:Button("Farm", "http://www.roblox.com/asset/?id=6031754562") 
local SubButton6 = Category3:Button("Event", "http://www.roblox.com/asset/?id=6031765426") 

local SubButton8 = Category4:Button("NPC", "http://www.roblox.com/asset/?id=6031763426") 

local Section1 = SubButton1:Section("Movement", "Left")
local Section2 = SubButton2:Section("Combat Tools", "Left")
local Section3 = SubButton3:Section("Online Features", "Left")

local Section7 = SubButton7:Section("ESP", "Left")

local Section4 = SubButton4:Section("Car Mods", "Left")
local Section5 = SubButton5:Section("Cash Farm", "Left")
local Section6 = SubButton6:Section("Sleigh Event", "Left")

local Section8 = SubButton8:Section("Trafic", "Left")

Section1:Slider({
    Title = "Walkspeed",
    Description = "walkspeed",
    Default = 16,
    Min = 0,
    Max = 120
    }, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

Section1:Slider({
    Title = "Jump Power",
    Description = "Jump power",
    Default = 50,
    Min = 0,
    Max = 300
    }, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

Section1:Slider({
    Title = "Gravity",
    Description = "No need to explain",
    Default = 196.2,
    Min = 0,
    Max = 500
    }, function(value)
    game.Workspace.Gravity = value
end)

Section1:Toggle({
    Title = "Noclip",
    Description = "Walk through walls",
    Default = false
    }, function(value)
    getfenv().noclipEnabled = value
    if value then
        spawn(function()
            while getfenv().noclipEnabled do
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
                wait()
            end
        end)
    else
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

Section1:Toggle({
    Title = "Fly",
    Description = "Enable or disable flight",
    Default = false
    }, function(value)
    getfenv().flyEnabled = value
    if value then
        local player = game.Players.LocalPlayer
        local char = player.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if not hum then return end

        local bodyGyro = Instance.new("BodyGyro")
        local bodyVelocity = Instance.new("BodyVelocity")

        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = char.HumanoidRootPart.CFrame
        bodyGyro.Parent = char.HumanoidRootPart

        bodyVelocity.velocity = Vector3.new(0, 0, 0)
        bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = char.HumanoidRootPart

        spawn(function()
            while getfenv().flyEnabled do
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                bodyVelocity.velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                wait()
            end
            bodyGyro:Destroy()
            bodyVelocity:Destroy()
        end)
    end
end)

Section4:Slider({
    Title = "Car Speed",
    Description = "Adjust the car speed",
    Default = 100,
    Min = 0,
    Max = 300
    }, function(value)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            local car = player.Character:FindFirstChild("Humanoid").SeatPart
            if car and car:IsA("VehicleSeat") then
                car.Velocity = car.CFrame.LookVector * value
            else
                warn("No car found or the character is not in a VehicleSeat!")
            end
        end
end)

Section5:Toggle({
    Title = "Auto Cash Farm",
    Description = "Automatically farm cash",
    Default = false
    }, function(value)
        getfenv().cashFarmEnabled = value
        if value then
            spawn(function()
                while getfenv().cashFarmEnabled do
                    for i,v in pairs(workspace:GetChildren()) do
                        if v.ClassName == "Model" and v:FindFirstChild("Container") or v.Name == "PortCraneOversized" then
                            v:Destroy()
                        end
                    end
                    wait(1)
                end
            end)
        end
end)

Section5:Slider({
    Title = "Vehicle Speed",
    Description = "Set the vehicle speed",
    Default = 500,
    Min = 0,
    Max = 1000
    }, function(value)
        getfenv().speed = value
end)

Section5:Toggle({
    Title = "Auto Drive",
    Description = "Automatically drive between points",
    Default = false
    }, function(value)
        getfenv().autoDriveEnabled = value
        if value then
            spawn(function()
                local hum = game.Players.LocalPlayer.Character.Humanoid
                local car = hum.SeatPart.Parent
                car.PrimaryPart = car.Body:FindFirstChild("#Weight")
                while getfenv().autoDriveEnabled do
                    local location1 = Vector3.new(-7594.54, -3.51, 5130.95)
                    local location2 = Vector3.new(-6205.29, -3.50, 8219.85)

                    local function driveTo(location)
                        repeat
                            task.wait()
                            local speed = getfenv().speed or 500
                            car.PrimaryPart.Velocity = car.PrimaryPart.CFrame.LookVector * speed
                            car:PivotTo(CFrame.new(car.PrimaryPart.Position, location))
                        until game.Players.LocalPlayer:DistanceFromCharacter(location) < 50 or not getfenv().autoDriveEnabled
                        car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                    end

                    driveTo(location1)
                    driveTo(location2)
                end
            end)
        end
end)

Section6:Toggle({
    Title = "Auto Farm Sleighs",
    Description = "Automatically farm sleighs",
    Default = false
    }, function(value)
        getfenv().sleighAutoFarm = value
        if value then
            spawn(function()
                while getfenv().sleighAutoFarm do
                    local npcVehicles = workspace:FindFirstChild("NPCVehicles")
                    if npcVehicles then
                        local vehiclesFolder = npcVehicles:FindFirstChild("Vehicles")
                        if vehiclesFolder then
                            local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                            for _, sleigh in pairs(vehiclesFolder:GetChildren()) do
                                if sleigh:IsA("Model") and sleigh.Name == "Sleigh" then
                                    local playerInside = sleigh:FindFirstChild("Player")
                                    if playerInside and playerInside:IsA("Model") then
                                        if not sleigh.PrimaryPart then
                                            sleigh.PrimaryPart = sleigh:FindFirstChild("Part")
                                        end
                                        if sleigh.PrimaryPart then
                                            sleigh:SetPrimaryPartCFrame(CFrame.new(playerPos + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))))
                                            if getfenv().sleighInvisibility then
                                                for _, part in pairs(sleigh:GetDescendants()) do
                                                    if part:IsA("BasePart") then
                                                        part.Transparency = 1
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        sleigh:Destroy()
                                    end
                                end
                            end
                        end
                    end
                    wait(getfenv().sleighAutoFarmDelay or 0.5)
                end
            end)
        end
end)

Section6:Toggle({
    Title = "Make Sleighs Invisible",
    Description = "Toggle sleigh invisibility on or off",
    Default = false
    }, function(value)
        getfenv().sleighInvisibility = value
end)

Section6:Slider({
    Title = "Delay",
    Description = "delay for sleigh auto-farm",
    Default = 0.5,
    Min = 0.1,
    Max = 2,
    DecimalPlaces = 1
    }, function(value)
        getfenv().sleighAutoFarmDelay = value
end)

local espEnabled = false
local espStyle = "2D" 
local espOutlineEnabled = false
local espHealthBarEnabled = false
local espBoxColor = Color3.new(1, 1, 1) 

local function toggleESP(state)
    espEnabled = state
    if espEnabled then
        spawn(function()
            while espEnabled do
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if not player.Character:FindFirstChild("ESPBox") then
                            local espBox
                            if espStyle == "2D" then
                                espBox = Instance.new("BillboardGui")
                                espBox.Size = UDim2.new(4, 0, 6, 0)
                                espBox.Adornee = player.Character.HumanoidRootPart
                                espBox.AlwaysOnTop = true

                                local frame = Instance.new("Frame", espBox)
                                frame.Size = UDim2.new(1, 0, 1, 0)
                                frame.BackgroundTransparency = 0.5
                                frame.BackgroundColor3 = espBoxColor
                                frame.BorderSizePixel = espOutlineEnabled and 1 or 0
                                frame.BorderColor3 = Color3.new(0, 0, 0) 
                            else
                                espBox = Instance.new("BoxHandleAdornment")
                                espBox.Size = Vector3.new(4, 6, 4)
                                espBox.Adornee = player.Character
                                espBox.AlwaysOnTop = true
                                espBox.ZIndex = 10
                                espBox.Color3 = espBoxColor
                                espBox.Transparency = 0.5
                                if espOutlineEnabled then
                                    espBox.Transparency = 0.3
                                end
                            end
                            espBox.Name = "ESPBox"
                            espBox.Parent = player.Character
                        end

                        -- Add Health Bar
                        if espHealthBarEnabled and player.Character:FindFirstChild("Humanoid") then
                            if not player.Character:FindFirstChild("HealthBar") then
                                local healthBar = Instance.new("BillboardGui")
                                healthBar.Name = "HealthBar"
                                healthBar.Adornee = player.Character.HumanoidRootPart
                                healthBar.Size = UDim2.new(4, 0, 1, 0)
                                healthBar.StudsOffset = Vector3.new(0, 5, 0)
                                healthBar.AlwaysOnTop = true

                                local frame = Instance.new("Frame", healthBar)
                                frame.Size = UDim2.new(1, 0, player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth, 0)
                                frame.Position = UDim2.new(0, 0, 1 - (player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth), 0)
                                frame.BackgroundColor3 = Color3.new(0, 1, 0)
                                frame.BorderSizePixel = 0

                                healthBar.Parent = player.Character.HumanoidRootPart
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    else
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character then
                if player.Character:FindFirstChild("ESPBox") then
                    player.Character:FindFirstChild("ESPBox"):Destroy()
                end
                if player.Character:FindFirstChild("HealthBar") then
                    player.Character:FindFirstChild("HealthBar"):Destroy()
                end
            end
        end
    end
end

Section7:Toggle({
    Title = "ESP Box",
    Description = "Enable or disable ESP boxes",
    Default = false
    }, function(state)
        toggleESP(state)
end)

Section7:Dropdown({
    Title = "ESP Style",
    Description = "Select the ESP style",
    Items = {"2D", "3D"},
    Default = "2D",
    Callback = function(selected)
        espStyle = selected
    end
})

Section7:Toggle({
    Title = "Outline",
    Description = "Enable or disable outlines on ESP boxes",
    Default = false
    }, function(state)
        espOutlineEnabled = state
end)

Section7:Toggle({
    Title = "Health Bar",
    Description = "Enable or disable health bars on ESP boxes",
    Default = false
    }, function(state)
        espHealthBarEnabled = state
end)

Section8:Toggle({
    Title = "Remove Trafic",
    Description = "Removes Trafic",
    Default = false
    }, function(state)
        getfenv().removeNumericVehicles = state
        if getfenv().removeNumericVehicles then
            spawn(function()
                while getfenv().removeNumericVehicles do
                    local npcVehicles = workspace:FindFirstChild("NPCVehicles")
                    if npcVehicles then
                        local vehiclesFolder = npcVehicles:FindFirstChild("Vehicles")
                        if vehiclesFolder then
                            for _, vehicle in pairs(vehiclesFolder:GetChildren()) do
                                if vehicle:IsA("Model") and tonumber(vehicle.Name) then
                                    vehicle:Destroy()
                                    print("Removed vehicle with numeric name: " .. vehicle.Name)
                                end
                            end
                        else
                            warn("Vehicles folder not found in NPCVehicles!")
                        end
                    else
                        warn("NPCVehicles folder not found in workspace!")
                    end
                    wait(1)
                end
            end)
        end
end)
