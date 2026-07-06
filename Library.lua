local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ==========================================
-- TODDYZ LIBRARY - CORE
-- ==========================================
local ToddyzLibrary = {}

local function applyHoverAnimation(guiObject)
	local originalSize = guiObject.Size
	local shrinkedSize = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 5, originalSize.Y.Scale, originalSize.Y.Offset - 5)
	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	guiObject.MouseEnter:Connect(function() TweenService:Create(guiObject, tweenInfo, {Size = shrinkedSize}):Play() end)
	guiObject.MouseLeave:Connect(function() TweenService:Create(guiObject, tweenInfo, {Size = originalSize}):Play() end)
end

-- ==========================================
-- SISTEMA DE NOTIFICAÇÃO (NOTIFY)
-- ==========================================
function ToddyzLibrary:Notify(text, duration)
	duration = duration or 3
	
	local notifyGui = PlayerGui:FindFirstChild("TODDYZ_NOTIFY_UI")
	if not notifyGui then
		notifyGui = Instance.new("ScreenGui")
		notifyGui.Name = "TODDYZ_NOTIFY_UI"
		notifyGui.Parent = PlayerGui
	end

	local NotifFrame = Instance.new("Frame")
	NotifFrame.Size = UDim2.new(0, 250, 0, 60)
	-- Começa escondido fora da tela (lado direito)
	NotifFrame.Position = UDim2.new(1, 10, 1, -80) 
	NotifFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
	NotifFrame.BorderSizePixel = 0
	NotifFrame.Parent = notifyGui
	Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 8)

	local NotifText = Instance.new("TextLabel")
	NotifText.Size = UDim2.new(1, -20, 1, 0)
	NotifText.Position = UDim2.new(0, 10, 0, 0)
	NotifText.BackgroundTransparency = 1
	NotifText.Text = text
	NotifText.TextColor3 = Color3.new(1,1,1)
	NotifText.Font = Enum.Font.GothamBold
	NotifText.TextSize = 14
	NotifText.TextWrapped = true
	NotifText.Parent = NotifFrame

	-- Animação entrando na tela
	TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -260, 1, -80)}):Play()

	-- Espera o tempo e faz a animação saindo
	task.delay(duration, function()
		local tweenOut = TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 1, -80)})
		tweenOut:Play()
		tweenOut.Completed:Wait()
		NotifFrame:Destroy()
	end)
end

