# =========================
# LAB 2 – SCRIPT 1
# Install AD DS, DNS, DHCP
# Promote Windows Server to Domain Controller
# =========================

$DomainName  = "mbb1324.com"     # CHANGE TO YOUR RIT ID + .com
$NetBIOSName = "MBB1324"         # Same ID but uppercase, no .com

Write-Host "Installing AD DS, DNS, DHCP..." -ForegroundColor Cyan
Install-WindowsFeature AD-Domain-Services, DNS, DHCP -IncludeManagementTools

Import-Module ADDSDeployment

$SafeModePwd = Read-Host "Enter DSRM password" -AsSecureString

Install-ADDSForest `
    -DomainName $DomainName `
    -DomainNetbiosName $NetBIOSName `
    -SafeModeAdministratorPassword $SafeModePwd `
    -InstallDNS `
    -Force
