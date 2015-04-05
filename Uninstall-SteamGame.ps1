<# 
 .Synopsis
  Starts uninstall wizard for target steam game.

 .Description
  Starts uninstall wizard for target steam game.
 
 .Parameter Name
  Name of game to uninstall.

 .Parameter Id
  Steam ID of game to uninstall.

 .Example
  #Uninstall Goat Simulator.
  Uninstall-SteamGame -Name "Goat Simulator"

 .Example
  #Uninstall Civ 5 (which has ID of 8930)
  Uninstall-SteamGame -ID 8930
#>
function Uninstall-SteamGame {
    Param($Name, $ID)

    if($Name -ne $null -and $ID -ne $null) {
        throw 'You must specify either ID or Name not both!'
    }

    if($ID -ne $null) {
        Start-Process "steam://uninstall/$ID"
    }

    if($Name -ne $null) {
        if($Script:AppList -eq $null) {
            Get-SteamAppList | Out-Null
        }

        foreach($g in $Script:AppList) {
            if($g.Name -eq $Name) {
                Start-Process "steam://uninstall/$($g.ID)"
            }
        }
    }
}