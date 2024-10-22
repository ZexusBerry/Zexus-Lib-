-- UI Library
local UILib = {}

function UILib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleBar = Instance.new("TextLabel")
    local TabContainer = Instance.new("Frame")
    local ToggleButton = Instance.new("TextButton")

    ScreenGui.Name = "CustomMenu"
    ScreenGui.Parent = game.CoreGui

    -- Main Frame Properties
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Visible = true
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- Title Bar Properties
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Text = title
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.TextScaled = true

    -- Tab Container Properties
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabContainer.Size = UDim2.new(0, 100, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)

    -- Toggle Button Properties
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ScreenGui
    ToggleButton.Size = UDim2.new(0, 100, 0, 40)
    ToggleButton.Position = UDim2.new(0.5, -50, 1, -50)
    ToggleButton.Text = "Show/Hide Menu"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Toggle Menu with Insert key
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- Tabs Table
    local Tabs = {}

    function UILib:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        local TabFrame = Instance.new("Frame")

        -- Tab Button Properties
        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)

        -- Tab Frame Properties
        TabFrame.Name = name .. "Frame"
        TabFrame.Parent = MainFrame
        TabFrame.Size = UDim2.new(1, -100, 1, -40)
        TabFrame.Position = UDim2.new(0, 100, 0, 40)
        TabFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabFrame.Visible = false

        -- Tab Switching Logic
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Tabs) do
                tab.Frame.Visible = false
            end
            TabFrame.Visible = true
        end)

        table.insert(Tabs, {Button = TabButton, Frame = TabFrame})

        return TabFrame
    end

    return UILib
end
