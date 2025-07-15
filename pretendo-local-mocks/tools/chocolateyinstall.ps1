$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = $env:ChocolateyPackageName

# Package parameters
$packageArgsFrontend = @{
  packageName   = $packageName
  fileFullPath  = Join-Path $toolsDir "pretendo-local-mocks-fe.exe"
  url64bit      = 'https://github.com/Bengie23/Pretendo_Frontend/releases/download/v30/Pretendo_Frontend.exe'
  checksum64    = 'f03c2907504f1799ecfcf8df425ae061b28faa7df0ad1796fe2cefea459e6c7a'
  checksumType64= 'sha256'
}

# Package parameters
$packageArgsBackend = @{
  packageName   = $packageName
  fileFullPath  = Join-Path $toolsDir "pretendo-local-mocks-be.zip"
  url64bit      = 'https://github.com/Bengie23/Pretendo.Backend/releases/download/v32/Pretendo.Backend-v32.zip'
  checksum64    = '454f79577ff15b0bed1d5628161c898b9381b30fa7b217ef5ac3c7f9f246e659'
  checksumType64= 'sha256'
}
$extractPath = "$toolsDir\backend"
$backendExeFullPath = "$extractPath\Pretendo.Backend.exe"

# Download the frontend executable
Get-ChocolateyWebFile @packageArgsFrontend

# Download the backend zip
Get-ChocolateyWebFile @packageArgsBackend

# Extract
Get-ChocolateyUnzip -FileFullPath $packageArgsBackend.fileFullPath -Destination $extractPath

# Create .ignore file to prevent automatic shim creation
$ignoreFile = "$backendExeFullPath.ignore"
New-Item -Path $ignoreFile -ItemType File -Force
$ignoreFile2 = Join-Path $toolsDir "pretendo-local-mocks-fe.exe.ignore"
New-Item -Path $ignoreFile2 -ItemType File -Force

# Create a simple batch file for easy execution
$batchContent = @"
@echo off
cd /d "$toolsDir"
powershell -Command "Start-Process '$($backendExeFullPath)' -Verb RunAs"
powershell -Command "Start-Process '$($packageArgsFrontend.fileFullPath)' -Verb RunAs"
"@

$batchPath = Join-Path $toolsDir "pretendo-local-mocks.bat"
Set-Content -Path $batchPath -Value $batchContent

# This creates an executable shim that calls bat file
Install-BinFile -Name "pretendo-local-mocks" -Path $batchPath

# Create Start Menu shortcut
$iconPath = Join-Path $toolsDir "icon.ico"
Write-Host "Checking icon path..."
Write-Host $iconPath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Pretendo Local Mocks.lnk" -TargetPath $batchPath -IconLocation $iconPath

# Remove the zip
if (Test-Path $packageArgsBackend.fileFullPath) {
    Write-Host "Removing temp zip file..." -ForegroundColor Yellow
    Remove-Item $packageArgsBackend.fileFullPath -Force
    Write-Host "Temp zip file removed." -ForegroundColor Green
}

Write-Host "Installation completed!" -ForegroundColor Green
Write-Host "⚠️  IMPORTANT: This application requires Administrator privileges" -ForegroundColor Yellow
Write-Host ""
Write-Host "Usage:" -ForegroundColor Yellow
Write-Host "  pretendo-local-mocks   - Launch the application (will prompt for UAC)" -ForegroundColor White
Write-Host ""
Write-Host "The application is also available in the Start Menu." -ForegroundColor White

