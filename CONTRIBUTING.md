# Contributing to Azura Moki UI Library

Thank you for helping improve Azura Moki. Contributions from Roblox and Luau developers are welcome.

## Before you start

- Read the [Code of Conduct](CODE_OF_CONDUCT.md).
- Search existing issues and pull requests before opening a new one.
- Keep changes focused and explain why the change is useful to Roblox developers.
- Do not include private player data, credentials, exploit-only dependencies, or assets you do not have permission to distribute.

## Development setup

1. Clone the repository.
2. Open `Library.lua` in a Luau-aware editor.
3. Create a `ModuleScript` named `Library` in `ReplicatedStorage` in a Roblox Studio test place.
4. Paste or sync `Library.lua` into the module.
5. Run `tests/LibraryTest.client.lua` from `StarterPlayer > StarterPlayerScripts`.
6. Verify the Output window reports a passing test before opening a pull request.

## Making changes

- Preserve the public API unless the change is intentionally breaking.
- Document new methods and update the README usage examples.
- For UI changes, test both `Dark` and `Light` themes.
- Keep theme colors routed through the library theme tokens instead of scattering new hard-coded colors.
- Avoid activating rejoin or teleport utilities in automated tests.
- Include a short manual testing checklist in the pull request description.

## Pull requests

Use a descriptive title, such as:

- `Add light theme support`
- `Fix slider callback behavior`
- `Improve telemetry documentation`

Include:

- What changed and why.
- Roblox Studio version or test environment used.
- Screenshots or a short recording for visual changes.
- Test results and any known limitations.

A maintainer may request revisions before merging. Please keep review discussions constructive and focused on the code.

## Issues and feature requests

Report reproducible bugs with:

- Steps to reproduce.
- Expected behavior.
- Actual behavior.
- Relevant Roblox Studio output.
- A minimal reproduction when possible.

Feature requests should describe the developer problem they solve rather than only proposing an implementation.

## License

By contributing, you agree that your contribution may be distributed under the repository's [MIT License](LICENSE).
