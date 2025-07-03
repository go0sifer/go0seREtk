```
                                          _____        _____                    
 ______  _____  _____  ______  ______  __|__   |__  __|___  |__    __    __  __ 
|   ___|/     \/     ||   ___||   ___||     |     ||   ___|    | _|  |_ |  |/ / 
|   |  ||     ||  /  | `-.`-. |   ___||     \     ||   ___|    ||_    _||     \ 
|______|\_____/|_____/|______||______||__|\__\  __||______|  __|  |__|  |__|\__\
                                         |_____|      |_____|                   
01100111 01101111 00110000 01110011 01100101 01010010 01000101 01110100 01101011

░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░  Script:        Reverse Engineering Malware Toolkit               ░
░  Project:       go0seREtk                                         ░
░  Version:       0.1.1                                             ░                                                             
░  Author:        go0se                                             ░
░  Date:          June 2025                                         ░
░  Description:   Provides functions to set up a basic REM Lab.     ░
░                                                                   ░
░  Please see README.md for prerequisites!                          ░
░                                                                   ░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
```
This script is provided as-is by go0se. Use, modify, and redistribute freely!  
If it breaks, you get to keep both pieces.
---

# Go0seREtk

A step-by-step guide to creating a Reverse Engineering Malware (REM) lab using three virtual machines:

- **Static Analysis VM** (Windows 10): No malware execution; for static analysis only.
- **Dynamic Analysis VM** (Windows 10): "Dirty" machine for running malware samples.
- **REMnux VM** (Linux): Functions as an isolated "internet"/listener and provides additional RE tools.

---

## 1. Windows REM Setup

### Pre-installation

- Prepare a Windows 10+ virtual machine.
- Download the official Windows 10 ISO:  
  https://www.microsoft.com/en-us/software-download/windows10ISO

#### Required Configuration

- **Disable Windows Updates** (at least until setup is complete).
- **Disable Tamper Protection and Anti-Malware** (e.g., Windows Defender) using Group Policy:
  - Open Local Group Policy Editor (`gpedit.msc`)
  - Navigate to:  
    `Computer Configuration > Administrative Templates > Windows Components > Microsoft Defender Antivirus > Real-time Protection`
  - Enable **Turn off real-time protection**. Restart the VM.
  - To fully disable Defender:
    - Go to:  
      `Computer Configuration > Administrative Templates > Windows Components > Microsoft Defender Antivirus`
    - Enable **Turn off Microsoft Defender Antivirus**. Restart the VM.

- **Enable Script Execution**:
  ```
  Set-ExecutionPolicy Unrestricted -Force
  ```
  - If you get scope errors, use:
    ```
    Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
    ```
    - To check all scopes:
      ```
      Get-ExecutionPolicy -List
      ```

#### Key Steps

- Take a pre-installation VM snapshot.
- After installation, take another snapshot.
- Make a **full standalone clone** of the VM:
  - One for Static Analysis (clean)
  - One for Dynamic Analysis (dirty)
  - Name them accordingly.
- Take a snapshot of each clone.

---

## 2. Linux REM Setup (REMnux)

### Install REMnux

- Official documentation:  
  - [Get Virtual Appliance (OVA)](https://docs.remnux.org/install-distro/get-virtual-appliance)
  - [Install from Scratch](https://docs.remnux.org/install-distro/install-from-scratch)

- **OVA method is fastest**:  
  Download and import into your VM software.

- **Update REMnux** after install:
  ```
  remnux upgrade
  ```
  - See [REMnux Docs](https://docs.remnux.org/) for details.

---

## 3. Network Configuration

- After installing all 3 VMs, set up a **restricted (host-only) network**.
- **Static Analysis VM**:  
  - Optional: Leave internet-connected (safe as long as malware is not executed).
  - If you might run malware, disable the network interface first.
- **Dynamic Analysis VM & REMnux VM**:
  - Set both to host-only mode (or create a dedicated host-only network).
- **REMnux VM**:
  - Get IP with:
    ```
    myip
    ```
- **Dynamic Windows VM**:
  - Set a static IPv4 address in the same subnet as REMnux.
  - Subnet mask: `255.255.255.0` (unless changed).
  - Set **Default Gateway** and **Preferred DNS** to REMnux VM's IP.
  - Save and test connectivity:
    - Ping between both machines.
    - Ping `8.8.8.8` to confirm **no internet access**.

---

## 4. Tools Installed with this Toolkit

The following tools are installed for analysis and utilities:

- 7zip  
- Sublime Text 4
- GoogleChrome  
- OpenJDK  
- Ghidra  
- HxD  
- Python3  
- PE-bear  
- Visual Studio Installer  
- Resource Hacker  
- DIE (Detect It Easy)  
- PEStudio  
- dnSpyEx  
- x64dbg (portable)  
- Process Hacker  
- System Informer
- Eric Zimmerman's Tools  
- Cmder  
- Docker CLI  
- capa  
- ExifTool  
- FLOSS  
- 010 Editor  
- Sysinternals Suite  
- Regshot  
- Dependency Walker  
- Tor Browser  
- Fiddler
- Nmap
- Wireshark  
- CyberChef  
- exeinfo  
- file  
- API Monitor
- TCPView
- Burp Suite Free  

---

## 5. Optional Addon: Windows 10 Debloater

**Windows10Debloater-master**  
A script/utility to debloat Windows 10 by removing unnecessary apps, disabling telemetry, stopping Cortana as your search index, disabling unnecessary scheduled tasks, and more.

- Official repo:  
  https://github.com/Sycnex/Windows10Debloater

Included scripts:
- `Windows10Debloater.ps1`
- `Windows10DebloaterGUI.ps1`
- `Windows10SysPrepDebloater.ps1`

---

*For questions, suggestions, or issues, please contact go0se in Discord or open an issue in the project repository.*
