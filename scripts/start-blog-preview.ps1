param(
    [int]$Port = 8080,
    [switch]$SkipBuild
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$distRoot = Join-Path $repoRoot 'dist'
$serverStateFile = Join-Path $PSScriptRoot '.blog-preview.state'
$serveFallback = Join-Path $env:USERPROFILE '.dotnet\tools\dotnet-serve.exe'
$serveExe = (Get-Command dotnet-serve -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty Source)

if (-not $serveExe) {
    if (Test-Path $serveFallback) {
        $serveExe = $serveFallback
    }
    else {
        throw 'dotnet-serve was not found. Install it or update scripts/start-blog-preview.ps1.'
    }
}

if (-not $SkipBuild) {
    & (Join-Path $PSScriptRoot 'build-blog-preview.ps1') -Quiet
}

if (Test-Path $serverStateFile) {
    $existingServerId = Get-Content $serverStateFile -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($existingServerId) {
        $existingProcess = Get-Process -Id $existingServerId -ErrorAction SilentlyContinue
        if ($existingProcess) {
            Stop-Process -Id $existingServerId -Force
        }
    }
    Remove-Item $serverStateFile -Force
}

$process = Start-Process -FilePath $serveExe -ArgumentList '--directory', $distRoot, '--port', $Port -PassThru -WindowStyle Hidden
Set-Content -Path $serverStateFile -Value $process.Id

"Preview server running at http://localhost:$Port/blog/"
"Server state saved to $serverStateFile"