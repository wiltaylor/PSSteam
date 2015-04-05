<# 
 .Synopsis
  Starts steam game.

 .Description
  Starts steam game with target id or name.
 
 .Parameter Name
  Name of game to start.

 .Parameter Id
  Steam ID of game to start.

 .Example
  #Starts Goat Simulator.
  Start-SteamGame -Name "Goat Simulator"

 .Example
  #Starts Civ 5 (which has ID of 8930)
  Start-SteamGame -ID 8930
#>
function Start-SteamGame {
    param($Name, $ID)

    if($Name -ne $null -and $ID -ne $null) {
        throw 'You must specify either ID or Name not both!'
    }

    if($ID -ne $null) {
        Start-Process "steam://run/$ID"
    }

    if($Name -ne $null) {
        if($Script:AppList -eq $null) {
            Get-SteamAppList | Out-Null
        }

        foreach($g in $Script:AppList) {
            if($g.Name -eq $Name) {
                Start-Process "steam://run/$($g.ID)"
            }
        }
    }
}