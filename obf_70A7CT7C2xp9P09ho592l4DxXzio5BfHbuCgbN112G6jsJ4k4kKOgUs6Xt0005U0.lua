local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "TWR",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TWR",
    IntroText = "Made by TWR Team.",
    IntroIcon = "rbxassetid://17460077785"
})


OrionLib:MakeNotification({
	Name = "TWR",
	Content = "Succesfully loaded! V1",
	Image = "rbxassetid://4483345998",
	Time = 10
})

-- About Tab

local About = Window:MakeTab({
	Name = "About",
	Icon = "rbxassetid://17460420936",
	PremiumOnly = false
})

-- Section About

local Section = About:AddSection({
	Name = "About"
})

-- Paragaph About

About:AddParagraph("TWR V1","Currently under Development (ALPHA)")
About:AddParagraph("Owners:","Rave, Tw.piece")
About:AddParagraph("Developers:","random")

-- Main Tab

local Lock = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Lock Section

local LockSec = Lock:AddSection({
	Name = "Lock"
})

--Aimlock E

LockSec:AddButton({
	Name = "Aimlock (E)",
	Callback = function()
      		print("button pressed")
  	end    
})

-- Camlock E

LockSec:AddButton({
	Name = "Camlock (X)",
	Callback = function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "TWR";
			Text = "Camlock by rave";
			Duration = 10;
		})
		
		getgenv().Prediction = 0.15038
		getgenv().AimPart = "HumanoidRootPart"
		getgenv().Key = "X"
		getgenv().DisableKey = "P"
		
		getgenv().FOV = true
		getgenv().ShowFOV = false
		getgenv().FOVSize = 55
		
		local Players = game:GetService("Players")
		local RS = game:GetService("RunService")
		local WS = game:GetService("Workspace")
		local GS = game:GetService("GuiService")
		local SG = game:GetService("StarterGui")
		
		local LP = Players.LocalPlayer
		local Mouse = LP:GetMouse()
		local Camera = WS.CurrentCamera
		local GetGuiInset = GS.GetGuiInset
		
		local AimlockState = true
		local Locked
		local Victim
		
		local SelectedKey = getgenv().Key
		local SelectedDisableKey = getgenv().DisableKey
		
		function Notify(tx)
			SG:SetCore("SendNotification", {
				Title = "Cam Lock Enabled",
				Text = tx,
				Duration = 5
			})
		end
		
		if getgenv().Loaded == true then
			Notify("Aimlock is already loaded!")
			return
		end
		
		getgenv().Loaded = true
		
		local fov = Drawing.new("Circle")
		fov.Filled = false
		fov.Transparency = 1
		fov.Thickness = 1
		fov.Color = Color3.fromRGB(255, 255, 0)
		fov.NumSides = 1000
		
		function update()
			if getgenv().FOV == true then
				if fov then
					fov.Radius = getgenv().FOVSize * 2
					fov.Visible = getgenv().ShowFOV
					fov.Position = Vector2.new(Mouse.X, Mouse.Y + GetGuiInset(GS).Y)
		
					return fov
				end
			end
		end
		
		function WTVP(arg)
			return Camera:WorldToViewportPoint(arg)
		end
		
		function WTSP(arg)
			return Camera.WorldToScreenPoint(Camera, arg)
		end
		
		function getClosest()
			local closestPlayer
			local shortestDistance = math.huge
		
			for i, v in pairs(game.Players:GetPlayers()) do
				local notKO = v.Character:WaitForChild("BodyEffects")["K.O"].Value ~= true
				local notGrabbed = v.Character:FindFirstChild("GRABBING_COINSTRAINT") == nil
				
				if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild(getgenv().AimPart) and notKO and notGrabbed then
					local pos = Camera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
					local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
					
					if (getgenv().FOV) then
						if (fov.Radius > magnitude and magnitude < shortestDistance) then
							closestPlayer = v
							shortestDistance = magnitude
						end
					else
						if (magnitude < shortestDistance) then
							closestPlayer = v
							shortestDistance = magnitude
						end
					end
				end
			end
			return closestPlayer
		end
		
		
		Mouse.KeyDown:Connect(function(k)
			SelectedKey = SelectedKey:lower()
			SelectedDisableKey = SelectedDisableKey:lower()
			if k == SelectedKey then
				if AimlockState == true then
					Locked = not Locked
					if Locked then
						Victim = getClosest()
		
						Notify("Locked onto : "..tostring(Victim.Character.Humanoid.DisplayName))
					else
						if Victim ~= nil then
							Victim = nil
		
							Notify("Unlocked!")
						end
					end
				else
					Notify("Aimlock is not enabled!")
				end
			end
			if k == SelectedDisableKey then
				AimlockState = not AimlockState
			end
		end)
		
		RS.RenderStepped:Connect(function()
			update()
			if AimlockState == true then
				if Victim ~= nil then
					Camera.CFrame = CFrame.new(Camera.CFrame.p, Victim.Character[getgenv().AimPart].Position + Victim.Character[getgenv().AimPart].Velocity*getgenv().Prediction)
				end
			end
		end)
			while wait() do
				if getgenv().AutoPrediction == true then
				local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
				local split = string.split(pingvalue,'(')
				local ping = tonumber(split[1])
					if ping < 225 then
					getgenv().Prediction = 1.4
				elseif ping < 215 then
					getgenv().Prediction = 1.2
				elseif ping < 205 then
					getgenv().Prediction = 1.0
				elseif ping < 190 then
					getgenv().Prediction = 0.10
				elseif ping < 180 then
					getgenv().Prediction = 0.12
				elseif ping < 170 then
					getgenv().Prediction = 0.15
				elseif ping < 160 then
					getgenv().Prediction = 0.18
				elseif ping < 150 then
					getgenv().Prediction = 0.110
				elseif ping < 140 then
					getgenv().Prediction = 0.113
				elseif ping < 130 then
					getgenv().Prediction = 0.116
				elseif ping < 120 then
					getgenv().Prediction = 0.120
				elseif ping < 110 then
					getgenv().Prediction = 0.124
				elseif ping < 105 then
					getgenv().Prediction = 0.127
				elseif ping < 90 then
					getgenv().Prediction = 0.130
				elseif ping < 80 then
					getgenv().Prediction = 0.133
				elseif ping < 70 then
					getgenv().Prediction = 0.136
				elseif ping < 60 then
					getgenv().Prediction = 0.15038
				elseif ping < 50 then
					getgenv().Prediction = 0.15038
				elseif ping < 40 then
					getgenv().Prediction = 0.145
				elseif ping < 30 then
					getgenv().Prediction = 0.155
				elseif ping < 20 then
					getgenv().Prediction = 0.157
				end
				end
			end
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]

