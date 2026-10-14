# Azura Moki UI Library — Developer Presentation Script

## Presentation goal

Show Roblox developers how Azura Moki provides a modern interface foundation, how quickly a window can be assembled, and how to extend it with custom tabs and controls.

## Suggested length

Approximately 5–7 minutes.

## Opening — 30 seconds

“Hello everyone. Today I’m introducing Azura Moki UI Library, a lightweight Luau UI library for Roblox developers. It provides a modern glassmorphic interface, tab-based navigation, real-time player and session telemetry, scaling controls, and reusable utility components.”

“Instead of rebuilding the same window, tab, button, and telemetry code for every project, we can load the library once and focus on the experience we want to build.”

## Show the repository — 30 seconds

Open the public repository:

https://github.com/Nagai0426/azura-moki-ui-library

Say:

“The project is public and released under the MIT License. The source is available in `Library.lua`, and the README contains copy-ready usage examples.”

## Load and initialize — 45 seconds

Show this code:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nagai0426/azura-moki-ui-library/main/Library.lua"))()
local Window = Library.new("Azura Moki Hub")
```

Say:

“The first line loads the published library from GitHub. The second line creates a window. From this point, the UI is assembled with readable method calls.”

## Demonstrate the built-in tabs — 60 seconds

Show this code:

```lua
local HomeTab = Window:AddTab("Home")
HomeTab:AddWelcomeCard()
HomeTab:AddDashboardStats()

local ScriptsTab = Window:AddTab("Scripts")
ScriptsTab:AddLabel("Player & Server Tools")
ScriptsTab:AddUsableScripts()
```

Say:

“The Home tab can display a personalized welcome card and dashboard telemetry. The Scripts tab demonstrates reusable controls such as rejoining a server, searching for players, teleporting to a matching player, and copying a User ID. Use these tools responsibly and only in experiences where they are appropriate.”

## Demonstrate custom tabs and controls — 90 seconds

Show this code:

```lua
local SettingsTab = Window:AddTab("Settings")
SettingsTab:AddLabel("GUI Scale Settings")

SettingsTab:AddButton("Scale 50%", function()
    Window:SetScale(0.50)
end)

SettingsTab:AddSlider("Custom Scale %", 25, 150, 100, function(value)
    Window:SetScale(value / 100)
end)

SettingsTab:AddTextBox("Enter a message", function(text)
    print("Developer input:", text)
end)
```

Say:

“Custom tabs are created with `Window:AddTab`. A tab can contain labels, buttons, sliders, and text boxes. Each control accepts a callback, so your game logic stays separate from the visual layout.”

“Buttons are useful for one-step actions. Sliders are useful for numeric settings such as scale, volume, or sensitivity. Text boxes are useful when developers need player input.”

## Demonstrate scaling and cleanup — 45 seconds

Show this code:

```lua
SettingsTab:AddButton("Scale 100%", function()
    Window:SetScale(1.00)
end)

SettingsTab:AddButton("Destroy UI", function()
    if Window.ScreenGui then
        Window.ScreenGui:Destroy()
    end
end)
```

Say:

“The scale API clamps values to a safe range, and the UI can be destroyed cleanly when the experience changes state or the player closes a custom menu.”

## Live verification — 45 seconds

Run `tests/LibraryTest.client.lua` in Roblox Studio after placing the library in `ReplicatedStorage` as a `ModuleScript` named `Library`.

Say:

“The included Studio test harness checks that the window is created, every supported control can be added, scale values are applied, telemetry labels appear, telemetry updates, callbacks execute, and the UI can be cleaned up.”

## Closing — 30 seconds

“Azura Moki is designed to be a practical starting point for Roblox interfaces: load it, create a window, add the tabs your project needs, and connect the controls to your own game systems. The repository is public, the documentation is included, and contributions or improvements can be built on top of the MIT-licensed source.”
