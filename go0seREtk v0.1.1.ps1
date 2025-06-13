<#
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ░  Script:        Reverse Engineering Malware Toolkit               ░
  ░  Project:       go0seREtk                                         ░
  ░  Version:       0.1.1                                             ░                                                                   
  ░  Author:        go0se                                             ░
  ░  Date:          June 2025                                         ░
  ░  Description:   Provides functions to set up basic a REM Lab.     ░
  ░                                                                   ░
  ░  Please see README.md for prerequisites!                          ░
  ░                                                                   ░
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

  This script is provided as-is by go0se.
  Use, modify, and redistribute freely!
  If it breaks, you get to keep both pieces.
#>

# ==================== ASCII Art Banner ====================
Write-Host @'
                                          _____        _____                    
 ______  _____  _____  ______  ______  __|__   |__  __|___  |__    __    __  __ 
|   ___|/     \/     ||   ___||   ___||     |     ||   ___|    | _|  |_ |  |/ / 
|   |  ||     ||  /  | `-.`-. |   ___||     \     ||   ___|    ||_    _||     \ 
|______|\_____/|_____/|______||______||__|\__\  __||______|  __|  |__|  |__|\__\
                                         |_____|      |_____|                   
01100111 01101111 00110000 01110011 01100101 01010010 01000101 01110100 01101011
'@ -ForegroundColor Red

# ==================== Prerequisite Notice ====================
Write-Host "=====================================================================" -ForegroundColor Yellow
Write-Host "  BEFORE YOU CONTINUE:" -ForegroundColor Yellow
Write-Host "  Please make sure you have followed all instructions in README.md." -ForegroundColor Yellow
Write-Host "  This script will install Windows packages using Chocolatey." -ForegroundColor Yellow
Write-Host "=====================================================================" -ForegroundColor Yellow
$null = Read-Host "Press Enter to continue or Ctrl+C to abort..."

