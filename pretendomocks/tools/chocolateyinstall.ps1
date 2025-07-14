$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = $env:ChocolateyPackageName

# Package parameters
$packageArgs = @{
  packageName   = $packageName
  fileFullPath  = Join-Path $toolsDir "Pretendo_Frontend.exe"
  url64bit      = 'https://github.com/Bengie23/Pretendo_Frontend/releases/download/v29/Pretendo_Frontend.exe'
  checksum64    = 'sha256:3f9e74a33bde3f17294d5a0d8705558af985f6b8d26cc5e84ef4b6a671a0068e'
  checksumType64= 'sha256'
}

# Download the executable
Get-ChocolateyWebFile @packageArgs

# Create a simple batch file for easy execution
$batchContent = @"
@echo off
cd /d "$toolsDir"
powershell -Command "Start-Process '$($packageArgs.fileFullPath)' -Verb RunAs"
"@

$batchPath = Join-Path $toolsDir "pretendo-local-mocks.bat"
Set-Content -Path $batchPath -Value $batchContent

# Make the batch file available from command line
Install-ChocolateyShortcut -ShortcutFilePath "$env:ChocolateyInstall\bin\pretendo-local-mocks.exe" -TargetPath $batchPath

# Create Start Menu shortcut
Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Pretendo Local Mocks.lnk" -TargetPath $packageArgs.fileFullPath

Write-Host "Installation completed!" -ForegroundColor Green
Write-Host "⚠️  IMPORTANT: This application requires Administrator privileges" -ForegroundColor Yellow
Write-Host ""
Write-Host "Usage:" -ForegroundColor Yellow
Write-Host "  pretendo-local-mocks   - Launch the application (will prompt for UAC)" -ForegroundColor White
Write-Host ""
Write-Host "The application is also available in the Start Menu." -ForegroundColor White