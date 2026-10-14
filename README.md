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

You can load the library in your Roblox script using a hosted `loadstring`:

```lua
local Library = loadstring(game:HttpGet("https://rbx-loadsrtibg.netlify.app/raw/Eey6gyiO"))()

local Window = Library.new("Azura Moki Hub")

local HomeTab = Window:AddTab("Home")
HomeTab:AddWelcomeCard()
HomeTab:AddDashboardStats()

local ScriptsTab = Window:AddTab("Scripts")
ScriptsTab:AddUsableScripts()

local SettingsTab = Window:AddTab("Settings")
SettingsTab:AddButton("Scale 100%", function()
    Window:SetScale(1.00)
end)
```

### GitHub Raw Loadstring

After `Library.lua` has been added to the `main` branch, you can load the file directly from GitHub with:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nagai0426/azura-moki-ui-library/main/Library.lua"))()
```

> The GitHub raw loadstring will work once `Library.lua` is committed to the repository.

## Repository

This is the public GitHub repository for the project:

- https://github.com/Nagai0426/azura-moki-ui-library

## License

Azura Moki UI Library is released under the [MIT License](LICENSE). Anyone may use, modify, publish, and distribute the library in accordance with the license terms.

## Upload Plan

To add the library source to GitHub:

1. Sign in to your official GitHub account.
2. Open the [Azura Moki UI Library repository](https://github.com/Nagai0426/azura-moki-ui-library).
3. Upload `Library.lua` to the repository.
4. Review the changes and use a commit message such as `Initial release of Azura Moki Library`.
5. Commit the changes to the `main` branch.

The repository is already public, so the library and its documentation can be viewed by anyone.
