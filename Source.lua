local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Farls-Xavier/UiLibraryV2/main/Source.lua"))()
local Window = Library:Window({Title = "Blox frots", ToolTipColor = "Grey"})

local Players = game.Players
local StarterGui = game.StarterGui
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Weapons = {}
local Fruits = {}
local Connections = {
    fruitNoti = nil,
    fruitEsp = nil,
    fruitEsp2 = nil,
    mobHitbox = nil,
    questFarm = nil,
    autoMelee = nil,
    autoDefense = nil,
    autoSword = nil,
    autoGun = nil,
    autoFruit = nil
}

local SelectedWeapon = nil
local SelectedMob = nil

local Mob = nil
local QuestName = nil
local QuestLevel = nil
local QuestMob = nil
local QuestGiverCFrame = nil
local MobCFrame = nil

local ESP_Folder = Instance.new("Folder", workspace)

local FirstSea = false
local SecondSea = false
local ThirdSea = false

if game.PlaceId == 2753915549 then
    FirstSea = true
    print("In First sea")
elseif game.PlaceId == 4442272183 then
    SecondSea = true
    print("In Second sea")
elseif game.PlaceId == 7449423635 then
    ThirdSea = true
    print("In Third sea")
end

local function Teleport(cf, callback)
    callback = callback or function() end
    local RootPart = Players.LocalPlayer.Character.Humanoid.RootPart

    local distance = (cf.Position - RootPart.Position).Magnitude
    local speed
    if distance < 250 then
        speed = 600
    elseif distance < 500 then
        speed = 400
    elseif distance < 1000 then
        speed = 350
    elseif distance >= 1000 then
        speed = 200
    end

    local Tween = TweenService:Create(RootPart, TweenInfo.new(distance/speed), {CFrame = cf})
    Tween.Completed:Connect(function()
        callback()
    end)
    Tween:Play()
end

