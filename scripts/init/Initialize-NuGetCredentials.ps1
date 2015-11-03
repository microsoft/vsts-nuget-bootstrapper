Param(
    [Parameter(Mandatory=$true)] [string] $repoRoot
)

$ErrorActionPreference = "Stop"

# Get NuGet credentials, unless we're on a build machine
if((Test-Path env:\BUILD_BUILDNUMBER) -eq $true)
{
    return;
}

Write-Host "Ensuring that you have credentials for VSO package sources... "
$repoNuGetConfigPath = Join-Path $repoRoot "nuget.config"
Vss.NuGet.AuthHelper -Config $repoNuGetConfigPath
if ($LASTEXITCODE -ne 0) {
    Write-Warning "Failed to check and/or update your VSO NuGet credentials.  You may not be able to restore or push packages."
}