## Pretendo Launcher 
This launcher consists on a set of powershell scripts to run [Pretendo.Backend](https://github.com/Bengie23/Pretendo.Backend) and [Pretendo.Frontend](https://github.com/Bengie23/Pretendo_Frontend), which together run as Pretendo APP 🐼.

## Pre-Requisites
1. For now, it only runs in Windows
2. For now, it requires dotnet core 8.0 SDK [install](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
3. It requires previous installation of rustc [install](https://www.rust-lang.org/tools/install)
4. Pretendo needs to run in localhost:80 (http) and localhost:443 (https), if for any reason this is a problem, read "#How to run multiple services together"
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
4. When you finish using Pretendo, just close the window

# How to run multiple services together
Let's say your system is already set up to communicate with your services using port 80, and you're trying to use Pretendo, here's my suggestion:
   ## How to setup Pretendo + NGINX
   1. Within the Pretendo.Launcher directory, execute `./backend.with.nginx.launcher.ps1` (This will run Pretendo in localhost:5000)
   2. Make sure tu run your services in a different port (let's say localhost:5203)
   3. Download [NGINX](https://nginx.org/download/nginx-1.27.4.zip)
   4. Place it under C:
   5. Unzip and open terminal from nginx folder
   6. run `code .` (or open this folder manually in VS Code)
   7. Once loaded, open `/config/nginx.conf`
   8. Comment out the default server
   9. Add the next 2 servers to NGINX.conf
    
```
    server {
        listen          80;
        server_name pretendo.local;
        location    / {
            proxy_pass      http://localhost:5000;
            proxy_http_version 1.1;
            proxy_set_header   Upgrade $http_upgrade;
            proxy_set_header   Host $host;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
        }
    }
    server {
        listen          80;
        server_name localhost;
        location    / {
            proxy_pass      http://localhost:5203;
            proxy_http_version 1.1;
            proxy_set_header   Upgrade $http_upgrade;
            proxy_set_header   Host $host;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
        }
    }
```
  10. Back in the terminal at (or from VS Code) run: `nginx start`
  <br>

**Note:** If we review this, we find that we have set up 2 servers, both listen port 80 but one is specific for server name pretendo.local and the other one is using localhost, this means that, any requests made to pretendo.local:80 will be redirected to localhost:5000 and any requests made to localhost:80 will be redirected to localhost:5203.
<br>
**Note2:** There seems to be a similar implementation for https, but it won't be covered here.
