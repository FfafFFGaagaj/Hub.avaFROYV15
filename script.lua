-- FROY Hub GUI & Script (V11.1 Optimized Part 1)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- 1. CLEANUP OLD GUI
local function cleanup()
    for _, parent in pairs({game:GetService("CoreGui"), LocalPlayer:FindFirstChild("PlayerGui")}) do
        if parent then
            for _, child in pairs(parent:GetChildren()) do
                if child.Name:find("FROY_Hub") or child.Name:find("FROY_Lite") then
                    pcall(function() child:Destroy() end)
                end
            end
        end
    end
end
pcall(cleanup)

-- 2. CREATE SCREENGUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FROY_Hub_V11_1_Mobile"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parentSuccess = pcall(function()
    screenGui.Parent = gethui and gethui() or game:GetService("CoreGui")
end)
if not parentSuccess then 
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") 
end

---------------------------------------------------------
-- FLOATING LOGO BUTTON
---------------------------------------------------------
local logoBtn = Instance.new("TextButton")
logoBtn.Name = "FloatingLogo"
logoBtn.Size = UDim2.new(0, 55, 0, 55)
logoBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
logoBtn.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
logoBtn.Text = "FROY\nV11"
logoBtn.TextColor3 = Color3.fromRGB(210, 100, 255)
logoBtn.Font = Enum.Font.GothamBlack
logoBtn.TextSize = 13
logoBtn.Active = true
logoBtn.Draggable = true
logoBtn.Parent = screenGui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0.5, 0)
logoCorner.Parent = logoBtn

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(180, 70, 255)
logoStroke.Thickness = 2.5
logoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
logoStroke.Parent = logoBtn

---------------------------------------------------------
-- MAIN FRAME
---------------------------------------------------------
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 260)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(140, 50, 230)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 35)
titleLabel.Position = UDim2.new(0, 10, 0, 2)
titleLabel.Text = "FROY | Mobile Hub V11.1 💜"
titleLabel.TextColor3 = Color3.fromRGB(180, 90, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

local isMenuOpen = true
logoBtn.MouseButton1Click:Connect(function()
	isMenuOpen = not isMenuOpen
	mainFrame.Visible = isMenuOpen
end)
closeBtn.MouseButton1Click:Connect(function()
	isMenuOpen = false
	mainFrame.Visible = false
end)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 100, 1, -45)
sidebar.Position = UDim2.new(0, 5, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 6)
sideCorner.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Padding = UDim.new(0, 4)
sideLayout.Parent = sidebar

local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -115, 1, -45)
contentContainer.Position = UDim2.new(0, 110, 0, 40)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

local tab1Page = Instance.new("ScrollingFrame")
tab1Page.Size = UDim2.new(1, 0, 1, 0)
tab1Page.BackgroundTransparency = 1
tab1Page.BorderSizePixel = 0
tab1Page.ScrollBarThickness = 3
tab1Page.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 230)
tab1Page.CanvasSize = UDim2.new(0, 0, 0, 330)
tab1Page.Visible = true
tab1Page.Parent = contentContainer

local tab2Page = Instance.new("ScrollingFrame")
tab2Page.Size = UDim2.new(1, 0, 1, 0)
tab2Page.BackgroundTransparency = 1
tab2Page.BorderSizePixel = 0
tab2Page.ScrollBarThickness = 3
tab2Page.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 230)
tab2Page.CanvasSize = UDim2.new(0, 0, 0, 320)
tab2Page.Visible = false
tab2Page.Parent = contentContainer

local list1 = Instance.new("UIListLayout")
list1.SortOrder = Enum.SortOrder.LayoutOrder
list1.Padding = UDim.new(0, 6)
list1.Parent = tab1Page

local list2 = Instance.new("UIListLayout")
list2.SortOrder = Enum.SortOrder.LayoutOrder
list2.Padding = UDim.new(0, 6)
list2.Parent = tab2Page

local function createTabBtn(text, order, targetPage)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.BackgroundColor3 = order == 1 and Color3.fromRGB(140, 50, 230) or Color3.fromRGB(25, 25, 30)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 10
	btn.TextWrapped = true
	btn.LayoutOrder = order
	btn.Parent = sidebar
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		tab1Page.Visible = false
		tab2Page.Visible = false
		for _, child in pairs(sidebar:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
			end
		end
		btn.BackgroundColor3 = Color3.fromRGB(140, 50, 230)
		targetPage.Visible = true
	end)
end

createTabBtn("ช่วยเล่น FROY", 1, tab1Page)
createTabBtn("แมพต่อสู้/ยิงปืน", 2, tab2Page)

