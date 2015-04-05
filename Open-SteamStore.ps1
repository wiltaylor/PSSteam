function Open-SteamStore {
    param($Name, $ID)

    if($Name -ne $null -and $ID -ne $null) {
        throw 'You must specify either ID or Name not both!'
    }

    if($ID -ne $null) {
        Start-Process "steam://advertise/$ID"
    }

    if($Name -ne $null) {
        if($Script:AppList -eq $null) {
            Get-SteamAppList | Out-Null
        }

        foreach($g in $Script:AppList) {
            if($g.Name -eq $Name) {
                Start-Process "steam://advertise/$($g.ID)"
            }
        }
    }
}