-- Section Esp Fly

local EP = Lock:AddSection({
	Name = "Esp + Fly"
})

--[[
Name = <string> - The name of the section.
]]

EP:AddButton({
	Name = "Esp",
	Callback = function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "TWR ON TOP";
			Text = "UI + Esp by rave";
			Duration = 10;
		})
		
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Note";
			Text = "This has been made on another GUI to avoid any bugs";
			Duration = 20;
		})
		
		local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")


        if playerGui:FindFirstChild("TWR") then
            playerGui:FindFirstChild("TWR"):Destroy()
        
            for _, player in ipairs(game.Players:GetPlayers()) do
                local billboardGui = player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("PlayerBillboardGui")
                if billboardGui then
                    billboardGui:Destroy()
                end
            end
        end
        

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "TWR"
        screenGui.Parent = playerGui
        screenGui.DisplayOrder = 1
        

        local holder = Instance.new("Frame")
        holder.Name = "Holder"
        holder.Parent = screenGui
        holder.Size = UDim2.new(0, 200, 0, 100) 
        holder.Position = UDim2.new(0.5, -100, 0.5, -50) 
        holder.BackgroundColor3 = Color3.new(0, 0, 0) 
        holder.BackgroundTransparency = 0.5 
        holder.Draggable = true 
        holder.Active = true
        

        local holderTopLeft = Instance.new("UICorner")
        holderTopLeft.CornerRadius = UDim.new(0, 10)
        holderTopLeft.Parent = holder
        
        local holderTopRight = holderTopLeft:Clone()
        holderTopRight.Parent = holder
        holderTopRight.CornerRadius = UDim.new(0, 0)
        holderTopRight.Name = "holderTopRight"
        holderTopRight.Parent = holderTopLeft
        
        local holderBottomLeft = holderTopLeft:Clone()
        holderBottomLeft.Parent = holder
        holderBottomLeft.CornerRadius = UDim.new(0, 0)
        holderBottomLeft.Name = "holderBottomLeft"
        holderBottomLeft.Parent = holderTopLeft
        
        local holderBottomRight = holderTopLeft:Clone()
        holderBottomRight.Parent = holder
        holderBottomRight.CornerRadius = UDim.new(0, 0)
        holderBottomRight.Name = "holderBottomRight"
        holderBottomRight.Parent = holderTopLeft

        local closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Text = "X"
        closeButton.Parent = holder
        closeButton.Size = UDim2.new(0, 20, 0, 20) 
        closeButton.Position = UDim2.new(1, -25, 0, 5) 
        closeButton.BackgroundColor3 = Color3.new(1, 0, 0) 
        closeButton.TextColor3 = Color3.new(1, 1, 1) 
        closeButton.TextScaled = true 
        closeButton.BorderSizePixel = 0
        closeButton.Font = Enum.Font.Gotham 
        closeButton.TextSize = 18 
        

        local function onCloseButtonClicked()
            screenGui:Destroy() 
        end
        
        closeButton.MouseButton1Click:Connect(onCloseButtonClicked)
        

        local closeButtonCorner = Instance.new("UICorner")
        closeButtonCorner.CornerRadius = UDim.new(0, 10)
        closeButtonCorner.Parent = closeButton
        

        local minimizeButton = Instance.new("TextButton")
        minimizeButton.Name = "MinimizeButton"
        minimizeButton.Text = "-"
        minimizeButton.Parent = holder
        minimizeButton.Size = UDim2.new(0, 20, 0, 20) 
        minimizeButton.Position = UDim2.new(1, -50, 0, 5)
        minimizeButton.BackgroundColor3 = Color3.new(0, 0, 0) 
        minimizeButton.TextColor3 = Color3.new(1, 1, 1) 
        minimizeButton.TextScaled = true 
        minimizeButton.BorderSizePixel = 0 
        minimizeButton.Font = Enum.Font.Gotham 
        minimizeButton.TextSize = 18 
        

        local minimizeButtonCorner = Instance.new("UICorner")
        minimizeButtonCorner.CornerRadius = UDim.new(0, 10)
        minimizeButtonCorner.Parent = minimizeButton
        

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "TitleLabel"
        titleLabel.Text = "TWR"
        titleLabel.TextScaled = true
        titleLabel.Parent = holder
        titleLabel.Size = UDim2.new(1, 0, 0.5, 0) 
        titleLabel.BackgroundColor3 = Color3.new(0, 0, 0) 
        titleLabel.TextColor3 = Color3.new(1, 0, 0) 
        titleLabel.BackgroundTransparency = 0.5
        

        local titleLabelCorner = Instance.new("UICorner")
        titleLabelCorner.CornerRadius = UDim.new(0, 0)
        titleLabelCorner.Parent = titleLabel
        

        local statusLabel = Instance.new("TextLabel")
        statusLabel.Name = "StatusLabel"
        statusLabel.Text = "IF YOU CLOSE THIS TAB YOU WILL HAVE TO REJOIN FOR ESP TO WORK"
        statusLabel.Parent = holder
        statusLabel.Size = UDim2.new(1, 0, 0.25, 0) 
        statusLabel.Position = UDim2.new(0, 0, 0.5, 0)
        statusLabel.BackgroundColor3 = Color3.new(0, 0, 0)
        statusLabel.TextColor3 = Color3.new(1, 0, 0) 
        statusLabel.BackgroundTransparency = 0.5 
        statusLabel.TextScaled = true 
        

        local statusLabelCorner = Instance.new("UICorner")
        statusLabelCorner.CornerRadius = UDim.new(0, 0)
        statusLabelCorner.Parent = statusLabel
        

        local statusButton = Instance.new("TextButton")
        statusButton.Name = "StatusButton"
        statusButton.Text = "Off"
        statusButton.Parent = holder
        statusButton.Size = UDim2.new(1, 0, 0.25, 0) 
        statusButton.Position = UDim2.new(0, 0, 0.75, 0) 
        statusButton.BackgroundColor3 = Color3.new(0, 0, 0)
        statusButton.TextColor3 = Color3.new(1, 1, 1) 
        statusButton.BackgroundTransparency = 0.5
        statusButton.TextScaled = true 
        

        local statusButtonCorner = Instance.new("UICorner")
        statusButtonCorner.CornerRadius = UDim.new(0, 0)
        statusButtonCorner.Parent = statusButton
        

        local function createBillboardGuiForPlayer(player, distance)
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "PlayerBillboardGui"
            billboardGui.Adornee = player.Character.Head
            billboardGui.Size = UDim2.new(0, 100, 0, 50) 
            billboardGui.StudsOffset = Vector3.new(0, 2, 0) 
            billboardGui.AlwaysOnTop = true
            billboardGui.LightInfluence = 1
            billboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            billboardGui.Parent = player.Character.Head
        
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "PlayerNameLabel"
            textLabel.Text = player.Name .. "\nDistance: " .. math.floor(distance)
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1 
            textLabel.TextColor3 = Color3.new(1, 0, 0) 
            textLabel.TextScaled = true
            textLabel.TextStrokeColor3 = Color3.new(0, 0, 0) 
            textLabel.TextStrokeTransparency = 0 
            textLabel.Visible = statusButton.Text == "On"
            textLabel.Parent = billboardGui
        end
        

        local function updatePlayerESP()
            local localCharacter = game.Players.LocalPlayer.Character
            if not localCharacter then
                return
            end
        
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local distance = (localCharacter.Head.Position - player.Character.Head.Position).Magnitude
                    local billboardGui = player.Character.Head:FindFirstChild("PlayerBillboardGui")
                    if billboardGui then
                        billboardGui.PlayerNameLabel.Text = player.Name .. "\nDistance: " .. math.floor(distance)
                        billboardGui.PlayerNameLabel.TextColor3 = Color3.new(1, 0, 0) 
                        billboardGui.PlayerNameLabel.Visible = statusButton.Text == "On"
                    else
                        createBillboardGuiForPlayer(player, distance)
                    end
                end
            end
        end
        

        updatePlayerESP()
        game:GetService("RunService").Heartbeat:Connect(function()
            updatePlayerESP()
        end)
        

        local isMinimized = false
        local function onMinimizeButtonClicked()
            isMinimized = not isMinimized
            holder.Size = isMinimized and UDim2.new(0, 200, 0, 25) or UDim2.new(0, 200, 0, 100)
            titleLabel.Visible = not isMinimized
            statusLabel.Visible = not isMinimized
            statusButton.Visible = not isMinimized
        end
        
        minimizeButton.MouseButton1Click:Connect(onMinimizeButtonClicked)
        

        local function onStatusButtonClicked()
            if statusButton.Text == "Off" then
                statusButton.Text = "On"

            else
                statusButton.Text = "Off"

                

                for _, player in ipairs(game.Players:GetPlayers()) do
                    local billboardGui = player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("PlayerBillboardGui")
                    if billboardGui then
                        billboardGui:Destroy()
                    end
                end
            end

            for _, player in ipairs(game.Players:GetPlayers()) do
                local billboardGui = player.Character and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("PlayerBillboardGui")
                if billboardGui then
                    billboardGui.PlayerNameLabel.Visible = statusButton.Text == "On"
                end
            end
        end
        
        statusButton.MouseButton1Click:Connect(onStatusButtonClicked)
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]