local function CheckLevel()
    local Level = Players.LocalPlayer.Data.Level.Value
    
    if Level == 1 or Level <= 9 or SelectedMob == "Bandit [Level. 5]" then -- Bandit
        Mob = "Bandit [Level. 5]"
        QuestName = "BanditQuest1"
        QuestLevel = 1
        QuestMob = "Bandit"
        QuestGiverCFrame = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
        MobCFrame = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
    elseif Level == 10 or Level <= 14 or SelectedMob == "Monkey [Level. 14]" then -- Monkey
        Mob = "Monkey [Level. 14]"
        QuestName = "JungleQuest"
        QuestLevel = 1
        QuestMob = "Monkey"
        QuestGiverCFrame = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
        MobCFrame = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
    elseif Level == 15 or Level <= 29 or SelectedMob == "Gorilla [Level. 20]" then -- Gorilla
        Mob = "Gorilla [Level. 20]"
        QuestName = "JungleQuest"
        QuestLevel = 2
        QuestMob = "Gorilla"
        QuestGiverCFrame = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
        MobCFrame = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
    elseif Level == 30 or Level <= 39 or SelectedMob == "Pirate [Level. 35]" then -- Pirate
        Mob = "Pirate [Level. 35]"
        QuestName = "BuggyQuest1"
        QuestLevel = 1
        QuestMob = "Pirate"
        QuestGiverCFrame = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
        MobCFrame = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
    elseif Level == 40 or Level <= 59 or SelectedMob == "Brute [Level. 45]" then -- Brute
        Mob = "Brute [Level. 45]"
        QuestName = "BuggyQuest1"
        QuestLevel = 2
        QuestMob = "Brute"
        QuestGiverCFrame = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
        MobCFrame = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
    elseif Level == 60 or Level <= 74 or SelectedMob == "Desert Bandit [Level. 60]" then -- Desert Bandit
        Mob = "Desert Bandit [Level. 60]"
        QuestName = "DesertQuest"
        QuestLevel = 1
        QuestMob = "Desert Bandit"
        QuestGiverCFrame = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
        MobCFrame = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
    elseif Level == 75 or Level <= 89 or SelectedMob == "Desert Officer [Level. 70]" then -- Desert Officer
        Mob = "Desert Officer [Level. 70]"
        QuestName = "DesertQuest"
        QuestLevel = 2
        QuestMob = "Desert Officer"
        QuestGiverCFrame = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
        MobCFrame = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
    elseif Level == 90 or Level <= 99 or SelectedMob == "Snow Bandit [Level. 90]" then -- Snow Bandit
        Mob = "Snow Bandit [Level. 90]"
        QuestName = "SnowQuest"
        QuestLevel = 1
        QuestMob = "Snow Bandit"
        QuestGiverCFrame = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
        MobCFrame = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
    elseif Level == 100 or Level <= 119 or SelectedMob == "Snowman [Level. 100]" then -- Snowman
        Mob = "Snowman [Level. 100]"
        QuestName = "SnowQuest"
        QuestLevel = 2
        QuestMob = "Snowman"
        QuestGiverCFrame = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
        MobCFrame = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
    elseif Level == 120 or Level <= 149 or SelectedMob == "Chief Petty Officer [Level. 120]" then -- Chief Petty Officer
        Mob = "Chief Petty Officer [Level. 120]"
        QuestName = "MarineQuest2"
        QuestLevel = 1
        QuestMob = "Chief Petty Officer"
        QuestGiverCFrame = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
        MobCFrame = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
    elseif Level == 150 or Level <= 174 or SelectedMob == "Sky Bandit [Level. 150]" then -- Sky Bandit
        Mob = "Sky Bandit [Level. 150]"
        QuestName = "SkyQuest"
        QuestLevel = 1
        QuestMob = "Sky Bandit"
        QuestGiverCFrame = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
        MobCFrame = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
    elseif Level == 175 or Level <= 249 or SelectedMob == "Dark Master [Level. 175]" then -- Dark Master
        Mob = "Dark Master [Level. 175]"
        QuestName = "SkyQuest"
        QuestLevel = 2
        QuestMob = "Dark Master"
        QuestGiverCFrame = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
        MobCFrame = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
    elseif Level == 250 or Level <= 274 or SelectedMob == "Toga Warrior [Level. 250]" then -- Toga Warrior
        Mob = "Toga Warrior [Level. 250]"
        QuestName = "ColosseumQuest"
        QuestLevel = 1
        QuestMob = "Toga Warrior"
        QuestGiverCFrame = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
        MobCFrame = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
    elseif Level == 275 or Level <= 299 or SelectedMob == "Gladiator [Level. 275]" then -- Gladiator
        Mob = "Gladiator [Level. 275]"
        QuestName = "ColosseumQuest"
        QuestLevel = 2
        QuestMob = "Gladiator"
        QuestGiverCFrame = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
        MobCFrame = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
    elseif Level == 300 or Level <= 329 or SelectedMob == "Military Soldier [Level. 300]" then -- Military Soldier
        Mob = "Military Soldier [Level. 300]"
        QuestName = "MagmaQuest"
        QuestLevel = 1
        QuestMob = "Military Soldier"
        QuestGiverCFrame = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
        MobCFrame = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
    elseif Level == 325 or Level <= 374 or SelectedMob == "Military Spy [Level. 325]" then -- Military Spy
        Mob = "Military Spy [Level. 325]"
        QuestName = "MagmaQuest"
        QuestLevel = 2
        QuestMob = "Military Spy"
        QuestGiverCFrame = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
        MobCFrame = CFrame.new(-5984.0532226563, 82.14656829834, 8753.326171875)
    elseif Level == 375 or Level <= 399 or SelectedMob == "Fishman Warrior [Level. 375]" then -- Fishman Warrior 
        Mob = "Fishman Warrior [Level. 375]"
        QuestName = "FishmanQuest"
        QuestLevel = 1
        QuestMob = "Fishman Warrior"
        QuestGiverCFrame = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
        MobCFrame = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
        if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    elseif Level == 400 or Level <= 449 or SelectedMob == "Fishman Commando [Level. 400]" then -- Fishman Commando
        Mob = "Fishman Commando [Level. 400]"
        QuestName = "FishmanQuest"
        QuestLevel = 2
        QuestMob = "Fishman Commando"
        QuestGiverCFrame = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
        MobCFrame = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
        if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    elseif Level == 450 or Level <= 474 or SelectedMob == "God's Guard [Level. 450]" then -- God's Guard
        Mob = "God's Guard [Level. 450]"
        QuestName = "SkyExp1Quest"
        QuestLevel = 1
        QuestMob = "God's Guard"
        QuestGiverCFrame = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
        MobCFrame = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
        if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
        end
    elseif Level == 475 or Level <= 524 or SelectedMob == "Shanda [Level. 475]" then -- Shanda
        Mob = "Shanda [Level. 475]"
        QuestName = "SkyExp1Quest"
        QuestLevel = 2
        QuestMob = "Shanda"
        QuestGiverCFrame = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
        MobCFrame = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
        if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
        end
    elseif Level == 525 or Level <= 549 or SelectedMob == "Royal Squad [Level. 525]" then -- Royal Squad
        Mob = "Royal Squad [Level. 525]"
        QuestName = "SkyExp2Quest"
        QuestLevel = 1
        QuestMob = "Royal Squad"
        QuestGiverCFrame = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
        MobCFrame = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
    elseif Level == 550 or Level <= 624 or SelectedMob == "Royal Soldier [Level. 550]" then -- Royal Soldier
        Mob = "Royal Soldier [Level. 550]"
        QuestName = "SkyExp2Quest"
        QuestLevel = 2
        QuestMob = "Royal Soldier"
        QuestGiverCFrame = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
        MobCFrame = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
    elseif Level == 625 or Level <= 649 or SelectedMob == "Galley Pirate [Level. 625]" then -- Galley Pirate
        Mob = "Galley Pirate [Level. 625]"
        QuestName = "FountainQuest"
        QuestLevel = 1
        QuestMob = "Galley Pirate"
        QuestGiverCFrame = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
        MobCFrame = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
    elseif Level >= 650 or SelectedMob == "Galley Captain [Level. 650]" then -- Galley Captain
        Mob = "Galley Captain [Level. 650]"
        QuestName = "FountainQuest"
        QuestLevel = 2
        QuestMob = "Galley Captain"
        QuestGiverCFrame = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
        MobCFrame = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
    end
