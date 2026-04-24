param(
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$distRoot = Join-Path $repoRoot 'dist'
$blogSource = Join-Path $repoRoot 'blog'
$hugoFallback = 'C:\Users\valen\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_Microsoft.Winget.Source_8wekyb3d8bbwe\hugo.exe'
$hugoExe = (Get-Command hugo -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty Source)

if (-not $hugoExe) {
    if (Test-Path $hugoFallback) {
        $hugoExe = $hugoFallback
    }
    else {
        throw 'Hugo was not found. Install Hugo or update scripts/build-blog-preview.ps1.'
    }
}

if (Test-Path $distRoot) {
    Remove-Item -Recurse -Force $distRoot
}

New-Item -ItemType Directory -Path $distRoot | Out-Null

$hugoArgs = @(
    '--source', $blogSource,
    '--destination', (Join-Path $distRoot 'blog'),
    '--baseURL', '/blog/'
)

if ($Quiet) {
    $hugoArgs += '--quiet'
}

& $hugoExe @hugoArgs

if ($LASTEXITCODE -ne 0) {
    throw 'Hugo build failed.'
}

Copy-Item (Join-Path $repoRoot 'index.html') (Join-Path $distRoot 'index.html')
Copy-Item (Join-Path $repoRoot 'css') (Join-Path $distRoot 'css') -Recurse
Copy-Item (Join-Path $repoRoot 'assets') (Join-Path $distRoot 'assets') -Recurse
if (Test-Path (Join-Path $repoRoot 'favicon.ico')) {
    Copy-Item (Join-Path $repoRoot 'favicon.ico') (Join-Path $distRoot 'favicon.ico')
}
New-Item -ItemType File -Path (Join-Path $distRoot '.nojekyll') -Force | Out-Null

Write-Output "Preview build ready at $distRoot"
