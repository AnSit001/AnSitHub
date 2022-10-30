local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "An Sit Dz";
            Text = "La Mot Nguoi Rat Dep Trai"})
            

local plr = game:GetService("Players").LocalPlayer
local Notification = require(game:GetService("ReplicatedStorage").Notification)
local Data = plr:WaitForChild("Data")
local EXPFunction = require(game.ReplicatedStorage:WaitForChild("EXPFunction"))
local LevelUp = require(game:GetService("ReplicatedStorage").Effect.Container.LevelUp)
local Sound = require(game:GetService("ReplicatedStorage").Util.Sound)
local LevelUpSound = game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp_Proxy") or game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp")
function v129(p15)
    local v130 = p15;
    while true do
        local v131, v132 = string.gsub(v130, "^(-?%d+)(%d%d%d)", "%1,%2");
        v130 = v131;
        if v132 == 0 then
            break;
        end;    
    end;
    return v130;
end;

Notification.new("<Color=Yellow>Made By An Sit<Color=/>"):Display()
Notification.new("VCL : <Color=Yellow>FB: An Sit<Color=/> (+ None)"):Display()
Notification.new("VCL : <Color=Blue>Discord: AnSit#0650<Color=/>"):Display()
plr.Data.Exp.Value = 9999999999
plr.Data.Beli.Value = plr.Data.Beli.Value + 999999999999

delay = 0
count = 0
while plr.Data.Exp.Value - EXPFunction(Data.Level.Value) > 0 do
    plr.Data.Exp.Value = plr.Data.Exp.Value - EXPFunction(Data.Level.Value)
    plr.Data.Level.Value = plr.Data.Level.Value + 1
    plr.Data.Points.Value = plr.Data.Points.Value + 3
    LevelUp({ plr })
    Sound.Play(Sound, LevelUpSound.Value)
    Notification.new("<Color=Black>An Sit Dz<Color=/> (" .. plr.Data.Level.Value .. ")"):Display()
    count = count + 1
    if count >= 5 then
        delay = tick()
        count = 0
        wait()
    end
end


_G.AimbotEnabled = true
_G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
_G.AimPart = "Head" -- Where the aimbot script would lock at.
_G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

_G.CircleSides = 64 -- How many sides the FOV circle would have.
_G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
_G.CircleTransparency = 0.7 -- Transparency of the circle.
_G.CircleRadius = 80 -- The radius of the circle / FOV.
_G.CircleFilled = false -- Determines whether or not the circle is filled.
_G.CircleVisible = true -- Determines whether or not the circle is visible.
_G.CircleThickness = 0 -- The thickness of the circle.

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

local function GetClosestPlayer()
	local MaximumDistance = _G.CircleRadius
	local Target = nil

	for _, v in next, Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			if _G.TeamCheck == true then
				if v.Team ~= LocalPlayer.Team then
					if v.Character ~= nil then
						if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
								local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
								
								if VectorDistance < MaximumDistance then
									Target = v
								end
							end
						end
					end
				end
			else
				if v.Character ~= nil then
					if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
							local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
							local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
							
							if VectorDistance < MaximumDistance then
								Target = v
							end
						end
					end
				end
			end
		end
	end

	return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    if Holding == true and _G.AimbotEnabled == true then
        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
    end
end)
