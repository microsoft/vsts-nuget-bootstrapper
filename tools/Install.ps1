param(
    [Parameter(Mandatory=$true)] [string]   $installPath,
    [Parameter(Mandatory=$true)] [string]   $toolsPath,
    [Parameter(Mandatory=$true)]            $package,
    [Parameter(Mandatory=$true)]            $project
)

& "$toolsPath\Bootstrap.ps1" -repoRoot (Get-Item -Path ".\" -Verbose).FullName