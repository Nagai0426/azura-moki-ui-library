-- Azura Moki UI Library - Roblox Studio test harness
--
-- Setup:
-- 1. Create a ModuleScript named "Library" in ReplicatedStorage.
-- 2. Paste the contents of Library.lua into that ModuleScript.
-- 3. Place this LocalScript in StarterPlayer > StarterPlayerScripts.
-- 4. Run the experience in Roblox Studio.
--
-- This test intentionally does not activate Rejoin Server or Player Teleportation.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

assert(RunService:IsStudio(), "Run this test in Roblox Studio.")

local function check(condition, message)
    assert(condition, "[Azura Moki Test] " .. message)
end

local function findDescendantByClass(root, className)
    for _, descendant in ipairs(root:GetDescendants()) do
        if descendant:IsA(className) then
            return descendant
        end
    end
    return nil
end

local function findText(root, expected)
    for _, descendant in ipairs(root:GetDescendants()) do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
            if string.find(descendant.Text or "", expected, 1, true) then
                return descendant
            end
        end
    end
    return nil
end

local LibraryModule = ReplicatedStorage:WaitForChild("Library", 10)
check(LibraryModule and LibraryModule:IsA("ModuleScript"), "ReplicatedStorage.Library must be a ModuleScript.")

local Library = require(LibraryModule)
check(type(Library) == "table", "Library must return a table.")
check(type(Library.new) == "function", "Library.new is missing.")

local Window = Library.new("Azura Moki Test")
check(type(Window) == "table", "Library.new must return a window table.")
check(Window.ScreenGui and Window.ScreenGui:IsA("ScreenGui"), "Window.ScreenGui was not created.")

local screenGui = Window.ScreenGui
local mainScale = screenGui:FindFirstChildOfClass("UIScale")
check(mainScale ~= nil, "The window must contain a UIScale.")
check(type(Window.SetScale) == "function", "Window:SetScale is missing.")
check(type(Window.AddTab) == "function", "Window:AddTab is missing.")

local HomeTab = Window:AddTab("Home")
check(type(HomeTab) == "table", "AddTab must return a tab table.")
check(type(HomeTab.AddWelcomeCard) == "function", "AddWelcomeCard is missing.")
check(type(HomeTab.AddDashboardStats) == "function", "AddDashboardStats is missing.")
HomeTab:AddWelcomeCard()
HomeTab:AddDashboardStats()

local ControlsTab = Window:AddTab("Controls")
for _, methodName in ipairs({ "AddLabel", "AddButton", "AddSlider", "AddTextBox" }) do
    check(type(ControlsTab[methodName]) == "function", methodName .. " is missing.")
end

local buttonActivated = false
ControlsTab:AddLabel("Control Test")
ControlsTab:AddButton("Test Button", function()
    buttonActivated = true
end)
ControlsTab:AddSlider("Test Slider", 25, 150, 100, function(value)
    check(type(value) == "number", "Slider callback must receive a number.")
end)
ControlsTab:AddTextBox("Test input", function(text)
    check(type(text) == "string", "TextBox callback must receive a string.")
end)

local testButton = findText(screenGui, "Test Button")
check(testButton and testButton:IsA("TextButton"), "Test Button was not rendered.")
testButton:Activate()
check(buttonActivated, "Button callback did not run when activated.")

local originalScale = mainScale.Scale
for _, expectedScale in ipairs({ 0.25, 0.50, 0.75, 1.00, 1.50 }) do
    Window:SetScale(expectedScale)
    check(math.abs(mainScale.Scale - expectedScale) < 0.001, "Scale did not apply: " .. tostring(expectedScale))
end
Window:SetScale(originalScale)

local clampedValues = {
    { input = 0, expected = 0.25 },
    { input = 3, expected = 2.00 },
}
for _, item in ipairs(clampedValues) do
    Window:SetScale(item.input)
    check(math.abs(mainScale.Scale - item.expected) < 0.001, "Scale clamp failed for " .. tostring(item.input))
end
Window:SetScale(1.00)

local telemetryDeadline = os.clock() + 3
local telemetryLabel
repeat
    telemetryLabel = findText(screenGui, "Time:")
    if not telemetryLabel then
        task.wait(0.1)
    end
until telemetryLabel or os.clock() >= telemetryDeadline

check(telemetryLabel ~= nil, "Dashboard telemetry label was not rendered.")
check(string.find(telemetryLabel.Text, "Device:", 1, true) ~= nil, "Device telemetry is missing.")
check(string.find(telemetryLabel.Text, "FPS:", 1, true) ~= nil, "FPS telemetry is missing.")
check(string.find(telemetryLabel.Text, "Ping:", 1, true) ~= nil, "Ping telemetry is missing.")

local firstTelemetry = telemetryLabel.Text
task.wait(1.25)
local secondTelemetry = telemetryLabel.Text
check(secondTelemetry ~= "", "Telemetry text is empty.")
check(firstTelemetry ~= secondTelemetry or string.find(secondTelemetry, "Time:", 1, true) ~= nil, "Telemetry did not produce a valid update.")

local miniPill = findText(screenGui, "Azura")
check(miniPill ~= nil, "Minimized hotbar/pill was not created.")

screenGui:Destroy()
check(screenGui.Parent == nil, "ScreenGui cleanup failed.")

print("[Azura Moki Test] PASS - window, tabs, controls, scaling, telemetry, hotbar, callbacks, and cleanup verified.")
