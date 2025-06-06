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

local Notify = function(message, settings)
	local CurrentTime = tick()
	if CurrentTime - LastInteration >= 1 then
		settings = settings or {}
		local NTemplate = game:GetService("CoreGui"):FindFirstChild("Notification_Template"):Clone()
		local Font = settings.Font or Enum.Font.SourceSansBold
		local TextSize = game:GetService("TextService"):GetTextSize(message, 16, Font, Vector2.new(1000), 30)
		local NotifSize = UDim2.fromOffset(TextSize.X + 30, 30)

		NTemplate.Font = Font
		NTemplate.Text = message
		NTemplate.Size = UDim2.fromOffset(NotifSize.X.Offset, 30)
		NTemplate.TextColor3 = Color3.new(1, 1, 1)
		NTemplate.TextStrokeTransparency = 1

		local Colors = {
			red = Color3.fromRGB(255, 0, 0),
			orange = Color3.fromRGB(255, 165, 0),
			yellow = Color3.fromRGB(255, 255, 0),
			green = Color3.fromRGB(0, 128, 0),
			blue = Color3.fromRGB(0, 0, 255),
			indigo = Color3.fromRGB(75, 0, 130),
			violet = Color3.fromRGB(138, 43, 226),

			black = Color3.fromRGB(0, 0, 0),
			white = Color3.fromRGB(255, 255, 255),
			gray = Color3.fromRGB(128, 128, 128),
			brown = Color3.fromRGB(139, 69, 19),
			pink = Color3.fromRGB(255, 105, 180),
			magenta = Color3.fromRGB(255, 0, 255),
			cyan = Color3.fromRGB(0, 255, 255),
			turquoise = Color3.fromRGB(64, 224, 208),
			lime = Color3.fromRGB(191, 255, 0),
			gold = Color3.fromRGB(255, 189, 56),
			silver = Color3.fromRGB(192, 192, 192),
			peach = Color3.fromRGB(255, 218, 185),

			light_blue = Color3.fromRGB(173, 216, 230),
			dark_green = Color3.fromRGB(0, 100, 0),
			light_green = Color3.fromRGB(144, 238, 144),
			dark_blue = Color3.fromRGB(0, 0, 139),
			light_pink = Color3.fromRGB(255, 182, 193),
			dark_red = Color3.fromRGB(139, 0, 0),
			light_yellow = Color3.fromRGB(255, 255, 224),
			dark_gray = Color3.fromRGB(64, 64, 64),

			pastel_red = Color3.fromRGB(255, 105, 97),
			pastel_orange = Color3.fromRGB(255, 179, 71),
			pastel_yellow = Color3.fromRGB(253, 253, 150),
			pastel_green = Color3.fromRGB(119, 221, 119),
			pastel_blue = Color3.fromRGB(174, 198, 207),
			pastel_indigo = Color3.fromRGB(178, 190, 181),
			pastel_violet = Color3.fromRGB(203, 153, 201),
			pastel_pink = Color3.fromRGB(255, 209, 220),
			pastel_cyan = Color3.fromRGB(175, 238, 238),
			pastel_lime = Color3.fromRGB(204, 255, 204),
			pastel_peach = Color3.fromRGB(255, 218, 185)
		}

		local BackgroundColor

		if typeof(settings.Color) == "Color3" then
			BackgroundColor = settings.Color
		else
			BackgroundColor = Colors[settings.Color] or Color3.fromRGB(143, 255, 112)
		end

		NTemplate.BackgroundColor3 = BackgroundColor

		TweenService:Create(NTemplate, TweenInfo.new(0.35), {
			Size = NotifSize,
			TextTransparency = 0,
			TextStrokeTransparency = 0.8,
			BackgroundTransparency = 0
		}):Play()

		NTemplate.Parent = game:GetService("CoreGui"):FindFirstChild("NotifsUI").Notifications

		task.delay(settings.Time or 5, function()
			TweenService:Create(NTemplate, TweenInfo.new(1), {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
				BackgroundTransparency = 1
			}):Play()

			task.wait(1)
			NTemplate:Destroy()
		end)
	end
end

return Notify
