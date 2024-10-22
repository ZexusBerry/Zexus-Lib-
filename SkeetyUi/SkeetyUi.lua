-- UI Library
local UILib = {}

function UILib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleBar = Instance.new("TextLabel")
    local TabContainer = Instance.new("Frame")

    ScreenGui.Parent = game.CoreGui

    -- Main Frame
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 0, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Visible = true
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- Title Bar
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Text = title
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.TextScaled = true

    -- Tabs
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContainer.Size = UDim2.new(0, 120, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)

    local Tabs = {}
    local CurrentTab = nil

    -- Animation for showing the window
    MainFrame:TweenSize(UDim2.new(0, 600, 0, 400), "Out", "Quad", 0.5, true)

    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            if MainFrame.Visible then
                MainFrame:TweenSize(UDim2.new(0, 0, 0, 400), "In", "Quad", 0.5, true, function()
                    MainFrame.Visible = false
                end)
            else
                MainFrame.Visible = true
                MainFrame:TweenSize(UDim2.new(0, 600, 0, 400), "Out", "Quad", 0.5, true)
            end
        end
    end)

    -- Tab Creation
    function UILib:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        local TabFrame = Instance.new("Frame")

        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)

        TabFrame.Name = name .. "Frame"
        TabFrame.Parent = MainFrame
        TabFrame.Size = UDim2.new(1, -120, 1, -40)
        TabFrame.Position = UDim2.new(0, 120, 0, 40)
        TabFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabFrame.Visible = false

        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Visible = false
            end
            TabFrame.Visible = true
            CurrentTab = TabFrame
        end)

        table.insert(Tabs, {Button = TabButton, Frame = TabFrame})

        return TabFrame
    end

    return UILib
end
