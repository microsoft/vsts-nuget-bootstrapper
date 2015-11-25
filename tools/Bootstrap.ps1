param(
    [string] $repoRoot
)

$ErrorActionPreference = "Stop"

if (!$repoRoot -or !(Test-Path $repoRoot)) {
    Write-Host "The option -repoRoot was not specified, assuming current working directory"
    $repoRoot = (Resolve-Path .\).Path
}

$bootstrapRootDir = (Resolve-Path $PSScriptRoot\..)
$initScriptsDir = "$repoRoot\scripts\init\"

Write-Host "Setting up the VSS Package Management environment..."

# Copy the scripts, updating any that already exist
New-Item -ItemType Container -Force $initScriptsDir | Out-Null
Copy-Item -Force "$bootstrapRootDir\scripts\init\*" $initScriptsDir

# Update the init.ps1 and init.cmd scripts.
Write-Host "Setting up init.ps1 and init.cmd"
Copy-Item -Force "$bootstrapRootDir\init.ps1" $repoRoot
Copy-Item -Force "$bootstrapRootDir\init.cmd" $repoRoot

if (!(Test-Path "$repoRoot\nuget.config")) {
    Write-Host "Looks like you don't have a nuget.config yet, so we'll create one for you"
    Copy-Item "$bootstrapRootDir\nuget.config" $repoRoot
} else {
    Write-Host "You already have a nuget.config.  Not touching it, but you'll want to add the package source that contains VSS.PackageManagement.Bootstrap."
}

# Write out the current version
$packageName = "Microsoft.VisualStudio.Services.NuGet.Bootstrap"
$version = ($bootstrapRootDir -split "$packageName.")[1]
$versionMarkFilePath = "$initScriptsDir\.version"
Write-Output $version | Out-File -Encoding ASCII $versionMarkFilePath

# Done
Write-Host "Updated your VSS.PackageManagement environment to version $version.  Please check in changes to source control.  Now running init.ps1 to put you into the updated environment..."
& "$repoRoot\init.ps1"