$source = 'C:\source' 

If (!(Test-Path -Path $source -PathType Container)) {New-Item -Path $source -ItemType Directory | Out-Null} 

$packages = @( 
<#@{title='7zip Extractor';url='http://downloads.sourceforge.net/sevenzip/7z920-x64.msi';Arguments=' /qn';Destination=$source}, 
@{title='Putty 0.63';url='http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.63-installer.exe';Arguments=' /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-';Destination=$source} #>
@{title='Notepad++ 7.5.6';url='https://notepad-plus-plus.org/repository/7.x/7.5.6/npp.7.5.6.Installer.x64.exe';Arguments=' /Q /S';Destination=$source} 
) 


foreach ($package in $packages) { 
        $packageName = $package.title 
        $fileName = $package.url.SubString($package.url.LastIndexOf('/')+1)
        $destinationPath = $package.Destination + "\" + $fileName 

If (!(Test-Path -Path $destinationPath -PathType Leaf)) { 

    Write-Host "Downloading $packageName" 
    $webClient = New-Object System.Net.WebClient 
    $webClient.DownloadFile($package.url,$destinationPath) 
    } 
    }

 
#Once we've downloaded all our files lets install them. 
foreach ($package in $packages) { 
    $packageName = $package.title 
    $fileName = $package.url.SubString($package.url.LastIndexOf('/')+1) 
    $destinationPath = $package.Destination + "\" + $fileName 
    $Arguments = $package.Arguments 
    Write-Output "Installing $packageName" 


Invoke-Expression -Command "$destinationPath $Arguments" 
}
