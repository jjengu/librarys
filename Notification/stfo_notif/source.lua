local LastInteration = 0
local TweenService = game:GetService("TweenService")

if not game:GetService("CoreGui"):FindFirstChild("NotifsUI") then
    local NotificationsGUI = Instance.new("ScreenGui")
    NotificationsGUI.Parent = game:GetService("CoreGui")
    NotificationsGUI.Name = "NotifsUI"

    local Notifications = Instance.new("Frame")
    Notifications.Name = "Notifications"
    Notifications.Position = UDim2.new(0.5, 0, 0.2, 0)
    Notifications.Size = UDim2.new(1, 0, 0.2, 0)
    Notifications.BackgroundColor3 = Color3.new(1, 1, 1)
    Notifications.BackgroundTransparency = 1
    Notifications.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
    Notifications.AnchorPoint = Vector2.new(0.5, 1)
    Notifications.Transparency = 1
    Notifications.Parent = NotificationsGUI

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "UIListLayout"
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Notifications

    local Notification_Example = Instance.new("TextLabel")
    Notification_Example.Name = "Notification_Template"
    Notification_Example.Size = UDim2.new(0, 200, 0, 30)
    Notification_Example.BackgroundColor3 = Color3.new(0.866667, 0.764706, 0.188235)
    Notification_Example.BackgroundTransparency = 1
    Notification_Example.BorderSizePixel = 0
    Notification_Example.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
    Notification_Example.Transparency = 1
    Notification_Example.Text = "you earned 50 XP"
    Notification_Example.TextColor3 = Color3.new(1, 1, 1)
    Notification_Example.TextSize = 16
    Notification_Example.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    Notification_Example.TextWrapped = true
    Notification_Example.Parent = game:GetService("CoreGui")

    local UICorner = Instance.new("UICorner")
    UICorner.Name = "UICorner"
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Notification_Example
end

local Notify = function(settings)
    settings = settings or {}

    local message = settings.Message or "Notification"
    local CurrentTime = tick()
    --if CurrentTime - LastInteration >= 1 then
        LastInteration = CurrentTime

        local NTemplate = game:GetService("CoreGui"):FindFirstChild("Notification_Template"):Clone()
        local Font = settings.TextFont or Enum.Font.SourceSansBold
        local TextSize = game:GetService("TextService"):GetTextSize(message, 16, Font, Vector2.new(1000), 30)
        local NotifSize = UDim2.fromOffset(TextSize.X + 30, 30)

        NTemplate.Font = Font
        NTemplate.Text = message
        NTemplate.Size = UDim2.fromOffset(NotifSize.X.Offset, 0)
        NTemplate.TextStrokeTransparency = 1

        local BackgroundColor
        if typeof(settings.BackgroundColor) == "Color3" then
            BackgroundColor = settings.BackgroundColor
        else
            local Colors = {
                gold = Color3.fromRGB(255, 189, 56),
                red = Color3.fromRGB(255, 79, 79),
                green = Color3.fromRGB(143, 255, 112),
                orange = Color3.fromRGB(255, 160, 82)
            }
            BackgroundColor = Colors[settings.BackgroundColor] or Color3.fromRGB(212,255,234)
        end
        NTemplate.BackgroundColor3 = BackgroundColor

        if typeof(settings.TextColor) == "Color3" then
            NTemplate.TextColor3 = settings.TextColor
        else
            NTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        TweenService:Create(NTemplate, TweenInfo.new(0.35), {
            Size = NotifSize,
            TextTransparency = 0,
            TextStrokeTransparency = 0.8,
            BackgroundTransparency = 0
        }):Play()

        NTemplate.Parent = game:GetService("CoreGui"):FindFirstChild("NotifsUI").Notifications

        task.delay(settings.Duration or 5, function()
            TweenService:Create(NTemplate, TweenInfo.new(1), {
                TextTransparency = 1,
                TextStrokeTransparency = 1,
                BackgroundTransparency = 1
            }):Play()

            task.wait(1)
            NTemplate:Destroy()
        end)
   -- end
end

return Notify