EP:AddButton({
	Name = "Fly",
	Callback = function()

        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TWR ON TOP";
            Text = "UI + Fly by rave";
            Duration = 10;
        })
        
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Note";
			Text = "This has been made on another GUI to avoid any bugs";
			Duration = 20;
		})

        local main = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local up = Instance.new("TextButton")
        local down = Instance.new("TextButton")
        local onof = Instance.new("TextButton")
        local TextLabel = Instance.new("TextLabel")
        local plus = Instance.new("TextButton")
        local speed = Instance.new("TextLabel")
        local minus = Instance.new("TextButton")
        local minimizeButton = Instance.new("TextButton")
        local closeButton = Instance.new("TextButton")
        
        main.Name = "main"
        main.Parent = game.CoreGui
        main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        Frame.Parent = main
        Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
        Frame.Position = UDim2.new(0.5, -150, 0, 10) 
        Frame.Size = UDim2.new(0, 300, 0, 154)
        
        TextLabel.Parent = Frame
        TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.Position = UDim2.new(0.5, -50, 0, 0) 
        TextLabel.Size = UDim2.new(0, 100, 0, 28)
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.Text = "TWR"
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 14
        TextLabel.TextWrapped = true
        
        up.Name = "lift"
        up.Parent = Frame
        up.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        up.Position = UDim2.new(0.82, -45, 0.28, 0) 
        up.Size = UDim2.new(0, 90, 0, 28)
        up.Font = Enum.Font.SourceSans
        up.Text = "Up"
        up.TextColor3 = Color3.fromRGB(255, 255, 255)
        up.TextSize = 14
        
        down.Name = "down"
        down.Parent = Frame
        down.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        down.Position = UDim2.new(0.03, 0, 0.28, 0)
        down.Size = UDim2.new(0, 90, 0, 28)
        down.Font = Enum.Font.SourceSans
        down.Text = "Down"
        down.TextColor3 = Color3.fromRGB(255, 255, 255)
        down.TextSize = 14
        
        onof.Name = "onof"
        onof.Parent = Frame
        onof.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        onof.Position = UDim2.new(0.5, -45, 0.28, 0)
        onof.Size = UDim2.new(0, 90, 0, 28)
        onof.Font = Enum.Font.SourceSans
        onof.Text = "Fly"
        onof.TextColor3 = Color3.fromRGB(255, 255, 255)
        onof.TextSize = 14
        
        plus.Name = "plus"
        plus.Parent = Frame
        plus.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        plus.Position = UDim2.new(0.03, 0, 0.55, 0)
        plus.Size = UDim2.new(0, 90, 0, 28)
        plus.Font = Enum.Font.SourceSans
        plus.Text = "+"
        plus.TextColor3 = Color3.fromRGB(255, 255, 255)
        plus.TextSize = 14
        
        speed.Name = "speed"
        speed.Parent = Frame
        speed.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        speed.Position = UDim2.new(0.5, -45, 0.55, 0)
        speed.Size = UDim2.new(0, 90, 0, 28)
        speed.Font = Enum.Font.SourceSans
        speed.Text = "1"
        speed.TextColor3 = Color3.fromRGB(255, 255, 255)
        speed.TextSize = 14
        
        minus.Name = "minus"
        minus.Parent = Frame
        minus.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        minus.Position = UDim2.new(0.97, -90, 0.55, 0)
        minus.Size = UDim2.new(0, 90, 0, 28)
        minus.Font = Enum.Font.SourceSans
        minus.Text = "-"
        minus.TextColor3 = Color3.fromRGB(255, 255, 255)
        minus.TextSize = 14
        
        minimizeButton.Name = "minimizeButton"
        minimizeButton.Parent = Frame
        minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        minimizeButton.Position = UDim2.new(1, -40, 0, 0) 
        minimizeButton.Size = UDim2.new(0, 20, 0, 20)
        minimizeButton.Font = Enum.Font.SourceSans
        minimizeButton.Text = "-"
        minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        minimizeButton.TextSize = 14
        
        closeButton.Name = "closeButton"
        closeButton.Parent = Frame
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        closeButton.Position = UDim2.new(1, -20, 0, 0)
        closeButton.Size = UDim2.new(0, 20, 0, 20)
        closeButton.Font = Enum.Font.SourceSans
        closeButton.Text = "X"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 14
        
        local isCollapsed = false
        
        minimizeButton.MouseButton1Click:Connect(function()
        
            isCollapsed = not isCollapsed
            if isCollapsed then
                Frame.Size = UDim2.new(0, 300, 0, 28) 
                minimizeButton.Text = "+" 
                up.Visible = false
                down.Visible = false
                onof.Visible = false
                plus.Visible = false
                speed.Visible = false
                minus.Visible = false
            else
                Frame.Size = UDim2.new(0, 300, 0, 154) 
                minimizeButton.Text = "-"
                up.Visible = true
                down.Visible = true
                onof.Visible = true
                plus.Visible = true
                speed.Visible = true
                minus.Visible = true
            end
        end)
        
        
        
        closeButton.MouseButton1Click:Connect(function()
            main:Destroy() 
        end)
        
        local speaker = game:GetService("Players").LocalPlayer
        
        local chr = game.Players.LocalPlayer.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        
        local nowe = false
        
        Frame.Active = true 
        Frame.Draggable = true
        
        up.MouseButton1Down:connect(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
        end)
        
        down.MouseButton1Down:connect(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-2,0)
        end)
        
        game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
            wait(0.7)
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
            game.Players.LocalPlayer.Character.Animate.Disabled = false
        end)
        
        plus.MouseButton1Down:connect(function()
            speeds = speeds + 1
            speed.Text = speeds
            if nowe then
                tpwalking = false
                for i = 1, speeds do
                    spawn(function()
                        local hb = game:GetService("RunService").Heartbeat	
                        tpwalking = true
                        local chr = game.Players.LocalPlayer.Character
                        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                            if hum.MoveDirection.Magnitude > 0 then
                                chr:TranslateBy(hum.MoveDirection)
                            end
                        end
                    end)
                end
            end
        end)
        
        minus.MouseButton1Down:connect(function()
            if speeds == 1 then
                speed.Text = 'Cant be under 1'
                wait(1)
                speed.Text = speeds
            else
                speeds = speeds - 1
                speed.Text = speeds
                if nowe then
                    tpwalking = false
                    for i = 1, speeds do
                        spawn(function()
                            local hb = game:GetService("RunService").Heartbeat	
                            tpwalking = true
                            local chr = game.Players.LocalPlayer.Character
                            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                            while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                                if hum.MoveDirection.Magnitude > 0 then
                                    chr:TranslateBy(hum.MoveDirection)
                                end
                            end
                        end)
                    end
                end
            end
        end)
        
        local speeds = 1 
        
        closeButton.MouseButton1Click:Connect(function()
            main:Destroy() 
        end)
        
        local speaker = game:GetService("Players").LocalPlayer
        
        local chr = game.Players.LocalPlayer.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        
        nowe = false
        
        Frame.Active = true 
        Frame.Draggable = true
        
        onof.MouseButton1Down:Connect(function()
        
        if nowe == true then
        nowe = false
        
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        else 
        nowe = true
        
        
        
        for i = 1, speeds do
        spawn(function()
        
            local hb = game:GetService("RunService").Heartbeat	
        
        
            tpwalking = true
            local chr = game.Players.LocalPlayer.Character
            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
            while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                if hum.MoveDirection.Magnitude > 0 then
                    chr:TranslateBy(hum.MoveDirection)
                end
            end
        
        end)
        end
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        local Char = game.Players.LocalPlayer.Character
        local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
        
        for i,v in next, Hum:GetPlayingAnimationTracks() do
        v:AdjustSpeed(0)
        end
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        end
        
        
        
        
        
        local plr = game.Players.LocalPlayer
        local UpperTorso = plr.Character.LowerTorso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed = 0
        
        
        local bg = Instance.new("BodyGyro", UpperTorso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = UpperTorso.CFrame
        local bv = Instance.new("BodyVelocity", UpperTorso)
        bv.velocity = Vector3.new(0,0.1,0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        if nowe == true then
        plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
        wait()
        
        if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            speed = speed+.5+(speed/maxspeed)
            if speed > maxspeed then
                speed = maxspeed
            end
        elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
            speed = speed-1
            if speed < 0 then
                speed = 0
            end
        end
        if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
        elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
        else
            bv.velocity = Vector3.new(0,0,0)
        end
        
        bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false
        
        
        
        
        
        
        
        
        
        end)
        
        
        up.MouseButton1Down:connect(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
        
        end)
        
        
        down.MouseButton1Down:connect(function()
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-2,0)
        
        end)
        
        
        game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
        wait(0.7)
        game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        
        end)
        
        
        plus.MouseButton1Down:connect(function()
        speeds = speeds + 1
        speed.Text = speeds
        if nowe == true then
        
        
        tpwalking = false
        for i = 1, speeds do
        spawn(function()
        
        local hb = game:GetService("RunService").Heartbeat	
        
        
        tpwalking = true
        local chr = game.Players.LocalPlayer.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
            if hum.MoveDirection.Magnitude > 0 then
                chr:TranslateBy(hum.MoveDirection)
            end
        end
        
        end)
        end
        end
        end)
        minus.MouseButton1Down:connect(function()
        if speeds == 1 then
        speed.Text = 'Speed cant be under 1'
        wait(1)
        speed.Text = speeds
        else
        speeds = speeds - 1
        speed.Text = speeds
        if nowe == true then
        tpwalking = false
        for i = 1, speeds do
        spawn(function()
        
        local hb = game:GetService("RunService").Heartbeat	
        
        
        tpwalking = true
        local chr = game.Players.LocalPlayer.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
            if hum.MoveDirection.Magnitude > 0 then
                chr:TranslateBy(hum.MoveDirection)
            end
        end
        
        end)
        end
        end
        end
        end)
        
  	end    
})

