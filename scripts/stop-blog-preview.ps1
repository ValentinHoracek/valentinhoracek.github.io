#pragma warning disable PSAvoidAssignmentToAutomaticVariable

$ErrorActionPreference = 'Stop'

$serverStateFile = Join-Path $PSScriptRoot '.blog-preview.state'

if (Test-Path $serverStateFile) {
    Get-Content $serverStateFile -ErrorAction SilentlyContinue |
        Select-Object -First 1 |
        ForEach-Object {
            if (Get-Process -Id $_ -ErrorAction SilentlyContinue) {
                Stop-Process -Id $_ -Force
                Write-Output "Stopped preview server process $_"
            }
            else {
                Write-Output "No running process found for saved state value $_"
            }
        }

    Remove-Item $serverStateFile -Force
}
else {
    if (Get-Process -Name 'dotnet-serve' -ErrorAction SilentlyContinue | Select-Object -First 1) {
        Get-Process -Name 'dotnet-serve' -ErrorAction SilentlyContinue |
            Select-Object -First 1 |
            ForEach-Object {
                Stop-Process -Id $_.Id -Force
                Write-Output "Stopped fallback dotnet-serve process $($_.Id)"
            }
    }
    else {
        Write-Output 'No preview server is currently running.'
    }
}

#pragma warning restore PSAvoidAssignmentToAutomaticVariable
