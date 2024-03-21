# Delprof3

A PowerShell utility designed to help administrators and users manage user profiles on Windows systems. This script lists all user profiles along with their last used dates, enables the selection of profiles to preserve, and facilitates the deletion of the remaining profiles, including their associated registry keys.

## Features

- **List User Profiles:** Quickly view all user profiles and their last accessed dates.
- **Interactive Selection:** Interactively select which profiles to keep, with defaults for essential system profiles such as Public, Default, and the profile you are currently signed in upon the computer at the time of running the script.
- **Safe Cleanup:** Automatically exclude current, default, and public profiles from deletion to prevent accidental system damage.
- **Registry Cleanup:** Cleans up leftover registry keys associated with deleted profiles to ensure a clean system state.

## Getting Started

To use ProfileCleanerPS, follow these steps:
1. **Download the repository**
2. **Navigate to the folder:** Once at the folder simply double click "runThis.bat"
3. **Select Profiles to Keep:** Follow the interactive prompts to select any additional profiles you wish to keep.
4. **Completion:** The script will remove unselected profiles and their registry keys, then list the remaining profiles.
