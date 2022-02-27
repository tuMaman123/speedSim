-- ui
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("⚡ Speed Simulator", "Ocean")

local FT = Window:NewTab("Farming")
local FS = FT:NewSection("Farms")

FS:NewToggle("Toggle Orb Farm", "Toggles the auto orb farm", function(state)
    if state then
        orbFarming = true
    else
        orbFarming = false
    end
end)

local misc = Window:NewTab("Misc.")
local miscSec = misc:NewSection("Misc.")
miscSec:NewToggle("Auto Click", "Toggles the auto clicker", function(state)
    if state then
        autoClicking = true
    else
        autoClicking = false
    end
end)
miscSec:NewToggle("Auto Rebirth", "Toggles the auto rebirth", function(state)
    if state and game.Players.LocalPlayer then
        autoRebirth = true
    else
        autoRebirth = false
    end
end)

local KT = Window:NewTab("Keybinds")
local KS = KT:NewSection("Binds")
KS:NewKeybind("Toggle UI", "Toggles the UI", Enum.KeyCode.LeftAlt, function()
	Library:ToggleUI()
end)


-- functions
function GetTime(Distance, Speed)
	-- Time = Distance / Speed
	local Time = Distance / Speed
	return Time
end

-- actual script
local lp = game.Players.LocalPlayer
local TS = game:GetService("TweenService")
game.SoundService.LevelUp.Volume = 0
game.SoundService.auraLoop.Volume = 0
game.SoundService.auraStart.Volume = 0
local orbFunction = coroutine.wrap(function()
    while wait() do
      if orbFarming == true then
            for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                lp.Character.HumanoidRootPart.Anchored = false
                if orbFarming == true and v.Name == "Base" and lp.Character.Humanoid.Health > 0 then
                    lp.Character.HumanoidRootPart.CFrame = v.CFrame
                    lp.Character.Humanoid.Jump = true
                    wait(.05)
                else
                    lp.Character.HumanoidRootPart.CFrame = CFrame.new(-288.310913, 9.33322334, -3325.75366)
                end
            end
            wait(1)
        end
    end
end)

local autoClickFunction = coroutine.wrap(function()
    while wait() do
        if autoClicking == true then
            game.Players.LocalPlayer.PlayerGui.strengthGui.treadmillImageSpawner.gemSound.Volume = 0
            game:GetService("ReplicatedStorage").Events.clickRE:FireServer()
        end
    end
end)

local autoRebirthFunction = coroutine.wrap(function()
    while wait() do
        if autoRebirth == true then
            game:GetService("ReplicatedStorage").Networking.Rebirth:FireServer()
        end
    end
end)

autoRebirthFunction()
autoClickFunction()
orbFunction()