end

local function Roblox_Notification(message, buttons, callback)
	buttons = buttons or {"Yes", "No"}
	callback = callback or function(answer)
		warn("Callback is set to nil")
	end

	local BindableFunction = Instance.new("BindableFunction")
	BindableFunction.OnInvoke = function(answer)
		callback(answer)
		task.delay(.5, function()
			BindableFunction:Destroy()
		end)
	end

	StarterGui:SetCore("SendNotification", {
		Title = "Notification",
		Text = message,
		Icon = Library:GetRandomImage(),
		Button1 = buttons[1],
		Button2 = buttons[2],
		Callback = BindableFunction
	})
end

local function AddWeapon(v)
    if not Weapons[v] then
        table.insert(Weapons, v)
    end
end

local function SetWeapon(v)
    if Weapons[v] then
        SelectedWeapon = v
    end
end

local function AddESP(v)
    local BillboardGui = Instance.new("BillboardGui", ESP_Folder)
    BillboardGui.Adornee = v
    BillboardGui.AlwaysOnTop = true
    BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
    BillboardGui.Size = UDim2.new(1, 200, 1, 30)
    local TextLabel = Instance.new("TextLabel", BillboardGui)
    TextLabel.Text = v.Name
    TextLabel.Size = UDim2.new(1,0,1,0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.fromRGB(255,0,0)
    TextLabel.Font = Enum.Font.MontserratBold
    TextLabel.TextSize = 16
	TextLabel.FontFace.Weight = Enum.FontWeight.SemiBold
end

local function MobHitbox(v)
    if v then
        Connections.mobHitbox = RunService.RenderStepped:Connect(function()
            if #workspace.Enemies:GetChildren() > 0 then
                for i,v in pairs(workspace.Enemies:GetChildren()) do
                    v:FindFirstChild("HumanoidRootPart").Size = Vector3.new(60,60,60)
                    v:FindFirstChild("HumanoidRootPart").CanCollide = false
                    task.wait()
                end
            end
        end)
    else
        Connections.mobHitbox:Disconnect()
        Connections.mobHitbox = nil
        if #workspace.Enemies:GetChildren() > 0 then
            for i,v in pairs(workspace.Enemies:GetChildren()) do
                v:FindFirstChild("HumanoidRootPart").Size = v:FindFirstChild("HumanoidRootPart").OriginalSize.Value
            end
        end
    end
end

local function QuestFarm(v)
    CheckLevel()
    if v then
        Connections.questFarm = RunService.RenderStepped:Connect(function()
            if Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                CheckLevel()
                Teleport(QuestGiverCFrame, function()
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestLevel)
                end)
            else
                for i,v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == QuestMob and v.Humanoid.Health > 0 then
                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                    end
                    task.wait()
                end
            end
            task.wait()
        end)
    else
        Connections.questFarm:Disconnect()
        Connections.questFarm = nil
        Mob(false)
    end
