<>                                          _____        _____                    
<> ______  _____  _____  ______  ______  __|__   |__  __|___  |__    __    __  __ 
<>|   ___|/     \/     ||   ___||   ___||     |     ||   ___|    | _|  |_ |  |/ / 
<>|   |  ||     ||  /  | `-.`-. |   ___||     \     ||   ___|    ||_    _||     \ 
<>|______|\_____/|_____/|______||______||__|\__\  __||______|  __|  |__|  |__|\__\
<>                                         |_____|      |_____|                   
<>01100111 01101111 00110000 01110011 01100101 01010010 01000101 01110100 01101011

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



# Go0seREtk
 - This guide walks through creating 3 Virtual Machines to be used to REM (Reverse Engineering Malware)
 - Two(2) of the machines will run Windows 10. One machine for Static Analysis, (No malware will execute on this machine) and one for Dynamic Analysis (Dirty machine where malware will run).
 - The Third(3) machine will be a linux machine. REMnux to be specific. This machine will act as the "internet" or a "listener" for our dynamic analysis and provide other RE tools.

## Windows REM

### Pre-installation
 - Prepare a Windows 10+ virtual machine
  - Install Windows in the virtual machine, for example using the raw Windows 10 ISO from https://www.microsoft.com/en-us/software-download/windows10ISO

#### Ensure the requirements above are satisfied, including:
  - Disable Windows Updates (at least until installation is finished)
  - Disable Tamper Protection and any Anti-Malware solution (e.g., Windows Defender), preferably via Group Policy.
   - To permanently disable real-time protection:
   Open Local Group Policy Editor (type gpedit.msc in the search box)
   Computer Configuration > Administrative Templates > Windows Components > Microsoft Defender Antivirus > Real-time Protection
   Enable Turn off real-time protection
   Restart the computer
        
  - To permanently disable Microsoft Defender:
     - Open Local Group Policy Editor (type gpedit.msc in the search box)
     - Computer Configuration > Administrative Templates > Windows Components > Microsoft Defender Antivirus
     - Enable Turn off Microsoft Defender Antivirus
     - Restart the computer

#### Enable script execution:
  - ```Set-ExecutionPolicy Unrestricted -Force```
   - If you receive an error saying the execution policy is overridden by a policy defined at a more specific scope, you may need to pass a scope in via ```Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force```. To view execution policies for all scopes, execute ```Get-ExecutionPolicy -List```.

#### Key Steps:
 - Take a pre-installation VM snapshot. 
 - After installation take another VM snapshot
 - Make a full standalone clone of the VM. One will be your Static Analysis machine, and the other Dynamic. Name them accordingly.
 - Take a snapshot of the clone.

## Linux REM

### Install REMnux
 - https://docs.remnux.org/install-distro/get-virtual-appliance
 - https://docs.remnux.org/install-distro/install-from-scratch

Using the OVA is much faster. Download it and open it in your VM software.

 - Update REMnux
  - ```remnux upgrade```
See REMnux docs for more information.
https://docs.remnux.org/



## VM Setup for the Dynamic Windows VM and REMnux
 - After all 3 VMs are installed and put into a restricted network(host-only mode) you need to configure the networks on the VMs.
 - On the static analyis VM it's up to you if you want to leave it internet connected. You should not be running malware here so it should be safe to keep it connected. If theres any chance you think you might run malware here, disable the network interface before doing so.
 - Switch both the Dynamic Windows VM and REMnux VM to host-only mode. Alternativly, you can make a new virtual network and set it to Host-Only and join both of your VMs to that network.
 - On the REMnux VM you can type ```myip``` in the terminal and it will display its IP address.
 - On the Windows machine set a static IPv4 address to be an address within the same network as the REMnux VM.
 - Subnet mask will typically be 255.255.255.0 unless you changed it.
 - Set the Default Gateway and Preferred DNS to the REMnux VM's IP address.
 - Save the config and test pinging between both machines. Also test pinging an internet facing IP address such as 8.8.8.8 to confirm no internet access.



 ## Tools installed with this script package:

**REMBRCXI**:
7zip
sublimetext4
openjdk
ghidra
hxd
python3
pebear
visualstudio-installer
reshack
die
pestudio
dnspyex
x64dbg.portable
processhacker
ericzimmermantools
cmder
docker-cli
capa
exiftool
floss
010editor
sysinternals
regshot
dependencywalker
tor-browser
fiddler
winscp
cyberchef
exeinfo
file
apimonitor

## Optional Addon in the folder:
**Windows10Debloater-master**
Script/Utility/Application to debloat Windows 10, to remove Windows pre-installed unnecessary applications, stop some telemetry functions, stop Cortana from being used as your Search Index, disable unnecessary scheduled tasks, and more...
https://github.com/Sycnex/Windows10Debloater

Windows10Debloater.ps1
Windows10DebloaterGUI.ps1
Windows10SysPrepDebloater.ps1
