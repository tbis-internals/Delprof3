# Ask the user for profiles to keep
$profilesToKeep = @("Default", $env:USERNAME)  # Always keep the "Default" profile and the current user's profile
do {
    $profile = Read-Host -Prompt "Type the name of any profile you want to keep. Default, and profile you are currently signed in on will automatically be excluded from the deletion list. Press 'r' when ready"
    if ($profile -ne 'r') {
        $profilesToKeep += $profile
    }
} while ($profile -ne 'r')

# List all profiles in C:\Users\
$allProfiles = Get-ChildItem 'C:\Users\' -Directory | Select-Object -ExpandProperty Name

# Identify profiles to delete
$profilesToDelete = $allProfiles | Where-Object { $profilesToKeep -notcontains $_ }

# Delete the identified profiles and their registry keys
foreach ($profile in $profilesToDelete) {
    # Construct the profile path
    $profilePath = "C:\Users\$profile"

    # Delete the profile folder
    Remove-Item -Path $profilePath -Recurse -Force

    # Find and delete the registry key associated with the profile
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
    $profileList = Get-ChildItem $regPath

    foreach ($item in $profileList) {
        $profileKey = (Get-ItemProperty -Path "$regPath\$($item.PSChildName)").ProfileImagePath
        if ($profileKey -like "*\$profile") {
            Remove-Item -Path "$regPath\$($item.PSChildName)" -Force
        }
    }
}

# Completion message
Write-Host "Profiles deletion process is complete."
