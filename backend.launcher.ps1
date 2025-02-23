#Requires -RunAsAdministrator

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
Write-Output "This script needs to be run As Admin"
Break
}

function Test-Backend {
    if (Test-Path -Path .\backend) {
        return $true;
    }
    return $false;
}

if (-Not (Test-Backend)){
    Write-Host "Downloading Backend..."
    Invoke-WebRequest 'https://github.com/Bengie23/Pretendo.Backend/archive/refs/heads/master.zip' -OutFile .\backend.zip
    Expand-Archive .\backend.zip .\ 
    Rename-Item .\Pretendo.Backend-master .\backend
    Remove-Item .\backend.zip
}

Set-Location .\backend
Write-Host "Running Backend..."
dotnet run --configureation Release --property WarningLevel=0