local Movement = Lock:AddSection({
	Name = "Movement"
})

Movement:AddSlider({
	Name = "Walkspeed",
	Min = 0,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		print(Value)
	end    
})

--[[
Name = <string> - The name of the slider.
Min = <number> - The minimal value of the slider.
Max = <number> - The maxium value of the slider.
Increment = <number> - How much the slider will change value when dragging.
Default = <number> - The default value of the slider.
ValueName = <string> - The text after the value number.
Callback = <function> - The function of the slider.
]]

local Teleport = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Teleports = Teleport:AddSection({
	Name = "Teleports"
})

Teleports:AddButton({
	Name = "Bank",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-402.123718, 21.75, -283.988617, 0.0159681588, -0.000121377925, -0.999872446, -2.60148026e-05, 1, -0.000121808866, 0.999872506, 2.79565484e-05, 0.0159681737)
  	end    
})

Teleports:AddButton({
	Name = "School",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-622.6171875, 21.24999237060547, 215.10052490234375)
  	end    
})

Teleports:AddButton({
	Name = "Uphill",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(240.2218475341797, 47.75498580932617, -567.9592895507812)
  	end    
})

Teleports:AddButton({
	Name = "Downhill",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-535.847412109375, 7.554839611053467, -695.3775024414062)
  	end    
})

