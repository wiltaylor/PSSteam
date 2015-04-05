$Global:SysinternalsFolder = "$PSScriptRoot\SysinternalsSuite"

.  $PSScriptRoot\Get-SteamGame.ps1
.  $PSScriptRoot\Get-SteamAppList.ps1
.  $PSScriptRoot\Stop-Steam.ps1
.  $PSScriptRoot\Install-SteamGame.ps1
.  $PSScriptRoot\Start-SteamGame.ps1
.  $PSScriptRoot\Start-Steam.ps1
.  $PSScriptRoot\Uninstall-SteamGame.ps1

Export-ModuleMember Get-SteamGame
Export-ModuleMember Get-SteamAppList
Export-ModuleMember Stop-Steam
Export-ModuleMember Install-SteamGame
Export-ModuleMember Start-SteamGame
Export-ModuleMember Start-Steam
Export-ModuleMember Uninstall-SteamGame