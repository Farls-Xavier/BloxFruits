local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Farls-Xavier/UiLibraryV2/main/Source.lua"))()
local Window = Library:Window({Title = "Blox frots", ToolTipColor = "Grey"})

local Players = game.Players
local StarterGui = game.StarterGui
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")

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
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    elseif Level == 400 or Level <= 449 or SelectedMob == "Fishman Commando [Level. 400]" then -- Fishman Commando
        Mob = "Fishman Commando [Level. 400]"
        QuestName = "FishmanQuest"
        QuestLevel = 2
        QuestMob = "Fishman Commando"
        QuestGiverCFrame = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
        MobCFrame = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
        if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    elseif Level == 450 or Level <= 474 or SelectedMob == "God's Guard [Level. 450]" then -- God's Guard
        Mob = "God's Guard [Level. 450]"
        QuestName = "SkyExp1Quest"
        QuestLevel = 1
        QuestMob = "God's Guard"
        QuestGiverCFrame = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
        MobCFrame = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
        if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
        end
    elseif Level == 475 or Level <= 524 or SelectedMob == "Shanda [Level. 475]" then -- Shanda
        Mob = "Shanda [Level. 475]"
        QuestName = "SkyExp1Quest"
        QuestLevel = 2
        QuestMob = "Shanda"
        QuestGiverCFrame = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
        MobCFrame = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
        if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
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

    if SecondSea then
        if Level == 700 or Level <= 724 or SelectedMob == "Raider [Level. 700]" then -- Raider
            Mob = "Raider [Level. 700]"
            QuestName = "Area1Quest"
            QuestLevel = 1
            QuestMob = "Raider"
            QuestGiverCFrame = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
            MobCFrame = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
        elseif Level == 725 or Level <= 774 or SelectedMob == "Mercenary [Level. 725]" then -- Mercenary
            Mob = "Mercenary [Level. 725]"
            QuestName = "Area1Quest"
            QuestLevel = 2
            QuestMob = "Mercenary"
            QuestGiverCFrame = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
            MobCFrame = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
        elseif Level == 775 or Level <= 799 or SelectedMob == "Swan Pirate [Level. 775]" then -- Swan Pirate
            Mob = "Swan Pirate [Level. 775]"
            QuestName = "Area2Quest"
            QuestLevel = 1
            QuestMob = "Swan Pirate"
            QuestGiverCFrame = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            MobCFrame = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
        elseif Level == 800 or Level <= 874 or SelectedMob == "Factory Staff [Level. 800]" then -- Factory Staff
            Mob = "Factory Staff [Level. 800]"
            QuestName = "Area2Quest"
            QuestLevel = 2
            QuestMob = "Factory Staff"
            QuestGiverCFrame = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            MobCFrame = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
        elseif Level == 875 or Level <= 899 or SelectedMob == "Marine Lieutenant [Level. 875]" then -- Marine Lieutenant
            Mob = "Marine Lieutenant [Level. 875]"
            QuestName = "MarineQuest3"
            QuestLevel = 1
            QuestMob = "Marine Lieutenant"
            QuestGiverCFrame = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
            MobCFrame = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
        elseif Level == 900 or Level <= 949 or SelectedMob == "Marine Captain [Level. 900]" then -- Marine Captain
            Mob = "Marine Captain [Level. 900]"
            QuestName = "MarineQuest3"
            QuestLevel = 2
            QuestMob = "Marine Captain"
            QuestGiverCFrame = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
            MobCFrame = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
        elseif Level == 950 or Level <= 974 or SelectedMob == "Zombie [Level. 950]" then -- Zombie
            Mob = "Zombie [Level. 950]"
            QuestName = "ZombieQuest"
            QuestLevel = 1
            QuestMob = "Zombie"
            QuestGiverCFrame = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
            MobCFrame = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
        elseif Level == 975 or Level <= 999 or SelectedMob == "Vampire [Level. 975]" then -- Vampire
            Mob = "Vampire [Level. 975]"
            QuestName = "ZombieQuest"
            QuestLevel = 2
            QuestMob = "Vampire"
            QuestGiverCFrame = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
            MobCFrame = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
        elseif Level == 1000 or Level <= 1049 or SelectedMob == "Snow Trooper [Level. 1000]" then -- Snow Trooper
            Mob = "Snow Trooper [Level. 1000]"
            QuestName = "SnowMountainQuest"
            QuestLevel = 1
            QuestMob = "Snow Trooper"
            QuestGiverCFrame = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
            MobCFrame = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
        elseif Level == 1050 or Level <= 1099 or SelectedMob == "Winter Warrior [Level. 1050]" then -- Winter Warrior
            Mob = "Winter Warrior [Level. 1050]"
            QuestName = "SnowMountainQuest"
            QuestLevel = 2
            QuestMob = "Winter Warrior"
            QuestGiverCFrame = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
            MobCFrame = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
        elseif Level == 1100 or Level <= 1124 or SelectedMob == "Lab Subordinate [Level. 1100]" then -- Lab Subordinate
            Mob = "Lab Subordinate [Level. 1100]"
            QuestName = "IceSideQuest"
            QuestLevel = 1
            QuestMob = "Lab Subordinate"
            QuestGiverCFrame = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
            MobCFrame = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
        elseif Level == 1125 or Level <= 1174 or SelectedMob == "Horned Warrior [Level. 1125]" then -- Horned Warrior
            Mob = "Horned Warrior [Level. 1125]"
            QuestName = "IceSideQuest"
            QuestLevel = 2
            QuestMob = "Horned Warrior"
            QuestGiverCFrame = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
            MobCFrame = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
        elseif Level == 1175 or Level <= 1199 or SelectedMob == "Magma Ninja [Level. 1175]" then -- Magma Ninja
            Mob = "Magma Ninja [Level. 1175]"
            QuestName = "FireSideQuest"
            QuestLevel = 1
            QuestMob = "Magma Ninja"
            QuestGiverCFrame = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            MobCFrame = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
        elseif Level == 1200 or Level <= 1249 or SelectedMob == "Lava Pirate [Level. 1200]" then -- Lava Pirate
            Mob = "Lava Pirate [Level. 1200]"
            QuestName = "FireSideQuest"
            QuestLevel = 2
            QuestMob = "Lava Pirate"
            QuestGiverCFrame = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            MobCFrame = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
        elseif Level == 1250 or Level <= 1274 or SelectedMob == "Ship Deckhand [Level. 1250]" then -- Ship Deckhand
            Mob = "Ship Deckhand [Level. 1250]"
            QuestName = "ShipQuest1"
            QuestLevel = 1
            QuestMob = "Ship Deckhand"
            QuestGiverCFrame = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            MobCFrame = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
            if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Level == 1275 or Level <= 1299 or SelectedMob == "Ship Engineer [Level. 1275]" then -- Ship Engineer
            Mob = "Ship Engineer [Level. 1275]"
            QuestName = "ShipQuest1"
            QuestLevel = 2
            QuestMob = "Ship Engineer"
            QuestGiverCFrame = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            MobCFrame = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
            if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Level == 1300 or Level <= 1324 or SelectedMob == "Ship Steward [Level. 1300]" then -- Ship Steward
            Mob = "Ship Steward [Level. 1300]"
            QuestName = "ShipQuest2"
            QuestLevel = 1
            QuestMob = "Ship Steward"
            QuestGiverCFrame = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            MobCFrame = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
            if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Level == 1325 or Level <= 1349 or SelectedMob == "Ship Officer [Level. 1325]" then -- Ship Officer
            Mob = "Ship Officer [Level. 1325]"
            QuestName = "ShipQuest2"
            QuestLevel = 2
            QuestMob = "Ship Officer"
            QuestGiverCFrame = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            MobCFrame = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
            if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Level == 1350 or Level <= 1374 or SelectedMob == "Arctic Warrior [Level. 1350]" then -- Arctic Warrior
            Mob = "Arctic Warrior [Level. 1350]"
            QuestName = "FrostQuest"
            QuestLevel = 1
            QuestMob = "Arctic Warrior"
            QuestGiverCFrame = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
            MobCFrame = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
            if Connections.questFarm ~= nil and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
            end
        elseif Level == 1375 or Level <= 1424 or SelectedMob == "Snow Lurker [Level. 1375]" then -- Snow Lurker
            Mob = "Snow Lurker [Level. 1375]"
            QuestName = "FrostQuest"
            QuestLevel = 2
            QuestMob = "Snow Lurker"
            QuestGiverCFrame = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
            MobCFrame = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
        elseif Level == 1425 or Level <= 1449 or SelectedMob == "Sea Soldier [Level. 1425]" then -- Sea Soldier
            Mob = "Sea Soldier [Level. 1425]"
            QuestName = "ForgottenQuest"
            QuestLevel = 1
            QuestMob = "Sea Soldier"
            QuestGiverCFrame = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            MobCFrame = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
        elseif Level >= 1450 or SelectedMob == "Water Fighter [Level. 1450]" then -- Water Fighter
            Mob = "Water Fighter [Level. 1450]"
            QuestName = "ForgottenQuest"
            QuestLevel = 2
            QuestMob = "Water Fighter"
            QuestGiverCFrame = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            MobCFrame = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
        end     
    end

    if ThirdSea then
        if Level == 1500 or Level <= 1524 or SelectedMob == "Pirate Millionaire [Level. 1500]" then -- Pirate Millionaire
            Mob = "Pirate Millionaire [Level. 1500]"
            QuestName = "PiratePortQuest"
            QuestLevel = 1
            QuestMob = "Pirate Millionaire"
            QuestGiverCFrame = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
            MobCFrame = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
        elseif Level == 1525 or Level <= 1574 or SelectedMob == "Pistol Billionaire [Level. 1525]" then -- Pistol Billoonaire
            Mob = "Pistol Billionaire [Level. 1525]"
            QuestName = "PiratePortQuest"
            QuestLevel = 2
            QuestMob = "Pistol Billionaire"
            QuestGiverCFrame = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
            MobCFrame = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
        elseif Level == 1575 or Level <= 1599 or SelectedMob == "Dragon Crew Warrior [Level. 1575]" then -- Dragon Crew Warrior
            Mob = "Dragon Crew Warrior [Level. 1575]"
            QuestName = "AmazonQuest"
            QuestLevel = 1
            QuestMob = "Dragon Crew Warrior"
            QuestGiverCFrame = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
            MobCFrame = CFrame.new(6301.9975585938, 104.77153015137, -1082.6075439453)
        elseif Level == 1600 or Level <= 1624 or SelectedMob == "Dragon Crew Archer [Level. 1600]" then -- Dragon Crew Archer
            Mob = "Dragon Crew Archer [Level. 1600]"
            QuestName = "AmazonQuest"
            QuestLevel = 2
            QuestMob = "Dragon Crew Archer"
            QuestGiverCFrame = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
            MobCFrame = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)
        elseif Level == 1625 or Level <= 1649 or SelectedMob == "Female Islander [Level. 1625]" then -- Female Islander
            Mob = "Female Islander [Level. 1625]"
            QuestName = "AmazonQuest2"
            QuestLevel = 1
            QuestMob = "Female Islander"
            QuestGiverCFrame = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            MobCFrame = CFrame.new(5792.5166015625, 848.14392089844, 1084.1818847656)
        elseif Level == 1650 or Level <= 1699 or SelectedMob == "Giant Islander [Level. 1650]" then -- Giant Islander
            Mob = "Giant Islander [Level. 1650]"
            QuestName = "AmazonQuest2"
            QuestLevel = 2
            QuestMob = "Giant Islander"
            QuestGiverCFrame = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            MobCFrame = CFrame.new(5009.5068359375, 664.11071777344, -40.960144042969)
        elseif Level == 1700 or Level <= 1724 or SelectedMob == "Marine Commodore [Level. 1700]" then -- Marine Commodore
            Mob = "Marine Commodore [Level. 1700]"
            QuestName = "MarineTreeIsland"
            QuestLevel = 1
            QuestMob = "Marine Commodore"
            QuestGiverCFrame = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            MobCFrame = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
        elseif Level == 1725 or Level <= 1774 or SelectedMob == "Marine Rear Admiral [Level. 1725]" then -- Marine Rear Admiral
            Mob = "Marine Rear Admiral [Level. 1725]"
            QuestName = "MarineTreeIsland"
            QuestLevel = 2
            QuestMob = "Marine Rear Admiral"
            QuestGiverCFrame = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            MobCFrame = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
        elseif Level == 1775 or Level <= 1799 or SelectedMob == "Fishman Raider [Level. 1775]" then -- Fishman Raide
            Mob = "Fishman Raider [Level. 1775]"
            QuestName = "DeepForestIsland3"
            QuestLevel = 1
            QuestMob = "Fishman Raider"
            QuestGiverCFrame = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
            MobCFrame = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
        elseif Level == 1800 or Level <= 1824 or SelectedMob == "Fishman Captain [Level. 1800]" then -- Fishman Captain
            Mob = "Fishman Captain [Level. 1800]"
            QuestName = "DeepForestIsland3"
            QuestLevel = 2
            QuestMob = "Fishman Captain"
            QuestGiverCFrame = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
            MobCFrame = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
        elseif Level == 1825 or Level <= 1849 or SelectedMob == "Forest Pirate [Level. 1825]" then -- Forest Pirate
            Mob = "Forest Pirate [Level. 1825]"
            QuestName = "DeepForestIsland"
            QuestLevel = 1
            QuestMob = "Forest Pirate"
            QuestGiverCFrame = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
            MobCFrame = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
        elseif Level == 1850 or Level <= 1899 or SelectedMob == "Mythological Pirate [Level. 1850]" then -- Mythological Pirate
            Mob = "Mythological Pirate [Level. 1850]"
            QuestName = "DeepForestIsland"
            QuestLevel = 2
            QuestMob = "Mythological Pirate"
            QuestGiverCFrame = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
            MobCFrame = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
        elseif Level == 1900 or Level <= 1924 or SelectedMob == "Jungle Pirate [Level. 1900]" then -- Jungle Pirate
            Mob = "Jungle Pirate [Level. 1900]"
            QuestName = "DeepForestIsland2"
            QuestLevel = 1
            QuestMob = "Jungle Pirate"
            QuestGiverCFrame = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            MobCFrame = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
        elseif Level == 1925 or Level <= 1974 or SelectedMob == "Musketeer Pirate [Level. 1925]" then -- Musketeer Pirate
            Mob = "Musketeer Pirate [Level. 1925]"
            QuestName = "DeepForestIsland2"
            QuestLevel = 2
            QuestMob = "Musketeer Pirate"
            QuestGiverCFrame = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            MobCFrame = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
        elseif Level == 1975 or Level <= 1999 or SelectedMob == "Reborn Skeleton [Level. 1975]" then
            Mob = "Reborn Skeleton [Level. 1975]"
            QuestName = "HauntedQuest1"
            QuestLevel = 1
            QuestMob = "Reborn Skeleton"
            QuestGiverCFrame = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
            MobCFrame = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -1.3950732e-05, -0.208259016, -1.08073925e-06, 1, -7.20630269e-05, 0.208259016, 7.07080399e-05, 0.978073597)
        elseif Level == 2000 or Level <= 2024 or SelectedMob == "Living Zombie [Level. 2000]" then
            Mob = "Living Zombie [Level. 2000]"
            QuestName = "HauntedQuest1"
            QuestLevel = 2
            QuestMob = "Living Zombie"
            QuestGiverCFrame = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
            MobCFrame = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-08, 0.0324240364, -2.58006327e-08, 1, -6.06848474e-08, -0.0324240364, 5.98163865e-08, 0.999474227)
        elseif Level == 2025 or Level <= 2049 or SelectedMob == "Demonic Soul [Level. 2025]" then
            Mob = "Demonic Soul [Level. 2025]"
            QuestName = "HauntedQuest2"
            QuestLevel = 1
            QuestMob = "Demonic Soul"
            QuestGiverCFrame = CFrame.new(-9515.39551, 172.266037, 6078.89746, 0.0121199936, -9.78649624e-08, 0.999926567, 2.30358754e-08, 1, 9.75929382e-08, -0.999926567, 2.18513581e-08, 0.0121199936)
            MobCFrame = CFrame.new(-9709.30762, 204.695892, 6044.04688, -0.845798075, -3.4587876e-07, -0.533503294, -4.46235369e-08, 1, -5.77571257e-07, 0.533503294, -4.64701827e-07, -0.845798075)
        elseif Level == 2050 or Level <= 2074 or SelectedMob == "Posessed Mummy [Level. 2050]" then
            Mob = "Posessed Mummy [Level. 2050]"
            QuestName = "HauntedQuest2"
            QuestLevel = 2
            QuestMob = "Posessed Mummy"
            QuestGiverCFrame = CFrame.new(-9515.39551, 172.266037, 6078.89746, 0.0121199936, -9.78649624e-08, 0.999926567, 2.30358754e-08, 1, 9.75929382e-08, -0.999926567, 2.18513581e-08, 0.0121199936)
            MobCFrame = CFrame.new(-9554.11035, 65.6141663, 6041.73584, -0.877069294, 5.33355795e-08, -0.480364174, 2.06420765e-08, 1, 7.33423562e-08, 0.480364174, 5.44105987e-08, -0.877069294)
        elseif Level == 2075 or Level <= 2099 or SelectedMob == "Peanut Scout [Level. 2075]" then
            Mob = "Peanut Scout [Level. 2075]"
            QuestName ="NutsIslandQuest"
            QuestLevel = 1
            QuestMob = "Peanut Scout"
            POSQ = CFrame.new(-2102.74268, 38.1297836, -10192.501, 0.75739336, -4.93203451e-08, 0.65295893, 2.07778754e-08, 1, 5.14325187e-08, -0.65295893, -2.53875481e-08, 0.75739336)
            MobCFrame = CFrame.new(-1983.2562255859375, 38.12957000732422, -10588.0263671875)
        elseif Level == 2100 or Level <= 2124 or SelectedMob == "Peanut President [Level. 2100]" then
            Mob = "Peanut President [Level. 2100]"
            QuestName ="NutsIslandQuest"
            QuestLevel = 2
            QuestMob = "Peanut President"
            POSQ = CFrame.new(-2102.74268, 38.1297836, -10192.501, 0.75739336, -4.93203451e-08, 0.65295893, 2.07778754e-08, 1, 5.14325187e-08, -0.65295893, -2.53875481e-08, 0.75739336)
            MobCFrame = CFrame.new(-1983.2562255859375, 38.12957000732422, -10588.0263671875)
        elseif Level == 2125 or Level <= 2149 or SelectedMob == "Ice Cream Chef [Level. 2125]" then
            Mob = "Ice Cream Chef [Level. 2125]"
            QuestName ="IceCreamIslandQuest"
            QuestLevel = 1
            QuestMob = "Ice Cream Chef"
            POSQ = CFrame.new(-819.84533691406, 65.845329284668, -10965.487304688)
            MobCFrame = CFrame.new(-855.2096557617188, 65.8453598022461, -10910.7177734375)
        elseif Level == 2150 or Level <= 2199 or SelectedMob == "Ice Cream Commander [Level. 2150]" then
            Mob = "Ice Cream Commander [Level. 2150]"
            QuestName ="IceCreamIslandQuest"
            QuestLevel = 2
            QuestMob = "Ice Cream Commander"
            POSQ = CFrame.new(-819.84533691406, 65.845329284668, -10965.487304688)
            MobCFrame = CFrame.new(-855.2096557617188, 65.8453598022461, -10910.7177734375)
        elseif Level == 2200 or Level <= 2224 or SelectedMob == "Cookie Crafter [Level. 2200]" then
            Mob = "Cookie Crafter [Level. 2200]"
            QuestName = "CakeQuest1"
            QuestLevel = 1
            QuestMob = "Cookie Crafter"
            QuestGiverCFrame = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
            MobCFrame = CFrame.new(-2321.71216, 36.699482, -12216.7871, -0.780074954, 0, 0.625686109, 0, 1, 0, -0.625686109, 0, -0.780074954)
        elseif Level == 2225 or Level <= 2249 or SelectedMob == "Cake Guard [Level. 2225]" then
            Mob = "Cake Guard [Level. 2225]"
            QuestName = "CakeQuest1"
            QuestLevel = 2
            QuestMob = "Cake Guard"
            QuestGiverCFrame = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
            MobCFrame = CFrame.new(-1418.11011, 36.6718941, -12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, -0.997700036, 0, 0.0677844882)
        elseif Level == 2250 or Level <= 2274 or SelectedMob == "Baking Staff [Level. 2250]" then
            Mob = "Baking Staff [Level. 2250]"
            QuestName = "CakeQuest2"
            QuestLevel = 1
            QuestMob = "Baking Staff"
            QuestGiverCFrame = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            MobCFrame = CFrame.new(-1980.43848, 36.6716766, -12983.8418, -0.254443765, 0, -0.967087567, 0, 1, 0, 0.967087567, 0, -0.254443765)
        elseif Level >= 2275 or SelectedMob == "Head Baker [Level. 2275]" then
            Mob = "Head Baker [Level. 2275]"
            QuestName = "CakeQuest2"
            QuestLevel = 2
            QuestMob = "Head Baker"
            QuestGiverCFrame = CFrame.new(-2307.778076171875, 105.85140228271484, -12931.0146484375)
            MobCFrame = CFrame.new(-2307.778076171875, 105.85140228271484, -12931.0146484375)
        end
    end
