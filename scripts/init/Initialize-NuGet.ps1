Param(
    [Parameter(Mandatory=$true)] [string] $repoRoot
)

$ErrorActionPreference = "Stop"

# Create the .tools directory
New-Item -ItemType Directory -Force -Path "$repoRoot\.tools" | Out-Null
$toolsDir = Join-Path -Resolve $repoRoot ".tools"

# Ensure nuget.exe is up-to-date
$nugetDownloadName = "nuget.exe"
$nugetDest = . "$PSScriptRoot\Initialize-DownloadLatest.ps1" -OutDir $toolsDir -DownloadUrl "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -DownloadName $nugetDownloadName -Unzip $false

# Add the tools dir to the path
if (!($env:Path -like "*$toolsDir;*"))
{
    $env:Path = "$toolsDir;" + $env:Path
}

# Ensure VSS.NuGet.AuthHelper is up-to-date
$authHelperDownloadName = "VSS.NuGet.AuthHelper"
$authHelperDest = . "$PSScriptRoot\Initialize-DownloadLatest.ps1" -OutDir $toolsDir -DownloadUrl "https://vssnuget.pkgs.visualstudio.com/_apis/public/nuget/client/VSS.NuGet.AuthHelper.zip" -DownloadName $authHelperDownloadName -Unzip $true

# Add VSS.NuGet.AuthHelper to the path
if (!($env:Path -like "*$authHelperDest;*"))
{
    $env:Path = "$authHelperDest;" + $env:Path
}