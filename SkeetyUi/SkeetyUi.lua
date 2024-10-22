-- UI Library Setup
local UILib = {} -- This would be your UI library setup

function UILib:CreateWindow(title)
    -- Create main window frame with animations
    local Window = {}
    Window.Frame = Instance.new("Frame")
    Window.Frame.Name = title
    Window.Frame.Size = UDim2.new(0, 600, 0, 400)
    Window.Frame.Position = UDim2.new(0.5, -300, 0.5, -200)
    Window.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Window.Frame.BorderSizePixel = 0
    Window.Frame.Visible = false

    -- Dragging functionality
    local dragging
    local dragInput
    local dragStart
    local startPos

    Window.Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Window.Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Window.Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Insert key to toggle visibility
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            Window.Frame.Visible = not Window.Frame.Visible
        end
    end)

    function Window:NewTab(name)
        local Tab = {}
        -- Tab creation code with animations and styling
        -- (Add styling here for a beautiful tab appearance)
        
        Tab.Name = name
        Tab.Button = Instance.new("TextButton")
        Tab.Button.Parent = Window.Frame
        Tab.Button.Text = name
        Tab.Button.Size = UDim2.new(0, 100, 0, 30)
        Tab.Button.Position = UDim2.new(0, 10, 0, 10) -- Example positioning
        Tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)

        function Tab:NewSection(sectionName)
            local Section = {}
            -- Create section with animations and styling
            Section.Frame = Instance.new("Frame")
            Section.Frame.Parent = Window.Frame
            Section.Frame.Size = UDim2.new(0, 200, 0, 100)
            Section.Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Section.Frame.Position = UDim2.new(0, 120, 0, 10) -- Example positioning
            
            function Section:CreateToggle(text, callback)
                local Toggle = Instance.new("TextButton")
                Toggle.Parent = Section.Frame
                Toggle.Text = text
                Toggle.Size = UDim2.new(0, 180, 0, 30)
                Toggle.Position = UDim2.new(0, 10, 0, 10) -- Example positioning
                Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                local toggled = false

                Toggle.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    if toggled then
                        Toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    else
                        Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    end
                    callback(toggled)
                end)
            end
            
            return Section
        end

        return Tab
    end

    return Window
end