-- ==========================================
-- SISTEMA DE JANELA E TABS
-- ==========================================
function ToddyzLibrary:CreateWindow(titleText)
	local Window = {}
	
	if PlayerGui:FindFirstChild("TODDYZ_HELPER_UI") then
		PlayerGui.TODDYZ_HELPER_UI:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "TODDYZ_HELPER_UI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = PlayerGui

	local Main = Instance.new("Frame")
	Main.Size = UDim2.new(0, 350, 0, 260)
	Main.Position = UDim2.new(0.5, -175, 0.5, -130)
	Main.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Parent = ScreenGui
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 40)
	TopBar.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
	TopBar.BorderSizePixel = 0
	TopBar.Parent = Main
	Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

	local TopBarExtension = Instance.new("Frame")
	TopBarExtension.Size = UDim2.new(1, 0, 0, 10)
	TopBarExtension.Position = UDim2.new(0, 0, 1, -10)
	TopBarExtension.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
	TopBarExtension.BorderSizePixel = 0
	TopBarExtension.Parent = TopBar

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -50, 1, 0)
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = titleText or "Toddyz library"
	Title.TextColor3 = Color3.new(1,1,1)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 20
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TopBar

	local Minimize = Instance.new("TextButton")
	Minimize.Size = UDim2.new(0, 30, 0, 30)
	Minimize.Position = UDim2.new(1, -35, 0, 5)
	Minimize.Text = "-"
	Minimize.TextColor3 = Color3.new(1,1,1)
	Minimize.BackgroundColor3 = Color3.fromRGB(0, 90, 0)
	Minimize.Font = Enum.Font.GothamBold
	Minimize.TextSize = 22
	Minimize.Parent = TopBar
	Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 8)

	-- Sistema de arrastar (Dragging) com suporte a mobile (Touch)
	local dragging, dragInput, dragStart, startPos
	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	TopBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	-- TabBar com Scroll Horizontal
	local TabBar = Instance.new("ScrollingFrame")
	TabBar.Size = UDim2.new(1, 0, 0, 35)
	TabBar.Position = UDim2.new(0, 0, 0, 40)
	TabBar.BackgroundColor3 = Color3.fromRGB(0, 90, 0)
	TabBar.BorderSizePixel = 0
	TabBar.ScrollBarThickness = 0
	TabBar.ScrollingDirection = Enum.ScrollingDirection.X
	TabBar.ClipsDescendants = true
	TabBar.Parent = Main

	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.Parent = TabBar
	TabListLayout.FillDirection = Enum.FillDirection.Horizontal
	TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabBar.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X, 0, 0)
	end)

	local PagesContainer = Instance.new("Frame")
	PagesContainer.Size = UDim2.new(1, 0, 1, -75)
	PagesContainer.Position = UDim2.new(0, 0, 0, 75)
	PagesContainer.BackgroundTransparency = 1
	PagesContainer.Parent = Main

	local minimized = false
	local normalSize = Main.Size
	Minimize.MouseButton1Click:Connect(function()
		minimized = not minimized
		PagesContainer.Visible = not minimized
		TabBar.Visible = not minimized
		Minimize.Text = minimized and "+" or "-"
		TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = minimized and UDim2.new(0, 350, 0, 40) or normalSize}):Play()
	end)

	Window.Tabs = {}
	Window.TabFrames = {}
	local firstTab = true

	function Window:CreateTab(tabName)
		local Tab = {}
		
		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(0, 100, 1, 0)
		TabButton.BackgroundTransparency = 1
		TabButton.Text = tabName
		TabButton.TextColor3 = firstTab and Color3.new(1,1,1) or Color3.fromRGB(200,200,200)
		TabButton.Font = Enum.Font.GothamBold
		TabButton.TextSize = 14
		TabButton.Parent = TabBar
		
		local Page = Instance.new("ScrollingFrame")
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.ScrollBarThickness = 0
		Page.ScrollingDirection = Enum.ScrollingDirection.Y
		Page.ClipsDescendants = true
		Page.Visible = firstTab
		Page.Parent = PagesContainer

		local PageLayout = Instance.new("UIListLayout")
		PageLayout.Parent = Page
		PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 10)
		
		Instance.new("UIPadding", Page).PaddingTop = UDim.new(0, 10)

		PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
		end)

		table.insert(Window.Tabs, TabButton)
		table.insert(Window.TabFrames, Page)

		TabButton.MouseButton1Click:Connect(function()
			for _, v in pairs(Window.Tabs) do v.TextColor3 = Color3.fromRGB(200,200,200) end
			for _, v in pairs(Window.TabFrames) do v.Visible = false end
			TabButton.TextColor3 = Color3.new(1,1,1)
			Page.Visible = true
		end)

		firstTab = false

		-- COMPONENTE: LABEL
		function Tab:CreateLabel(text)
			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -10, 0, 20)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.TextColor3 = Color3.new(1,1,1)
			Label.Font = Enum.Font.Gotham
			Label.TextSize = 14
			Label.Parent = Page
		end

		-- COMPONENTE: BUTTON
		function Tab:CreateButton(text, callback)
			local Button = Instance.new("TextButton")
			Button.Size = UDim2.new(1, -10, 0, 35)
			Button.Text = text
			Button.TextColor3 = Color3.new(1,1,1)
			Button.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
			Button.Font = Enum.Font.GothamBold
			Button.Parent = Page
			Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
			applyHoverAnimation(Button)
			
			Button.MouseButton1Click:Connect(function()
				if callback then callback() end
			end)
		end

		-- COMPONENTE: TOGGLE
		function Tab:CreateToggle(text, callback)
			local ToggleBtn = Instance.new("TextButton")
			ToggleBtn.Size = UDim2.new(1, -10, 0, 35)
			ToggleBtn.Text = text .. ": OFF"
			ToggleBtn.TextColor3 = Color3.new(1,1,1)
			ToggleBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
			ToggleBtn.Font = Enum.Font.GothamBold
			ToggleBtn.Parent = Page
			Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)
			applyHoverAnimation(ToggleBtn)

			local Enabled = false
			ToggleBtn.MouseButton1Click:Connect(function()
				Enabled = not Enabled
				local targetColor = Enabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
				ToggleBtn.Text = Enabled and (text .. ": ON") or (text .. ": OFF")
				TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
				if callback then callback(Enabled) end
			end)
		end

		-- COMPONENTE: INPUT
		function Tab:CreateInput(placeholder, callback)
			local InputBox = Instance.new("TextBox")
			InputBox.Size = UDim2.new(1, -10, 0, 35)
			InputBox.PlaceholderText = placeholder
			InputBox.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
			InputBox.TextColor3 = Color3.new(1,1,1)
			InputBox.PlaceholderColor3 = Color3.fromRGB(200,200,200)
			InputBox.Font = Enum.Font.Gotham
			InputBox.TextSize = 14
			InputBox.Parent = Page
			Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 8)
			applyHoverAnimation(InputBox)
			
			InputBox.FocusLost:Connect(function()
				if callback then callback(InputBox.Text) end
			end)
		end

		return Tab
	end

	return Window
end

return ToddyzLibrary