# ==================== Admin Rights Check ====================
# Because running as admin is the new "turn it off and on again."
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[-] You do not have Administrator rights to run this script.`nPlease re-run this script as an Administrator." -ForegroundColor Red
    Read-Host "Press any key to exit..."
    exit
}

# ==================== Main Menu ====================
function Show-Menu {
    Clear-Host
    Write-Host @'
                                          _____        _____                    
 ______  _____  _____  ______  ______  __|__   |__  __|___  |__    __    __  __ 
|   ___|/     \/     ||   ___||   ___||     |     ||   ___|    | _|  |_ |  |/ / 
|   |  ||     ||  /  | `-.`-. |   ___||     \     ||   ___|    ||_    _||     \ 
|______|\_____/|_____/|______||______||__|\__\  __||______|  __|  |__|  |__|\__\
                                         |_____|      |_____|                   
01100111 01101111 00110000 01110011 01100101 01010010 01000101 01110100 01101011                                                               
'@ -ForegroundColor Red
    Write-Host "Go0se Reverse Engineering Toolkit - Main Menu" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "1. Run Windows10Debloater.ps1" -ForegroundColor Green
    Write-Host "2. Install Lab Packages" -ForegroundColor Green
    Write-Host "3. Create desktop folder of tool shortcuts." -ForegroundColor Green
    Write-Host "4. Create Network Setting Shortcut on Desktop" -ForegroundColor Green
    Write-Host "5. A GoodTime" -ForegroundColor Green
    Write-Host "6. Shortcut to Sysinternals Share (Internet Required)" -ForegroundColor Green
    Write-Host "7. Exit" -ForegroundColor Green
    Write-Host ""
}

# ==================== Functions for Each Option ====================

function LabPackages {
    # Because every good toolkit needs a config file. Or at least a scapegoat.
    Write-Host "[*] Checking script directory for configuration file..." -ForegroundColor Cyan
    $scriptRoot = $PSScriptRoot
    if (-not $scriptRoot) {
        $scriptRoot = (Get-Location).Path
        Write-Host "[*] \$PSScriptRoot not set. Using current directory: $scriptRoot" -ForegroundColor Yellow
    }
    $packagesConfigPath = Join-Path $scriptRoot 'go0seRE.config'
    Write-Host "[*] Config file path: $packagesConfigPath" -ForegroundColor DarkGray

    # Chocolatey: because who wants to install things manually?
    if (!(Test-Path "$env:ProgramData\chocolatey\bin\choco.exe")) {
        Write-Host "[*] Chocolatey not found. Installing Chocolatey..." -ForegroundColor Cyan
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        try {
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
            $env:Path += ";$env:ProgramData\chocolatey\bin"
            Write-Host "[+] Chocolatey installation complete." -ForegroundColor Green
        }
        catch {
            Write-Host "[-] Failed to install Chocolatey: $_" -ForegroundColor Red
            Write-Host "# At this point, you may want to blame the network. Or fate." -ForegroundColor DarkGray
            Read-Host "Press Enter to return to the main menu..."
            return
        }
    }
    else {
        Write-Host "[+] Chocolatey is already installed." -ForegroundColor Green
    }

    # Actually try to install something. Hope springs eternal.
    if (Test-Path $packagesConfigPath) {
        Write-Host "[*] Installing Windows packages from go0seRE.config..." -ForegroundColor Cyan
        choco install $packagesConfigPath -y | Write-Host
        Write-Host "[+] Package installation complete." -ForegroundColor Green
    }
    else {
        Write-Host "[-] Could not find go0seRE.config at $packagesConfigPath" -ForegroundColor Red
        Write-Host "# It's not lost, it's just... not found." -ForegroundColor DarkGray
    }
    Read-Host "Press Enter to return to the main menu..."
}

function Debloater {
    # Because sometimes Windows just needs a good scrubbing.
    Write-Host "[*] Locating Windows10Debloater script..." -ForegroundColor Cyan
    $debloaterPath = Join-Path $PSScriptRoot 'Windows10Debloater-master\Windows10Debloater.ps1'
    Write-Host "[*] Script path: $debloaterPath" -ForegroundColor DarkGray

    if (Test-Path $debloaterPath) {
        Write-Host "[*] Running Windows10Debloater script..." -ForegroundColor Cyan
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$debloaterPath`"" -Wait
        Write-Host "[+] Windows10Debloater script finished." -ForegroundColor Green
    }
    else {
        Write-Host "[-] Could not find Windows10Debloater.ps1 at $debloaterPath" -ForegroundColor Red
        Write-Host "# The script is missing. Like your faith in Windows Update." -ForegroundColor DarkGray
    }
    Read-Host "Press Enter to return to the main menu..."
}

function REMShortcuts {
    # Because launching apps from the Start Menu is so 2010.
    Write-Host "[*] Creating desktop folder for tool shortcuts..." -ForegroundColor Cyan
    $desktopPath = [Environment]::GetFolderPath('Desktop')
    $shortcutFolder = Join-Path $desktopPath 'REM Tools'
    if (!(Test-Path $shortcutFolder)) {
        New-Item -Path $shortcutFolder -ItemType Directory | Out-Null
        Write-Host "[+] Created folder: $shortcutFolder" -ForegroundColor Green
    }
    else {
        Write-Host "[+] Folder already exists: $shortcutFolder" -ForegroundColor Green
        Write-Host "# Reusing old folders: saving time and disk space since forever." -ForegroundColor DarkGray
    }

    Write-Host "[*] Detecting Chocolatey-installed packages..." -ForegroundColor Cyan
    $packages = choco list --local-only --limit-output | ForEach-Object { ($_ -split '\|')[0] }

    $shell = New-Object -ComObject WScript.Shell
    $count = 0

    foreach ($pkg in $packages) {
        Write-Host "[*] Searching for executable for '$pkg'..." -ForegroundColor Cyan
        $exePath = & where.exe $pkg 2>$null | Select-Object -First 1
        if ($exePath -and (Test-Path $exePath)) {
            $shortcutPath = Join-Path $shortcutFolder "$pkg.lnk"
            $shortcut = $shell.CreateShortcut($shortcutPath)
            $shortcut.TargetPath = $exePath
            $shortcut.Save()
            Write-Host "[+] Shortcut created for $pkg." -ForegroundColor Green
            $count++
        }
        else {
            Write-Host "[-] No executable found for $pkg on PATH." -ForegroundColor Yellow
            Write-Host "# Maybe it's hiding. Or maybe it's shy." -ForegroundColor DarkGray
        }
    }
    Write-Host "[*] $count shortcuts created in '$shortcutFolder'." -ForegroundColor Cyan
    Write-Host "# If you don't see your favorite tool, try installing it again. Or yell at your computer." -ForegroundColor DarkGray
    Read-Host "Press Enter to return to the main menu..."
}