Teleports:AddButton({
	Name = "Military Base",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(40.8932991027832, 25.254995346069336, -866.1915283203125)
  	end    
})

Teleports:AddButton({
	Name = "Casino",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-945.3819580078125, 21.25499153137207, -183.8818359375)
  	end    
})

Teleports:AddButton({
	Name = "Atomic",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-118.20941925048828, -58.7000732421875, 147.12091064453125)
  	end    
})

Teleports:AddButton({
	Name = "UFO",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(81.86492919921875, 138.99993896484375, -646.8959350585938)
  	end    
})

local Guns = Teleport:AddSection({
	Name = "Guns"
})

Guns:AddButton({
	Name = "Double Barrel",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1039.59985, 18.8513641, -256.449951, -1, 0, 0, 0, 1, 0, 0, 0, -1)
  	end    
})

Guns:AddButton({
	Name = "Revolver",
	Callback = function()
		getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-638.75, 18.8500004, -118.175011, -1, 0, 0, 0, 1, 0, 0, 0, -1)
  	end    
})

Guns:AddButton({
	Name = "Shotgun",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-578.623657, 5.47212696, -725.131531, 0, 0, 1, 0, 1, -0, -1, 0, 0)
  	end    
})

Guns:AddButton({
	Name = "Tactical Shotgun",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(470.877533, 45.1272316, -620.630676, 0.999999821, 0.000604254019, -2.60802135e-08, -0.000604254019, 0.999999821, -8.63220048e-05, -2.60802135e-08, 8.63220048e-05, 1)
  	end    
})

