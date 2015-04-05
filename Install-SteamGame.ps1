<# 
 .Synopsis
  Starts steam installation wizard.

 .Description
  Starts steam installation wizard.
 
 .Parameter Name
  Name of game to install.

 .Parameter Id
  Steam ID of game to install.

 .Example
  #Installs Goat Simulator.
  Install-SteamGame -Name "Goat Simulator"

 .Example
  #Installs Civ 5 (which has ID of 8930)
  Install-SteamGame -ID 8930
#>
function Install-SteamGame {
    Param($Name, $ID)

    if($Name -ne $null -and $ID -ne $null) {
        throw 'You must specify either ID or Name not both!'
    }

    if($ID -ne $null) {
        Start-Process "steam://install/$ID"
    }

    if($Name -ne $null) {
        if($Script:AppList -eq $null) {
            Get-SteamAppList | Out-Null
        }

        foreach($g in $Script:AppList) {
            if($g.Name -eq $Name) {
                Start-Process "steam://install/$($g.ID)"
            }
        }
    }
}