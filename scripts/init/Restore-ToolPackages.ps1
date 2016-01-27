Param(
    [Parameter(Mandatory=$true)] [string] $repoRoot
)

$ErrorActionPreference = "Stop"

$toolsPackagesConfigRelativePath = ".nuget\tools\packages.config"
$toolsPackagesConfigPath = Join-Path $repoRoot $toolsPackagesConfigRelativePath
$packagesRelativeDirectory = "packages"
$packagesDirectory = Join-Path $repoRoot $packagesRelativeDirectory

# Restore NuGet tools packages, unless we're on a build machine
if (Test-Path $toolsPackagesConfigPath) {
    if ((Test-Path env:\BUILD_BUILDNUMBER) -eq $true)
    {
        Write-Host "Detected automated build environment. Not restoring tool packages."
        Write-Host "To restore tool packages in your automated builds, add a NuGet Installer build task to your build definition with:"
        Write-Host "    Path to Solution: $toolsPackagesConfigRelativePath"
        Write-Host "    Path to NuGet.config: nuget.config"
        Write-Host "    NuGet Arguments: -PackagesDirectory $packagesRelativeDirectory"
        return;
    }

    Write-Host "Restoring tool packages..."
    nuget restore -PackagesDirectory $packagesDirectory $toolsPackagesConfigPath
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to restore tool packages."
    } else {
        Write-Host "Restored tool packages"
    }
}
