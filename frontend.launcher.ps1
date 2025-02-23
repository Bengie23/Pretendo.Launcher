#Requires -RunAsAdministrator

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
Write-Output "This script needs to be run As Admin"
Break
}

function Test-Frontend {
    if (Test-Path -Path .\frontend) {
        return $true;
    }
    return $false;
}

if (-Not (Test-Frontend)){
    Write-Host "Downloading Frontend..."
    Invoke-WebRequest 'https://github.com/Bengie23/Pretendo_Frontend/archive/refs/heads/master.zip' -OutFile .\frontend.zip
    Expand-Archive .\frontend.zip .\ 
    Rename-Item .\Pretendo_Frontend-master .\frontend
    Remove-Item .\frontend.zip
}

Set-Location .\frontend
Write-Host "Running Frontend..."
cargo run --release