Guns:AddButton({
	Name = "Smg",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-577.123413, 5.47666788, -718.031433, -1, 0, 0, 0, 1, 0, 0, 0, -1)
  	end    
})

Guns:AddButton({
	Name = "RPG",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(95.86808013916016, -26.750032424926758, -267.3790588378906)
  	end    
})

local Armor = Teleport:AddSection({
	Name = "Armor"
})

Armor:AddButton({
	Name = "Fire + Normal Armor",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1181.4566650390625, 28.380002975463867, -487.6282653808594)
  	end    
})

Armor:AddButton({
	Name = "Downhill Armor",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-607.978455, 7.44964886, -788.494263, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07)
  	end    
})

Armor:AddButton({
	Name = "Uphill Armor",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(535.5762329101562, 50.32295227050781, -637.4232788085938)
  	end    
})

Armor:AddButton({
	Name = "Uphill Armor 2",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(407.09259033203125, 48.02691650390625, -47.95490646362305)
  	end    
})

Armor:AddButton({
	Name = "High-Medium Armor",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-935.1429443359375, -28.5000057220459, 563.44677734375)
  	end    
})

local Food = Teleport:AddSection({
	Name = "Food"
})

Food:AddButton({
	Name = "Popcorn",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-995, 21.6998043, -153.100037, 1, 0, 0, 0, 1, 0, 0, 0, 1)
  	end    
})

