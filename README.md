# Azura Moki UI Library

## Overview

Azura Moki is a professional, lightweight, and modern Luau UI library inspired by iOS aesthetics and Raifu-style navigation for Roblox developers. It features a glassmorphic design, real-time telemetry, and useful tools for players.

## Key Features

- Modern glassmorphism design with a top navigation category system.
- Android-style dynamic hotbar when the window is minimized.
- Personalized welcome card with the Roblox avatar thumbnail and username.
- Real-time system telemetry, including timer, device detection, battery status, FPS, ping, and server ID.
- Useful scripts such as Rejoin Server, Player Teleportation, and User ID Copier.
- Dynamic scaling settings for resizing the interface.

## Usage Example

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nagai0426/azura-moki-ui-library/main/Library.lua"))()

local Window = Library.new("Azura Moki Hub")

local HomeTab = Window:AddTab("Home")
HomeTab:AddWelcomeCard()
HomeTab:AddDashboardStats()

local ScriptsTab = Window:AddTab("Scripts")
ScriptsTab:AddLabel("Player & Server Tools")
ScriptsTab:AddUsableScripts()

local SettingsTab = Window:AddTab("Settings")
SettingsTab:AddLabel("GUI Scale Settings")
SettingsTab:AddButton("Scale 25% (Small)", function() Window:SetScale(0.25) end)
SettingsTab:AddButton("Scale 50% (Medium)", function() Window:SetScale(0.50) end)
SettingsTab:AddButton("Scale 75% (Large)", function() Window:SetScale(0.75) end)
SettingsTab:AddButton("Scale 100% (Normal)", function() Window:SetScale(1.00) end)

SettingsTab:AddSlider("Custom Scale %", 25, 150, 100, function(value)
    Window:SetScale(value / 100)
end)

SettingsTab:AddLabel("Interface Control")
SettingsTab:AddButton("Destroy UI", function()
    if Window.ScreenGui then
        Window.ScreenGui:Destroy()
    end
end)
```

### GitHub Raw Loadstring

Load the library directly from the public `main` branch with:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nagai0426/azura-moki-ui-library/main/Library.lua"))()
```

> This URL points to the published `Library.lua` file in this repository.

## Creating Custom Tabs and Buttons

Create a custom tab with `Window:AddTab("Tab Name")`. The method returns a tab object where you can add controls in the order they should appear.

### Custom tab with buttons

```lua
local ToolsTab = Window:AddTab("Tools")

ToolsTab:AddLabel("My Custom Actions")

ToolsTab:AddButton("Print Greeting", function()
    print("Hello from Azura Moki!")
end)

ToolsTab:AddButton("Set Normal Scale", function()
    Window:SetScale(1.00)
end)
```

`AddButton(text, callback)` creates a button and runs the callback when the player activates it. Keep the callback focused on one action, and wrap optional or external operations in `pcall` when appropriate.

### Other controls on a custom tab

```lua
local CustomTab = Window:AddTab("Custom")

CustomTab:AddLabel("Player Preferences")

CustomTab:AddSlider("Transparency", 0, 100, 25, function(value)
    print("Selected transparency:", value)
end)

CustomTab:AddTextBox("Enter a note", function(text)
    print("Player note:", text)
end)
```

Available tab methods are:

- `AddLabel(text)` — adds a section label.
- `AddButton(text, callback)` — adds a clickable button.
- `AddSlider(text, minimum, maximum, default, callback)` — adds a numeric slider.
- `AddTextBox(placeholder, callback)` — calls the callback when the player submits text.
- `AddWelcomeCard()` — adds the personalized welcome card.
- `AddDashboardStats()` — adds the live time, device, battery, FPS, and ping display.
- `AddUsableScripts()` — adds the built-in server and player utility controls.

### Recommended structure

```lua
local Window = Library.new("My Roblox Tool")

local MainTab = Window:AddTab("Main")
MainTab:AddLabel("Main Actions")
MainTab:AddButton("Run Action", function()
    print("Action triggered")
end)

local SettingsTab = Window:AddTab("Settings")
SettingsTab:AddButton("Small UI", function()
    Window:SetScale(0.75)
end)
```

The first tab is displayed automatically. Additional tabs appear in the top navigation bar, and the player can select them at runtime.

## Theme Customization

Azura Moki includes built-in `Dark` and `Light` themes. Apply a preset after creating the window:

```lua
Window:SetTheme("Light")

local themeName, palette = Window:GetTheme()
print("Active theme:", themeName)
```

You can also provide a partial custom palette. Unspecified tokens keep their current values:

```lua
Window:SetTheme({
    Accent = Color3.fromRGB(120, 80, 255),
    AccentText = Color3.fromRGB(255, 255, 255),
})
```

Supported semantic tokens include `Window`, `Surface`, `SurfaceAlt`, `Input`, `Text`, `MutedText`, `Border`, `Accent`, `AccentText`, `Track`, `Destructive`, and `Warning`. Theme changes update the library elements that are bound to these tokens and `SetTheme` returns the window for chaining.

## Repository

This is the public GitHub repository for the project:

- https://github.com/Nagai0426/azura-moki-ui-library

## License

Azura Moki UI Library is released under the [MIT License](LICENSE). Anyone may use, modify, publish, and distribute the library in accordance with the license terms.

The repository is already public, so the library and its documentation can be viewed by anyone.