end

local function FruitNotifications(v)
    if v then
        MobHitbox(true)
        Connections.fruitNoti = workspace.ChildAdded:Connect(function(child)
            local SearchString = child.Name:lower()

            warn(child.ClassName)

            if string.find(SearchString, "fruit") then
                Roblox_Notification(child.Name.." was added to the workspace", {"Okay", "Teleport"}, function(answer)
                    if answer == "Teleport" then
                        Teleport(child.CFrame)
                    end
                end)
            end
        end)
    else
        Connections.fruitNoti:Disconnect()
        Connections.fruitNoti = nil
        MobHitbox(false)
    end
end

local function FruitEsp(v)
    if v then
        for i,v in pairs(workspace:GetChildren()) do
            if string.find(v.Name:lower(), "fruit") then
                AddESP(v)
            end
        end

        Connections.fruitEsp = workspace.ChildAdded:Connect(function(child)
            local SearchString = child.Name:lower()

            if string.find(SearchString, "fruit") then
                AddESP(child)
            end
        end)

        Connections.fruitEsp2 = workspace.ChildRemoved:Connect(function(child)
            for i,v in pairs(ESP_Folder:GetChildren()) do
                if v.Adornee == child then
                    v:Destroy()
                end
            end
        end)
    else
        Connections.fruitEsp:Disconnect()
        Connections.fruitEsp2:Disconnect()
        ESP_Folder:ClearAllChildren()
        Connections.fruitEsp = nil
        Connections.fruitEsp2 = nil
    end
end

local AutoFarmTab = Window:Tab({Text = "Auto farm"})
do -- Auto Farm Tab
    local QuestFarm_Toggle = AutoFarmTab:Toggle({Text = "Quest farm", Callback = function(v)
        QuestFarm(v)
    end})
end

local FruitsTab = Window:Tab({Text = "Fruits"})
do -- Fruits Tab
    local RandomFruit_Button = FruitsTab:Button({Text = "Buy a random fruit", ToolTip = "Rolls a random fruit from the gacha", Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin","Buy")
    end})

    local FruitEsp_Toggle = FruitsTab:Toggle({Text = "Fruit ESP", Callback = function(v)
        FruitEsp(v)
    end})

    local FruitNotifications_Toggle = FruitsTab:Toggle({Text = "Fruit Notifications", Callback = function(v)
        FruitNotifications(v)
    end})
end

local StatsTab = Window:Tab({Text = "Stats"})
do --Stats tab
    local AutoMelee_Toggle = StatsTab:Toggle({Text = "Level Melee", Callback = function(v)
        if v then
            Connections.autoMelee = RunService.RenderStepped:Connect(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1) 
                task.wait(.1)
            end)
        else
            Connections.autoMelee:Disconnect()
            Connections.autoMelee = nil
        end
    end})

    local AutoDefense_Toggle = StatsTab:Toggle({Text = "Level Defense", Callback = function(v)
        if v then
            Connections.autoDefense = RunService.RenderStepped:Connect(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1) 
                task.wait(.1)
            end)
        else
            Connections.autoDefense:Disconnect()
            Connections.autoDefense = nil
        end
    end})

    local AutoGun_Toggle = StatsTab:Toggle({Text = "Level Gun", Callback = function(v)
        if v then
            Connections.autoGun = RunService.RenderStepped:Connect(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1) 
                task.wait(.1)
            end)
        else
            Connections.autoGun:Disconnect()
            Connections.autoGun = nil
        end
    end})

    local AutoFruit_Toggle = StatsTab:Toggle({Text = "Level Gun", Callback = function(v)
        if v then
            Connections.autoFruit = RunService.RenderStepped:Connect(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1) 
                task.wait(.1)
            end)
        else
            Connections.autoFruit:Disconnect()
            Connections.autoFruit = nil
        end
    end})
end

local ShopTab = Window:Tab({Text = "Shop"})
do -- Shop Tab
    ShopTab:Label({Text = "NOTHING YET WOWOWOWOOWOW"})
end

for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        AddWeapon(v)
    end
end
