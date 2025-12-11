# =========================
# LAB 2 – SCRIPT 2
# Configure DHCP scope + options
# Create User1 + User2
# =========================

$DomainName = "mbb1324.com"  
$ServerIP   = "192.168.10.2"
$Gateway    = "192.168.10.254"
$PublicDNS  = "8.8.8.8"

# DHCP scope
$ScopeName      = "LAN Scope"
$ScopeNetworkId = "192.168.10.0"
$ScopeMask      = "255.255.255.0"
$ScopeStart     = "192.168.10.20"
$ScopeEnd       = "192.168.10.200"

Write-Host "Setting DNS forwarder..." -ForegroundColor Cyan
Add-DnsServerForwarder -IPAddress $PublicDNS -ErrorAction SilentlyContinue

Write-Host "Authorizing DHCP server..." -ForegroundColor Cyan
Install-WindowsFeature DHCP -IncludeManagementTools | Out-Null
Add-DhcpServerInDC -DnsName ("{0}.{1}" -f $env:COMPUTERNAME, $DomainName) -IPAddress $ServerIP

Write-Host "Creating DHCP scope..." -ForegroundColor Cyan
Add-DhcpServerv4Scope -Name $ScopeName -StartRange $ScopeStart -EndRange $ScopeEnd -SubnetMask $ScopeMask

Write-Host "Setting DHCP options..." -ForegroundColor Cyan
Set-DhcpServerv4OptionValue -ScopeId $ScopeNetworkId -Router $Gateway -DnsServer $ServerIP, $PublicDNS -DnsDomain $DomainName

Restart-Service DHCPServer

Write-Host "Creating User1 and User2..." -ForegroundColor Cyan
Import-Module ActiveDirectory

# User1 (Domain User)
$User1Pwd = Read-Host "Password for User1" -AsSecureString
New-ADUser -Name "Domain User" -SamAccountName "DUser" -UserPrincipalName "DUser@$DomainName" -AccountPassword $User1Pwd -Enabled $true

# User2 (Domain Admin)
$User2Pwd = Read-Host "Password for User2" -AsSecureString
New-ADUser -Name "Domain Admin" -SamAccountName "DAdmin" -UserPrincipalName "DAdmin@$DomainName" -AccountPassword $User2Pwd -Enabled $true
Add-ADGroupMember "Domain Admins" -Members "DAdmin"
