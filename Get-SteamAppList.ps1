<# 
 .Synopsis
  Returns a list of all games in steam catalog.

 .Description
  Returns a list of all games in the steam catalog including their ID numbers.
 
 .Parameter Force
  Pass this switch if you want to force retrival from the web service. If not passed module will only retrive from web service on the first call.
  
 .Example
  #Returns all steam games
  Get-SteamAppList

 .Example
  #Returns all steam games from web service.
  Get-SteamAppList -Force
#>
function Get-SteamAppList {
    param([switch]$Force)

    if($Script:AppList -ne $null -and $Force -eq $false) {
        return $Script:AppList
    }

    $Script:AppList = @()

    $games = ConvertFrom-Json (Invoke-WebRequest 'http://api.steampowered.com/ISteamApps/GetAppList/v0001/')

    foreach($g in $games.applist.apps.app) {
        $obj = [pscustomobject] @{
            ID = $g.appid
            Name = $g.name
        }

        $Script:AppList += $obj
        $obj
    }
}