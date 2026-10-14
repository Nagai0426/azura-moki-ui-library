-- Azura Moki - Functional UI Library Framework
local Library = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

function Library.new(titleText)
    local self = {}
    self.Tabs = {}

    local function getGuiParent()
        if gethui then return gethui()
        elseif game:GetService("CoreGui") then
            local s, r = pcall(function() return game:GetService("CoreGui") end)
            if s then return r end
        end
        return LocalPlayer:WaitForChild("PlayerGui")
    end

    local parentGui = getGuiParent()
    if parentGui:FindFirstChild("AzuraMokiGUI") then
        parentGui.AzuraMokiGUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AzuraMokiGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = parentGui
    self.ScreenGui = ScreenGui

    local MainScale = Instance.new("UIScale")
    MainScale.Scale = 1
    MainScale.Parent = ScreenGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 390)
    MainFrame.Position = UDim2.new(0.5, -250, 0.4, -195)
    MainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
    MainFrame.BackgroundTransparency = 0.12
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Thickness = 1.2
    MainStroke.Color = Color3.fromRGB(55, 55, 75)
    MainStroke.Transparency = 0.2
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1
    Header.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 16, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Azura Moki"
    Title.TextColor3 = Color3.fromRGB(245, 245, 250)
    Title.TextSize = 13
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
    MinimizeBtn.Position = UDim2.new(1, -34, 0.5, -12)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    MinimizeBtn.BackgroundTransparency = 0.3
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = Color3.fromRGB(210, 210, 225)
    MinimizeBtn.TextSize = 15
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.AutoButtonColor = false
    MinimizeBtn.Parent = Header

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(1, 0)
    MinCorner.Parent = MinimizeBtn

    local TopBarContainer = Instance.new("ScrollingFrame")
    TopBarContainer.Size = UDim2.new(1, -16, 0, 32)
    TopBarContainer.Position = UDim2.new(0, 8, 0, 42)
    TopBarContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    TopBarContainer.BackgroundTransparency = 0.5
    TopBarContainer.BorderSizePixel = 0
    TopBarContainer.CanvasSize = UDim2.new(2, 0, 0, 0)
    TopBarContainer.ScrollBarThickness = 0
    TopBarContainer.Parent = MainFrame

    local TopBarLayout = Instance.new("UIListLayout")
    TopBarLayout.FillDirection = Enum.FillDirection.Horizontal
    TopBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TopBarLayout.Padding = UDim.new(0, 5)
    TopBarLayout.Parent = TopBarContainer

    local ContentArea = Instance.new("Frame")
    ContentArea.Size = UDim2.new(1, -16, 1, -86)
    ContentArea.Position = UDim2.new(0, 8, 0, 80)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainFrame

    local MiniPill = Instance.new("TextButton")
    MiniPill.Size = UDim2.new(0, 110, 0, 30)
    MiniPill.Position = UDim2.new(0.5, -55, 0, 10)
    MiniPill.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
    MiniPill.BackgroundTransparency = 0.15
    MiniPill.Text = "Azura"
    MiniPill.TextColor3 = Color3.fromRGB(255, 255, 255)
    MiniPill.TextSize = 11
    MiniPill.Font = Enum.Font.GothamBold
    MiniPill.Visible = false
    MiniPill.Parent = ScreenGui

    local PillCorner = Instance.new("UICorner")
    PillCorner.CornerRadius = UDim.new(1, 0)
    PillCorner.Parent = MiniPill

    local PillStroke = Instance.new("UIStroke")
    PillStroke.Thickness = 1.2
    PillStroke.Color = Color3.fromRGB(60, 60, 85)
    PillStroke.Transparency = 0.3
    PillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    PillStroke.Parent = MiniPill

    local function enableDrag(frame)
        local dragging, dragInput, dragStart, startPos
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                TweenService:Create(frame, TweenInfo.new(0.08, Enum.EasingStyle.Sine), {
                    Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                }):Play()
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    enableDrag(MainFrame)

    local isMinimized = false
    local function toggleMinimize(state)
        isMinimized = state
        if isMinimized then
            MainFrame.Visible = false
            MiniPill.Visible = true
        else
            MiniPill.Visible = false
            MainFrame.Visible = true
        end
    end

    MinimizeBtn.MouseButton1Click:Connect(function() toggleMinimize(true) end)
    MiniPill.MouseButton1Click:Connect(function() toggleMinimize(false) end)

    function self:SetScale(scaleValue)
        MainScale.Scale = math.clamp(scaleValue, 0.25, 2.0)
    end

    function self:AddTab(tabName)
        local tabObj = {}

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.CanvasSize = UDim2.new(0, 0, 0, 1000)
        Page.ScrollBarThickness = 2
        Page.Visible = false
        Page.Parent = ContentArea

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 7)
        PageLayout.Parent = Page

        local PagePadding = Instance.new("UIPadding")
        PagePadding.PaddingTop = UDim.new(0, 8)
        PagePadding.PaddingLeft = UDim.new(0, 4)
        PagePadding.PaddingRight = UDim.new(0, 4)
        PagePadding.Parent = Page

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 95, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        TabBtn.BackgroundTransparency = 0.2
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
        TabBtn.TextSize = 10.5
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.AutoButtonColor = false
        TabBtn.Parent = TopBarContainer

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(self.Tabs) do
                t.Page.Visible = false
                t.Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
                t.Btn.BackgroundTransparency = 0.2
                t.Btn.TextColor3 = Color3.fromRGB(150, 150, 170)
            end
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
            TabBtn.BackgroundTransparency = 0
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        if #self.Tabs == 0 then
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
            TabBtn.BackgroundTransparency = 0
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        table.insert(self.Tabs, {Page = Page, Btn = TabBtn})

        function tabObj:AddWelcomeCard()
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, 0, 0, 70)
            Card.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            Card.BackgroundTransparency = 0.25
            Card.Parent = Page

            local CardCorner = Instance.new("UICorner")
            CardCorner.CornerRadius = UDim.new(0, 8)
            CardCorner.Parent = Card

            local AvatarImg = Instance.new("ImageLabel")
            AvatarImg.Size = UDim2.new(0, 50, 0, 50)
            AvatarImg.Position = UDim2.new(0, 10, 0.5, -25)
            AvatarImg.BackgroundTransparency = 1
            AvatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            AvatarImg.Parent = Card

            local ImgCorner = Instance.new("UICorner")
            ImgCorner.CornerRadius = UDim.new(1, 0)
            ImgCorner.Parent = AvatarImg

            local WelcomeText = Instance.new("TextLabel")
            WelcomeText.Size = UDim2.new(1, -75, 0, 20)
            WelcomeText.Position = UDim2.new(0, 70, 0, 14)
            WelcomeText.BackgroundTransparency = 1
            WelcomeText.Text = "Welcome, " .. LocalPlayer.Name .. "!"
            WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
            WelcomeText.TextSize = 12.5
            WelcomeText.Font = Enum.Font.GothamBold
            WelcomeText.TextXAlignment = Enum.TextXAlignment.Left
            WelcomeText.Parent = Card

            local SubText = Instance.new("TextLabel")
            SubText.Size = UDim2.new(1, -75, 0, 18)
            SubText.Position = UDim2.new(0, 70, 0, 34)
            SubText.BackgroundTransparency = 1
            SubText.Text = "Azura Moki Engine Active ⚡"
            SubText.TextColor3 = Color3.fromRGB(0, 198, 255)
            SubText.TextSize = 9.5
            SubText.Font = Enum.Font.GothamMedium
            SubText.TextXAlignment = Enum.TextXAlignment.Left
            SubText.Parent = Card
        end

        function tabObj:AddDashboardStats()
            local StatsFrame = Instance.new("Frame")
            StatsFrame.Size = UDim2.new(1, 0, 0, 130)
            StatsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            StatsFrame.BackgroundTransparency = 0.25
            StatsFrame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = StatsFrame

            local InfoLabel = Instance.new("TextLabel")
            InfoLabel.Size = UDim2.new(1, -16, 1, -36)
            InfoLabel.Position = UDim2.new(0, 8, 0, 4)
            InfoLabel.BackgroundTransparency = 1
            InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 215)
            InfoLabel.TextSize = 10.5
            InfoLabel.Font = Enum.Font.Gotham
            InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
            InfoLabel.TextYAlignment = Enum.TextYAlignment.Center
            InfoLabel.Parent = StatsFrame

            local CopyBtn = Instance.new("TextButton")
            CopyBtn.Size = UDim2.new(1, -16, 0, 28)
            CopyBtn.Position = UDim2.new(0, 8, 1, -32)
            CopyBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
            CopyBtn.Text = "Copy Info to Clipboard"
            CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            CopyBtn.TextSize = 10.5
            CopyBtn.Font = Enum.Font.GothamBold
            CopyBtn.AutoButtonColor = false
            CopyBtn.Parent = StatsFrame

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = CopyBtn

            local currentInfoText = ""
            task.spawn(function()
                while task.wait(1) do
                    if not StatsFrame.Parent then break end
                    local device = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and "Mobile" or "Desktop"
                    local timeStr = os.date("%I:%M:%S %p")
                    local battery = "N/A"
                    if getbattery then
                        pcall(function() battery = math.floor(getbattery() * 100) .. "%" end)
                    end
                    local fps = math.floor(1 / RunService.RenderStepped:Wait())
                    local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)

                    currentInfoText = string.format("Timer: %s | Device: %s | Battery: %s | FPS: %d | Ping: %dms", timeStr, device, battery, fps, ping)
                    InfoLabel.Text = string.format("Time: %s\nDevice: %s\nBattery: %s\nFPS: %d | Ping: %dms", timeStr, device, battery, fps, ping)
                end
            end)

            CopyBtn.MouseButton1Click:Connect(function()
                if setclipboard then
                    setclipboard(currentInfoText)
                    CopyBtn.Text = "Copied Successfully!"
                    task.wait(1.5)
                    CopyBtn.Text = "Copy Info to Clipboard"
                end
            end)
        end

        function tabObj:AddUsableScripts()
            local RejoinBtn = Instance.new("TextButton")
            RejoinBtn.Size = UDim2.new(1, 0, 0, 34)
            RejoinBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
            RejoinBtn.Text = "Rejoin Server"
            RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            RejoinBtn.TextSize = 10.5
            RejoinBtn.Font = Enum.Font.GothamMedium
            RejoinBtn.AutoButtonColor = false
            RejoinBtn.Parent = Page

            local rc = Instance.new("UICorner")
            rc.CornerRadius = UDim.new(0, 6)
            rc.Parent = RejoinBtn

            RejoinBtn.MouseButton1Click:Connect(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            end)

            local SearchBox = Instance.new("TextBox")
            SearchBox.Size = UDim2.new(1, 0, 0, 34)
            SearchBox.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            SearchBox.BackgroundTransparency = 0.25
            SearchBox.PlaceholderText = "Type Player Name..."
            SearchBox.Text = ""
            SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
            SearchBox.TextSize = 10.5
            SearchBox.Font = Enum.Font.Gotham
            SearchBox.Parent = Page

            local sc = Instance.new("UICorner")
            sc.CornerRadius = UDim.new(0, 6)
            sc.Parent = SearchBox

            local TPBtn = Instance.new("TextButton")
            TPBtn.Size = UDim2.new(1, 0, 0, 34)
            TPBtn.BackgroundColor3 = Color3.fromRGB(255, 149, 0)
            TPBtn.Text = "Teleport to Player"
            TPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            TPBtn.TextSize = 10.5
            TPBtn.Font = Enum.Font.GothamBold
            TPBtn.AutoButtonColor = false
            TPBtn.Parent = Page

            local tpc = Instance.new("UICorner")
            tpc.CornerRadius = UDim.new(0, 6)
            tpc.Parent = TPBtn

            TPBtn.MouseButton1Click:Connect(function()
                local targetName = string.lower(SearchBox.Text)
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and (string.find(string.lower(plr.Name), targetName) or string.find(string.lower(plr.DisplayName), targetName)) then
                        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        end
                        break
                    end
                end
            end)

            local CopyIDBtn = Instance.new("TextButton")
            CopyIDBtn.Size = UDim2.new(1, 0, 0, 34)
            CopyIDBtn.BackgroundColor3 = Color3.fromRGB(175, 82, 222)
            CopyIDBtn.Text = "Copy Player User ID"
            CopyIDBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            CopyIDBtn.TextSize = 10.5
            CopyIDBtn.Font = Enum.Font.GothamBold
            CopyIDBtn.AutoButtonColor = false
            CopyIDBtn.Parent = Page

            local cic = Instance.new("UICorner")
            cic.CornerRadius = UDim.new(0, 6)
            cic.Parent = CopyIDBtn

            CopyIDBtn.MouseButton1Click:Connect(function()
                local targetName = string.lower(SearchBox.Text)
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and (string.find(string.lower(plr.Name), targetName) or string.find(string.lower(plr.DisplayName), targetName)) then
                        if setclipboard then
                            setclipboard(tostring(plr.UserId))
                        end
                        break
                    end
                end
            end)
        end

        function tabObj:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.BackgroundTransparency = 1
            Label.Text = string.upper(text)
            Label.TextColor3 = Color3.fromRGB(120, 120, 145)
            Label.TextSize = 9.5
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Page
            return Label
        end

        function tabObj:AddButton(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 34)
            Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            Btn.BackgroundTransparency = 0.25
            Btn.Text = text
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 10.5
            Btn.Font = Enum.Font.GothamMedium
            Btn.AutoButtonColor = false
            Btn.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Btn

            Btn.MouseButton1Click:Connect(function() pcall(callback) end)
        end

        function tabObj:AddSlider(text, min, max, default, callback)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 46)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            SliderFrame.BackgroundTransparency = 0.25
            SliderFrame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = SliderFrame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -16, 0, 20)
            Label.Position = UDim2.new(0, 8, 0, 4)
            Label.BackgroundTransparency = 1
            Label.Text = text .. ": " .. tostring(default)
            Label.TextColor3 = Color3.fromRGB(220, 220, 235)
            Label.TextSize = 10.5
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = SliderFrame

            local Bar = Instance.new("TextButton")
            Bar.Size = UDim2.new(1, -16, 0, 5)
            Bar.Position = UDim2.new(0, 8, 0, 30)
            Bar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            Bar.Text = ""
            Bar.AutoButtonColor = false
            Bar.Parent = SliderFrame

            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(1, 0)
            BarCorner.Parent = Bar

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
            Fill.BorderSizePixel = 0
            Fill.Parent = Bar

            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = Fill

            local dragging = false
            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                    Fill.Size = UDim2.new(pos, 0, 1, 0)
                    local val = math.floor(min + ((max - min) * pos))
                    Label.Text = text .. ": " .. tostring(val)
                    pcall(callback, val)
                end
            end)
        end

        function tabObj:AddTextBox(placeholder, callback)
            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(1, 0, 0, 34)
            Box.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            Box.BackgroundTransparency = 0.25
            Box.PlaceholderText = placeholder
            Box.Text = ""
            Box.TextColor3 = Color3.fromRGB(255, 255, 255)
            Box.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
            Box.TextSize = 10.5
            Box.Font = Enum.Font.Gotham
            Box.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Box

            Box.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    pcall(callback, Box.Text)
                end
            end)
        end

        return tabObj
    end

    return self
end

return Library