Food:AddButton({
	Name = "Bank Food",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-338.352173, 23.6826477, -297.2146, -0.0060598203, -1.03402984e-08, -0.999981582, -1.61653102e-09, 1, -1.03306892e-08, 0.999981582, 1.55389912e-09, -0.0060598203)
  	end    
})

Food:AddButton({
	Name = "Uphill Food",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(298.737548828125, 49.28265380859375, -613.1434936523438)
  	end    
})

Food:AddButton({
	Name = "Downhill Food",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-282.1579284667969, 21.75499725341797, -797.29248046875)
  	end    
})

-- Extras

local Extras = Window:MakeTab({
	Name = "Extras",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Extrass = Extras:AddSection({
	Name = "Extras"
})

Extrass:AddButton({
	Name = "Fake Macro (Tool)",
	Callback = function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "TWR";
            Text = "Fake Macro by rave";
            Duration = 10;
        })
        
        getgenv().FakeMacro = true
        loadstring(game:HttpGet("https://github.com/ravefrr/FakeMacro/raw/main/FakeMacro.lua"))()
    end
})

Extrass:AddButton({
	Name = "Tryhard Animations",
	Callback = function()
        while true do
            wait(1)
            for i, player in ipairs(game.Players:GetChildren()) do
            local Animate = game.Players.LocalPlayer.Character.Animate
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782841498"
        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
        game.Players.LocalPlayer.Character.Humanoid.Jump = false
            end
        end
    end
})

