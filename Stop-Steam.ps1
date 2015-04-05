<# 
 .Synopsis
  Closes Steam.

 .Description
  Closes the steam client.
  
 .Example
  #Closes the steam client
  Stop-Steam
#>
function Stop-Steam {
    $installPath = ''
    

    if(Test-Path 'HKLM:\SOFTWARE\Valve\Steam') {
        $installPath = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Valve\Steam').InstallPath
    }

    if(Test-Path 'HKLM:\SOFTWARE\Wow6432Node\Valve\Steam') {
        $installPath = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Valve\Steam').InstallPath
    }

    if($installPath -eq '') {
        throw 'Steam no installed!'
    }

    &"$installPath\steam.exe" -shutdown
}