---------------------------------------------------------
-- UI HELPER FUNCTIONS
---------------------------------------------------------
local function createToggleRow(parent, text, layoutOrder, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -5, 0, 36)
	frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
	frame.LayoutOrder = layoutOrder
	frame.Parent = parent
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = frame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.65, 0, 1, 0)
	label.Position = UDim2.new(0, 6, 0, 0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.TextSize = 10
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1
	label.Parent = frame
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 45, 0, 22)
	btn.Position = UDim2.new(1, -50, 0.5, -11)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	btn.Text = "OFF"
	btn.TextColor3 = Color3.fromRGB(160, 160, 160)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 9
	btn.Parent = frame
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 4)
	btnCorner.Parent = btn
	
	local enabled = false
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		btn.Text = enabled and "ON" or "OFF"
		btn.BackgroundColor3 = enabled and Color3.fromRGB(140, 50, 230) or Color3.fromRGB(35, 35, 40)
		btn.TextColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
		task.spawn(callback, enabled)
	end)
end

local function createInputRow(parent, text, defaultVal, layoutOrder, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -5, 0, 36)
	frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
	frame.LayoutOrder = layoutOrder
	frame.Parent = parent
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = frame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.5, 0, 1, 0)
	label.Position = UDim2.new(0, 6, 0, 0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.TextSize = 9
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1
	label.Parent = frame
	
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0, 35, 0, 22)
	box.Position = UDim2.new(1, -90, 0.5, -11)
	box.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	box.Text = tostring(defaultVal)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.Font = Enum.Font.Gotham
	box.TextSize = 9
	box.Parent = frame
	
	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 4)
	boxCorner.Parent = box
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 45, 0, 22)
	btn.Position = UDim2.new(1, -50, 0.5, -11)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	btn.Text = "OFF"
	btn.TextColor3 = Color3.fromRGB(160, 160, 160)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 9
	btn.Parent = frame
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 4)
	btnCorner.Parent = btn
	
	local enabled = false
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		local val = tonumber(box.Text) or defaultVal
		btn.Text = enabled and "ON" or "OFF"
		btn.BackgroundColor3 = enabled and Color3.fromRGB(140, 50, 230) or Color3.fromRGB(35, 35, 40)
		btn.TextColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
		task.spawn(callback, enabled, val)
	end)
end

local function createFovCustomRow(parent, text, defaultVal, layoutOrder, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -5, 0, 36)
	frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
	frame.LayoutOrder = layoutOrder
	frame.Parent = parent
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = frame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.42, 0, 1, 0)
	label.Position = UDim2.new(0, 6, 0, 0)
	label.Text = text
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.TextSize = 9
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1
	label.Parent = frame

	local valDisplay = Instance.new("TextLabel")
	valDisplay.Size = UDim2.new(0, 25, 0, 22)
	valDisplay.Position = UDim2.new(1, -115, 0.5, -11)
	valDisplay.BackgroundTransparency = 1
	valDisplay.Text = tostring(defaultVal)
	valDisplay.TextColor3 = Color3.fromRGB(200, 100, 255)
	valDisplay.Font = Enum.Font.GothamBold
	valDisplay.TextSize = 9
	valDisplay.Parent = frame

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0, 35, 0, 22)
	box.Position = UDim2.new(1, -90, 0.5, -11)
	box.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
	box.Text = tostring(defaultVal)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.Font = Enum.Font.Gotham
	box.TextSize = 9
	box.Parent = frame
	
	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 4)
	boxCorner.Parent = box
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 45, 0, 22)
	btn.Position = UDim2.new(1, -50, 0.5, -11)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	btn.Text = "OFF"
	btn.TextColor3 = Color3.fromRGB(160, 160, 160)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 9
	btn.Parent = frame
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 4)
	btnCorner.Parent = btn
	
	local enabled = false
	
	local function updateFovVal()
		local val = tonumber(box.Text) or defaultVal
		valDisplay.Text = tostring(val)
		task.spawn(callback, enabled, val)
	end
	
	box:GetPropertyChangedSignal("Text"):Connect(function()
		local num = tonumber(box.Text)
		if num then
			valDisplay.Text = tostring(num)
			if enabled then
				task.spawn(callback, enabled, num)
			end
		end
	end)

	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		btn.Text = enabled and "ON" or "OFF"
		btn.BackgroundColor3 = enabled and Color3.fromRGB(140, 50, 230) or Color3.fromRGB(35, 35, 40)
		btn.TextColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
		updateFovVal()
	end)
