<# 
 .Synopsis
  Starts steam client.

 .Description
  Starts steam client.
 
 .Parameter Console
  Starts steam with the steam console open.

 .Parameter DevMode
  Enables Developer Mode in steam (accessable via F6 and F7).

 .Parameter Silent
  Supresses popup dialogues that run at startup on steam.

 .Example
  Start-Steam

 .Example
  Start-Steam -Console -DevMode -Silent
#>
function Start-Steam {
    param([switch]$Console, [switch]$DevMode, [switch]$Silent) 

    $installPath = ''

    if(Test-Path 'HKLM:\SOFTWARE\Valve\Steam') {
        $installPath = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Valve\Steam').InstallPath
    }

    if(Test-Path 'HKLM:\SOFTWARE\Wow6432Node\Valve\Steam') {
        $installPath = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Valve\Steam').InstallPath
    }

    if($installPath -eq '') { throw "Can't find steam installed on this machine"}

    $command = "&`"$installPath\steam.exe`""

    if($Console) { $command += ' -console' }
    if($DevMode) { $command += ' -developer' }
    if($Silent) { $command += ' -silent' }

    Invoke-Expression $command
}