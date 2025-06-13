
param (
    [switch]$List,
    [string[]]$Delete,
    [switch]$Help
)

$excludedProfiles = @("Default", "Public", $env:USERNAME)
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

function Show-Help {
    Write-Host "`nUtilisation :"
    Write-Host " - Pour lister les profils : .\Delprof3.ps1 -List"
    Write-Host " - Pour supprimer des profils : .\Delprof3.ps1 -Delete user1,user2"
    Write-Host " - Pour afficher l'aide : .\Delprof3.ps1 -Help"
}

function List-Profiles {
    Write-Host "`nProfils utilisateurs trouvés dans C:\Users :"
    Get-ChildItem 'C:\Users\' -Directory | ForEach-Object {
        Write-Host " - $($_.Name) (Dernier accès : $($_.LastWriteTime))"
    }
}

function Force-DeleteFolder {
    param([string]$folderPath)

    if (Test-Path $folderPath) {
        try {
            $null = New-Item -ItemType Directory -Path "C:\\Temp\\EmptyFolder" -Force
            robocopy "C:\\Temp\\EmptyFolder" $folderPath /MIR > $null
            Remove-Item $folderPath -Force -Recurse -ErrorAction SilentlyContinue
            Remove-Item "C:\\Temp\\EmptyFolder" -Force -Recurse -ErrorAction SilentlyContinue
            Write-Host "✅ Dossier supprimé : $folderPath"
        } catch {
            Write-Warning "Erreur lors de la suppression du dossier $folderPath : $_"
        }
    } else {
        Write-Warning "Le dossier $folderPath n'existe pas."
    }
}

function Delete-Profiles {
    foreach ($profile in $Delete) {
        if ($excludedProfiles -contains $profile) {
            Write-Warning "Le profil '$profile' est protégé et ne sera pas supprimé."
            continue
        }

        $profilePath = "C:\Users\$profile"
        Force-DeleteFolder -folderPath $profilePath

        try {
            $profileList = Get-ChildItem $regPath
            foreach ($item in $profileList) {
                $profileKey = (Get-ItemProperty -Path "$regPath\$($item.PSChildName)").ProfileImagePath
                if ($profileKey -like "*\$profile") {
                    Remove-Item -Path "$regPath\$($item.PSChildName)" -Force
                    Write-Host "🧹 Clé registre supprimée pour : $profile"
                }
            }
        } catch {
            Write-Warning "Erreur lors de la suppression de la clé registre pour $profile : $_"
        }
    }
}

# Exécution
if ($Help) {
    Show-Help
} elseif ($List) {
    List-Profiles
} elseif ($Delete) {
    Delete-Profiles
} else {
    Show-Help
}