Extrass:AddButton({
	Name = "Headless (CS)",
	Callback = function()
        getgenv().game.Players.LocalPlayer.Character.Head.Transparency = 1
        getgenv().game.Players.LocalPlayer.Character.Head.face:Destroy()
        getgenv().game.Players.LocalPlayer.Character.Head.face:Destroy()
    end   
})

Extrass:AddButton({
	Name = "Korblox (CS)",
	Callback = function()
        local ply = game.Players.LocalPlayer
        local chr = ply.Character
        chr.RightLowerLeg.MeshId = "902942093"
        chr.RightLowerLeg.Transparency = "1"
        chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
        chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
        chr.RightFoot.MeshId = "902942089"
        chr.RightFoot.Transparency = "1"
    end
})

Extrass:AddButton({
    Name = "Trash Talk (J)",
    Callback = function()
        local plr = game.Players.LocalPlayer
        repeat wait() until plr.Character
        local char = plr.Character
         
        local garbage = {
            "ur bad";
            "sonney boy";
            "ez";
            "my grandma has more skill than you";
            "seed";
            "sit son";
            "trash";
            "LOL";
            "LMAO";
            "imagine being you right now";
            "xd";
            "don't try LOL";
            "you lose";
            "why do you even try";
            "I didn't think being this bad was possible";
            "leave";
            "no skill";
            "so sad man.";
            "bad";
            "you're nothing";
            "lol";
            "so trash";
            "so bad";
            "ur salty";
            "salty";
            "look he's mad";
            "cry more";
            "keep crying";
            "cry baby";
            "hahaha I won";
            "no one likes u";
            "run 1s seed";
            "thank you for your time";
            "you were so close!";
            "better luck next time!";
            "rodent";
            "never seen someone so bad";
            "ill 5-0";
            "just quit";
            "time to take out the trash";
            "did you get worse?";
            "I'm surprised you haven't quit yet";
        }
         
         
        function TrashTalk(inputObject, gameProcessedEvent)
            if inputObject.KeyCode == Enum.KeyCode.J and gameProcessedEvent == false then        
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                garbage[math.random(1,#garbage)],
                "All"
            )
            end
        end
         
        game:GetService("UserInputService").InputBegan:connect(TrashTalk)
        end
})



-- Settings

local Settings = Window:MakeTab({
	Name = "Settings",
	Icon = "rbxassetid://17460504879",
	PremiumOnly = false
})

local ImportantSettings = Settings:AddSection({
	Name = "Important Settings"
})

ImportantSettings:AddToggle({
	Name = "Bypass Anti-Cheat",
	Default = true,
	Callback = function(Value)

		local function BypassAC()
			local OldHook 
			OldHook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
				local Vals = {...}
				local Functions = {"TeleportDetect","CHECKER_1","CHECKER","GUI_CHECK","OneMoreTime","checkingSPEED","BANREMOTE","PERMAIDBAN","KICKREMOTE","BR_KICKPC","BR_KICKMOBILE"}
				for _, FuncName in ipairs(Functions) do
					if tostring(Vals[1]) == FuncName then
						return
					end
				end
				return OldHook(self, ...)
			end))
		end

		task.spawn(function()
			BypassAC()
		  end)

	end    
})

local ExtraSettings = Settings:AddSection({
	Name = "Extra Settings"
})

-- BLACKLISTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT

local function banPlayer(player)
    player:Kick("TWR Has Blacklisted you, Clown.")
end

local playerNameToBan = "XxJuniordriptrixX"
local playerToBan = game.Players:FindFirstChild(playerNameToBan)

if playerToBan then
    banPlayer(playerToBan)
else
    print("Player not found.")
end
