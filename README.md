## Pretendo Launcher
This launcher consists on a set of powershell scripts to run [Pretendo.Backend](https://github.com/Bengie23/Pretendo.Backend) and [Pretendo.Frontend](https://github.com/Bengie23/Pretendo_Frontend), which together run as Pretendo APP.

## Pre-Requisites
1. For now, it only runs in Windows
2. For now, it requires dotnet core 8.0 SDK [install](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
3. It requires previous installation of rustc [install](https://www.rust-lang.org/tools/install)
4. 
## How to run?
# To run Pretendo App (runs backend + frontend together)

Pull this Repo, and then:
1. Open a new powershell/cmd terminal with Admin rights.
2. Move to the Repo directory
3. Run:  `.\pretendo.launcher.bat`
4. When you finish using Pretendo, kill the terminal or stop the process (for backend only)

# To run Pretendo Backend

Pull this Repo, and then:
1. Open a new powershell/cmd terminal with Admin rights.
2. Move to the Repo directory
3. Run:  `.\backend.launcher.ps1 `
4. When you finish using Pretendo, kill the terminal or stop the process (for backend only)

# To run Pretendo Frontend

Pull this Repo, and then:
1. Open a new powershell/cmd terminal with Admin rights.
2. Move to the Repo directory
3. Run:  `.\frontend.launcher.ps1 `
4. When you finish using Pretendo, kill the terminal or stop the process (for backend only)
