$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Write-Host "Uninstalling $packageName..." -ForegroundColor Yellow

# Stop any running instances of the application
$processName = "pretendo-local-mocks"
$runningProcesses = Get-Process | Where-Object { $_.Name -match "pretendo" }

if ($runningProcesses) {
    Write-Host "Stopping running instances of $processName..." -ForegroundColor Yellow
    foreach ($process in $runningProcesses) {
        try {
            $process.CloseMainWindow()
            Start-Sleep -Seconds 2
            
            if (!$process.HasExited) {
                $process | Stop-Process -Force
            }
            Write-Host "Stopped process: $($process.Id)" -ForegroundColor Green
        }
        catch {
            Write-Host "Could not stop process $($process.Id): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

# Remove Start Menu shortcut
$startMenuShortcut = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Pretendo Local Mocks.lnk"
if (Test-Path $startMenuShortcut) {
    Write-Host "Removing Start Menu shortcut..." -ForegroundColor Yellow
    Remove-Item $startMenuShortcut -Force
    Write-Host "Start Menu shortcut removed." -ForegroundColor Green
}

# Remove command line shortcut from Chocolatey bin
$binShortcut = "$env:ChocolateyInstall\bin\pretendo-local-mocks.exe"
if (Test-Path $binShortcut) {
    Write-Host "Removing command line shortcut..." -ForegroundColor Yellow
    Remove-Item $binShortcut -Force
    Write-Host "Command line shortcut removed." -ForegroundColor Green
}

# Remove the batch file
$batchFile = Join-Path $toolsDir "pretendo-local-mocks.bat"
if (Test-Path $batchFile) {
    Write-Host "Removing batch file..." -ForegroundColor Yellow
    Remove-Item $batchFile -Force
    Write-Host "Batch file removed." -ForegroundColor Green
}

# Remove the executable
$exePath = Join-Path $toolsDir "pretendo-local-mocks-fe.exe"
if (Test-Path $exePath) {
    Write-Host "Removing executable..." -ForegroundColor Yellow
    Remove-Item $exePath -Force
    Write-Host "Executable removed." -ForegroundColor Green
}

Write-Host "Uninstallation completed successfully!" -ForegroundColor Green
Write-Host "Pretendo Local Mocks has been removed from your system." -ForegroundColor White