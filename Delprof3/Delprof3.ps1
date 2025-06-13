param (
    [switch]$List,
    [string[]]$Delete
)

$excludedProfiles = @("Default", "Public", $env:USERNAME)
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

function List-Profiles {
    Write-Host "`nProfils utilisateurs trouvés dans C:\Users :"
    Get-ChildItem 'C:\Users\' -Directory | ForEach-Object {
        Write-Host " - $($_.Name) (Dernier accès : $($_.LastWriteTime))"
    }
}

function Delete-Profiles {
    foreach ($profile in $Delete) {
        if ($excludedProfiles -contains $profile) {
            Write-Warning "Le profil '$profile' est protégé et ne sera pas supprimé."
            continue
        }

        $profilePath = "C:\Users\$profile"
        if (Test-Path $profilePath) {
            try {
                Remove-Item -Path $profilePath -Recurse -Force -ErrorAction Stop
                Write-Host "✅ Dossier supprimé : $profilePath"
            } catch {
                Write-Warning "Erreur lors de la suppression du dossier $profilePath : $_"
            }
        } else {
            Write-Warning "Le dossier $profilePath n'existe pas."
        }

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
if ($List) {
    List-Profiles
}

if ($Delete) {
    Delete-Profiles
}

if (-not $List -and -not $Delete) {
    Write-Host "Utilisation :"
    Write-Host " - Pour lister les profils : .\Delprof3.ps1 -List"
    Write-Host " - Pour supprimer des profils : .\Delprof3.ps1 -Delete user1,user2"
}