function NetworkSettingsShortcut {
    # Because hunting through Control Panel is a sport best left to the professionals.
    Write-Host "[*] Creating Network Connections shortcut on Desktop..." -ForegroundColor Cyan
    $desktopPath = [Environment]::GetFolderPath('Desktop')
    $shortcutPath = Join-Path $desktopPath "Network Connections.lnk"
    $target = "explorer.exe"
    $arguments = "shell:::{992CFFA0-F557-101A-88EC-00DD010CCC48}"

    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $target
    $shortcut.Arguments = $arguments
    $shortcut.IconLocation = "$env:SystemRoot\system32\netshell.dll,0"
    $shortcut.Save()

    Write-Host "[+] Network Connections shortcut created on your Desktop." -ForegroundColor Green
    Write-Host "# Now you can break your network settings in record time." -ForegroundColor DarkGray
    Read-Host "Press Enter to return to the main menu..."
}

function GoodTime {
    # Because every toolkit needs a break. Or at least a distraction.
    Write-Host "[*] Enjoy some ASCII art while you take a break!" -ForegroundColor Cyan
    Write-Host @'
               #   ___                                       |"|      
   __MMM__     #  <_*_>          ...        `  _ ,  '       _|_|_     
    (o o)      #  (o o)         (. .)      -  (o)o)  -      (o o)     
ooO--(_)--Ooo--8---(_)--Ooo-ooO--(_)--Ooo--ooO'(_)--Ooo-ooO--(_)--Ooo-
      _                                        ___                    
     ((_           +++          ()_()         /\#/\                   
    (o o)         (o o)         (o o)        /(o o)\                  
ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--`o'--Ooo-ooO--(_)--Ooo-              
'@ -ForegroundColor Yellow
    Write-Host "# You're welcome. Or I'm sorry. Hard to tell." -ForegroundColor DarkGray
    Read-Host "Press Enter to return to the main menu..."
}

function SysinternalsShare {
    # Because who doesn't love a shortcut to someone else's tools?
    Write-Host "[*] Creating Sysinternals Tools share shortcut on Desktop..." -ForegroundColor Cyan
    $desktopPath = [Environment]::GetFolderPath('Desktop')
    $shortcutPath = Join-Path $desktopPath "Sysinternals Tools.lnk"

    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "C:\Windows\explorer.exe"
    $shortcut.Arguments = '\\live.sysinternals.com\tools'
    $shortcut.IconLocation = "imageres.dll,15"  # Network folder icon
    $shortcut.Save()

    Write-Host "[+] Shortcut to Sysinternals share created on your Desktop." -ForegroundColor Green
    Write-Host "# If Mark Russinovich moves the share, all bets are off." -ForegroundColor DarkGray
    Read-Host "Press Enter to return to the main menu..."
}

# ==================== Main Loop ====================
do {
    Show-Menu
    $choice = Read-Host "Select an option (1-7)"
    switch ($choice) {
        '1' { Debloater }
        '2' { LabPackages }
        '3' { REMShortcuts }
        '4' { NetworkSettingsShortcut }
        '5' { GoodTime }
        '6' { SysinternalsShare }
        '7' { Write-Host "[*] Exiting toolkit. Goodbye!" -ForegroundColor Magenta; exit }
        default { Write-Host "Invalid selection. Please choose a valid option." -ForegroundColor Red; Write-Host "# Or just mash the keyboard. That's what I do." -ForegroundColor DarkGray; Read-Host "Press Enter to continue..." }
    }
} while ($true)