end

local function Roblox_Notification(message, buttons, duration, callback)
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
        Duration = duration or 5,
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
    local RootPart = Players.LocalPlayer.Character.Humanoid.RootPart
    CheckLevel()
    if v then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
        Connections.questFarm = RunService.RenderStepped:Connect(function()
            if Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                CheckLevel()
                Teleport(QuestGiverCFrame, function()
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestLevel)
                    Teleport(MobCFrame)
                end)
            else
                for i,v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == QuestMob and v.Humanoid.Health > 0 then
                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                        v.HumanoidRootPart.Anchored = true
                    end
                    task.wait()
                end
            end
            task.wait()
        end)
    else
        Connections.questFarm:Disconnect()
        Connections.questFarm = nil
    end
end

local function ChestFarm(v)
    
end

local function FruitNotifications(v)
    if v then
        Connections.fruitNoti = workspace.ChildAdded:Connect(function(child)
            local SearchString = child.Name:lower()

            warn(child.ClassName)

            if string.find(SearchString, "fruit") then
                Roblox_Notification(child.Name.." was added to the workspace", {"Okay", "Teleport"}, 10, function(answer)
                    if answer == "Teleport" then
                        Teleport(child.CFrame)
                    end
                end)
            end
        end)
    else
        Connections.fruitNoti:Disconnect()
        Connections.fruitNoti = nil
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
        MobHitbox(v)
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

    local AutoFruit_Toggle = StatsTab:Toggle({Text = "Level Fruit", Callback = function(v)
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

local TeleportsTab = Window:Tab({Text = "Teleports"})
do

end

for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        AddWeapon(v)
    end
end
