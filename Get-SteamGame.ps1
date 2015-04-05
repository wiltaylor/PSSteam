<# 
 .Synopsis
  Gets installed steam games.

 .Description
  Gets a list of installed steam games along with information harvested from manifest files.
 
 .Parameter Name
  Name of game to return.

 .Parameter Id
  Steam ID of game to return.
  
 .Example
  #Returns all installed games.
  Get-SteamGame

 .Example
  #Return goat similator only
  Get-SteamGame -Name "Goat Simulator"

 .Example
  #Return Civ 5 (which has ID of 8930)
  Get-SteamGame -ID 8930
#>
function Get-SteamGame {
    param($Id, $Name) 

    $installPath = ''
    $LibraryFolders = @()
    

    if(Test-Path 'HKLM:\SOFTWARE\Valve\Steam') {
        $installPath = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Valve\Steam').InstallPath
    }

    if(Test-Path 'HKLM:\SOFTWARE\Wow6432Node\Valve\Steam') {
        $installPath = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Valve\Steam').InstallPath
    }

    if($installPath -eq '') { throw "Can't find steam installed on this machine"}

    $LibraryFolders += "$installPath\SteamApps"

    if(Test-Path "$installPath\SteamApps\libraryfolders.vdf") {
        $filedata = Get-Content "$installPath\SteamApps\libraryfolders.vdf"

        foreach($line in $filedata) {
            if($line -match '"[0-9]{1,2}".*"(.*)"') {
                $LibraryFolders += "$($Matches[1])\SteamApps" -replace '\\\\', '\'
            }
        }
    }

    foreach($lib in $LibraryFolders) {
        $manifests = Get-ChildItem -Path $lib -File -Filter '*.acf'

        foreach($man in $manifests) {
            $filedata = Get-Content $man.FullName

            $obj = [pscustomobject] @{
                ID = $null
                Universe = $null
                Name = $null
                StateFlags = $null
                InstallDir = $null
                LastUpdate = $null
                UpdateResult = $null
                SizeOnDisk = $null
                buildid = $null
                LastOwner = $null
                BytesToDownload = $null
                BytesDownloaded = $null
                AutoUpdateBehavior = $null
                AllowOtherDownloadsWhileRunning = $null
            }

            foreach($line in $filedata)
            {
                if($line -match '"appId".*"([0-9]{1,20})"') {
                    $obj.ID = $Matches[1]
                }

                if($line -match '"StateFlags".*"([0-9]{1,20})"') {
                    $obj.StateFlags = $Matches[1]
                }

                if($line -match '"Universe".*"([0-9]{1,20})"') {
                    $obj.Universe = $Matches[1]
                }

                if($line -match '"AutoUpdateBehavior".*"([0-9]{1,20})"') {
                    $obj.AutoUpdateBehavior = $Matches[1]
                }

                if($line -match '"AllowOtherDownloadsWhileRunning".*"([0-9]{1,20})"') {
                    $obj.AllowOtherDownloadsWhileRunning = $Matches[1]
                }

                if($line -match '"buildid".*"([0-9]{1,20})"') {
                    $obj.buildid = $Matches[1]
                }

                if($line -match '"LastOwner".*"([0-9]{1,20})"') {
                    $obj.LastOwner = $Matches[1]
                }

                if($line -match '"SizeOnDisk".*"([0-9]{1,20})"') {
                    $obj.SizeOnDisk = $Matches[1]
                }

                if($line -match '"BytesToDownload".*"([0-9]{1,20})"') {
                    $obj.BytesToDownload = $Matches[1]
                }

                if($line -match '"BytesDownloaded".*"([0-9]{1,20})"') {
                    $obj.BytesDownloaded = $Matches[1]
                }

                if($line -match '"UpdateResult".*"([0-9]{1,20})"') {
                    $obj.UpdateResult = $Matches[1]
                }

                if($line -match '"Name".*"(.*)"') {
                    $obj.Name = $Matches[1]
                }

                if($line -match '"installdir".*"(.*)"') {
                    $obj.InstallDir = "$lib\common\$($Matches[1])"
                }

                if($line -match '"LastUpdated".*"(.*)"') {
                    $obj.LastUpdate = [datetime]::FromFileTime($Matches[1])
                }

                

            }

            if($Id -ne $null) { if($Id -ne $obj.ID) { continue }}
            if($Name -ne $null) { if($Name -ne $obj.Name) { continue }}

            $obj
        }
    }

}