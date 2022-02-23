#This module installs all Active Directory roles including DNS.
#It will promote to domain controller and reboot.


Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -InstallDNS -Force
Import-Module ADDSDeployment -Force