end
---------------------------------------------------------
-- TAB 1 FEATURES (OPTIMIZED)
---------------------------------------------------------
local mode1_Active = false
RunService.RenderStepped:Connect(function()
	if mode1_Active then
		pcall(function()
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local root = char.HumanoidRootPart
				local closestTarget, minDist = nil, math.huge
				
				for _, p in pairs(Players:GetPlayers()) do
					if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
						local targetHrp = p.Character.HumanoidRootPart
						local targetHum = p.Character:FindFirstChildOfClass("Humanoid")
						if targetHum and targetHum.Health > 0 then
							local dist = (targetHrp.Position - root.Position).Magnitude
							if dist < minDist then
								minDist = dist
								closestTarget = targetHrp
							end
						end
					end
				end
				
				if closestTarget then
					root.CFrame = CFrame.new(root.Position, Vector3.new(closestTarget.Position.X, root.Position.Y, closestTarget.Position.Z))
				end
			end
		end)
	end
end)
createToggleRow(tab1Page, "1. หันหาคนใกล้สุด", 1, function(state) mode1_Active = state end)

local mode2_Active = false
local speedVal = 50
RunService.Heartbeat:Connect(function(dt)
	if mode2_Active then
		pcall(function()
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
				local hum = char.Humanoid
				if hum.MoveDirection.Magnitude > 0 then
					char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (hum.MoveDirection * (speedVal * dt))
				end
			end
		end)
	end
end)
createInputRow(tab1Page, "2. ความเร็ววิ่ง", 50, 2, function(state, val)
	mode2_Active = state
	speedVal = math.clamp(val, 1, 1000)
end)

local mode3_Active = false
local function updatePlayerESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			pcall(function()
				local hl = p.Character:FindFirstChild("FROY_ESP")
				if mode3_Active then
					if not hl then
						hl = Instance.new("Highlight")
						hl.Name = "FROY_ESP"
						hl.FillColor = Color3.fromRGB(255, 0, 0)
						hl.OutlineColor = Color3.fromRGB(255, 255, 255)
						hl.Parent = p.Character
					end
				else
					if hl then hl:Destroy() end
				end
			end)
		end
	end
end
createToggleRow(tab1Page, "3. ESP ผู้เล่น (แดง)", 3, function(state)
	mode3_Active = state
	updatePlayerESP()
end)

createToggleRow(tab1Page, "4. รีเซ็ตตัวเองทันที", 4, function(state)
	if state then
		pcall(function()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid.Health = 0
			end
		end)
	end
end)

local npcEspActive = false
task.spawn(function()
	while task.wait(2) do
		if npcEspActive then
			pcall(function()
				for _, obj in pairs(Workspace:GetChildren()) do
					if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
						if not obj:FindFirstChild("FROY_NPC_ESP") then
							local hl = Instance.new("Highlight")
							hl.Name = "FROY_NPC_ESP"
							hl.FillColor = Color3.fromRGB(170, 0, 255)
							hl.OutlineColor = Color3.fromRGB(255, 255, 255)
							hl.Parent = obj
						end
					end
				end
			end)
		end
	end
end)
createToggleRow(tab1Page, "5. ESP NPC/มอน (ม่วง)", 5, function(state)
	npcEspActive = state
	if not state then
		pcall(function()
			for _, obj in pairs(Workspace:GetChildren()) do
				if obj:FindFirstChild("FROY_NPC_ESP") then obj.FROY_NPC_ESP:Destroy() end
			end
		end)
	end
end)

local tracerActive = false
local function updateTracers()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			pcall(function()
				local box = p.Character:FindFirstChild("FROY_TRACER")
				if tracerActive then
					if not box then
						box = Instance.new("SelectionBox")
						box.Name = "FROY_TRACER"
						box.Color3 = Color3.fromRGB(180, 50, 255)
						box.Adornee = p.Character
						box.Parent = p.Character
					end
				else
					if box then box:Destroy() end
				end
			end)
		end
	end
end
createToggleRow(tab1Page, "6. ESP Tracers (ม่วง)", 6, function(state)
	tracerActive = state
	updateTracers()
end)

local camSensitivityActive = false
local camSensitivityVal = 50

UserInputService.InputChanged:Connect(function(input, processed)
	if camSensitivityActive and not processed then
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			pcall(function()
				local UserGameSettings = UserSettings():GetService("UserGameSettings")
				UserGameSettings.MouseSensitivity = camSensitivityVal / 50
			end)
		end
	end
end)

createInputRow(tab1Page, "7. ความไวหันหน้าจอ (1-500)", 50, 7, function(state, val)
	camSensitivityActive = state
	camSensitivityVal = math.clamp(val, 1, 500)
	
	if not state then
		pcall(function()
			local UserGameSettings = UserSettings():GetService("UserGameSettings")
			UserGameSettings.MouseSensitivity = 1
		end)
	end
end)

