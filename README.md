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
-- Load your Azura Moki Library from GitHub
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nagai0426/azura-moki-ui-library/main/Library.lua"))()

-- Initialize Window
local Window = Library.new("Azura Moki Hub")

-- Home / Welcome Tab
local HomeTab = Window:AddTab("Home")
HomeTab:AddWelcomeCard()
HomeTab:AddDashboardStats()

-- Scripts / Utilities Tab
local ScriptsTab = Window:AddTab("Scripts")
ScriptsTab:AddLabel("Player & Server Tools")
ScriptsTab:AddUsableScripts()

-- Settings Tab
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

## Repository

This is the public GitHub repository for the project:

- https://github.com/Nagai0426/azura-moki-ui-library

## License

Azura Moki UI Library is released under the [MIT License](LICENSE). Anyone may use, modify, publish, and distribute the library in accordance with the license terms.

The repository is already public, so the library and its documentation can be viewed by anyone.
