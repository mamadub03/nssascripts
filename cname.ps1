# Lab 2 – Step 7: CNAMEs for site1 and site2
# Run on your Domain Controller as Administrator.

$RitId  = "mbb1324"              # <-- change if your RIT ID is different
$Zone   = "$RitId.com"           # e.g. mbb1324.com
$Target = "rocky.$Zone"    # must already have an A-record for this

Write-Host "Creating CNAME records in zone $Zone pointing to $Target" -ForegroundColor Cyan

Import-Module DnsServer -ErrorAction Stop

# CNAME for main site (site1)
Write-Host "Creating CNAME: site1.$Zone -> $Target"
Add-DnsServerResourceRecordCName `
    -ZoneName $Zone `
    -Name "site1" `
    -HostNameAlias $Target `
    -AllowUpdateAny `
    -TimeToLive ([TimeSpan]::FromHours(1)) `
    -ErrorAction SilentlyContinue

# CNAME for second site (site2)
Write-Host "Creating CNAME: site2.$Zone -> $Target"
Add-DnsServerResourceRecordCName `
    -ZoneName $Zone `
    -Name "site2" `
    -HostNameAlias $Target `
    -AllowUpdateAny `
    -TimeToLive ([TimeSpan]::FromHours(1)) `
    -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "Done. Verify in DNS Manager under zone $Zone:" -ForegroundColor Green
Write-Host "  site1.$Zone  CNAME  $Target"
Write-Host "  site2.$Zone  CNAME  $Target"
Write-Host ""
Write-Host "Then from Windows 10, test:" -ForegroundColor Green
Write-Host "  http://site1.$Zone"
Write-Host "  http://site2.$Zone"