---------------------------------------------------------
-- TAB 2 FEATURES
---------------------------------------------------------
local tpClickActive = false
UserInputService.InputBegan:Connect(function(input, processed)
	if tpClickActive and not processed then
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			pcall(function()
				local targetPos = input.Position
				local unitRay = Camera:ViewportPointToRay(targetPos.X, targetPos.Y)
				local ray = Ray.new(unitRay.Origin, unitRay.Direction * 10000)
				local hit, hitPos = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character})
				if hitPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hitPos + Vector3.new(0, 3, 0))
				end
			end)
		end
	end
end)
createToggleRow(tab2Page, "1. วาร์ปตามจุดที่แตะ/คลิก", 1, function(state) tpClickActive = state end)

local hitboxActive = false
local hitboxSize = 15
RunService.RenderStepped:Connect(function()
	if hitboxActive then
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				pcall(function()
					local hrp = p.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
						hrp.Transparency = 0.7
						hrp.BrickColor = BrickColor.new("Royal purple")
						hrp.CanCollide = false
					end
				end)
			end
		end
	end
end)
createInputRow(tab2Page, "2. Hitbox ระยะไกล (2-50)", 15, 2, function(state, val)
	hitboxActive = state
	hitboxSize = math.clamp(val, 2, 50)
	if not state then
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				pcall(function()
					local hrp = p.Character.HumanoidRootPart
					hrp.Size = Vector3.new(2, 2, 1)
					hrp.Transparency = 1
				end)
			end
		end
	end
end)

---------------------------------------------------------
-- OPTIMIZED & CENTERED FOV LOCK HEAD SYSTEM (LAG-FREE)
---------------------------------------------------------
local fovFrame = Instance.new("Frame")
fovFrame.Name = "FOV_Circle"
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
fovFrame.BackgroundTransparency = 1
fovFrame.Visible = false
fovFrame.Parent = screenGui

local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Color3.fromRGB(180, 50, 255)
fovStroke.Thickness = 1.5
fovStroke.Parent = fovFrame

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovFrame

local fovActive = false
local fovRadius = 100
local fovShowCircle = true

local function getClosestHeadInFOV()
	local closestHead = nil
	local shortestDist = fovRadius
	local centerPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			pcall(function()
				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				local head = p.Character:FindFirstChild("Head")
				if hum and hum.Health > 0 and head then
					local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
					if onScreen and screenPos.Z > 0 then
						local dist = (Vector2.new(screenPos.X, screenPos.Y) - centerPos).Magnitude
						if dist <= shortestDist then
							shortestDist = dist
							closestHead = head
						end
					end
				end
			end)
		end
	end
	return closestHead
end

RunService.RenderStepped:Connect(function()
	if fovActive then
		pcall(function()
			fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			fovFrame.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
			fovFrame.Visible = fovShowCircle

			local targetHead = getClosestHeadInFOV()
			if targetHead then
				Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetHead.Position), 0.35)
			end
		end)
	else
		fovFrame.Visible = false
	end
end)

createFovCustomRow(tab2Page, "3. FOV ล็อคหัว (1-300)", 100, 3, function(state, val)
	fovActive = state
	fovRadius = math.clamp(val, 1, 300)
end)

createToggleRow(tab2Page, "4. ซ่อนวง FOV", 4, function(state) fovShowCircle = not state end)

local noclipActive = false
RunService.Stepped:Connect(function()
	if noclipActive and LocalPlayer.Character then
		pcall(function()
			for _, part in pairs(LocalPlayer.Character:GetChildren()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end)
	end
end)
createToggleRow(tab2Page, "5. เดินทะลุกำแพง", 5, function(state) noclipActive = state end)

local infJumpActive = false
local jumpPowerVal = 50

UserInputService.JumpRequest:Connect(function()
	if infJumpActive then
		pcall(function()
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
				char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X, jumpPowerVal, char.HumanoidRootPart.Velocity.Z)
			end
		end)
	end
end)

createInputRow(tab2Page, "6. โดดรัวๆ (สูง 1-500)", 50, 6, function(state, val)
	infJumpActive = state
	jumpPowerVal = math.clamp(val, 1, 500)
end)

local autoClickActive = false
task.spawn(function()
	while true do
		task.wait(0.1)
		if autoClickActive and LocalPlayer.Character then
			pcall(function()
				local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
				if tool then tool:Activate() end
			end)
		end
	end
end)
createToggleRow(tab2Page, "7. Auto Attack (ตีรัว)", 7, function(state) autoClickActive = state end)
