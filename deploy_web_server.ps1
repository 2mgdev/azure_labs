$folder = "c:\temp"
$log = "c:\temp\deploy_web_server.txt"
$date = get-date
$HttpPort=80
$httpRule="web server access rule port 80"


function Add-FirewallException
{
    param([string] $port)

    # Delete an exisitng rule
    netsh advfirewall firewall delete rule name=all dir=in protocol=TCP localport=$port >> $log

    # Add a new firewall rule
    netsh advfirewall firewall add rule name=$httpRule dir=in action=allow protocol=TCP localport=$port >> $log
}





if (!(Test-Path $log)) {
    New-Item -Path $folder -ItemType Directory
    New-Item -Path $log -ItemType File
    Add-Content -Value "NEW LOG: Azure PowerShell Endpoint - $date" -Path $log

    Install-WindowsFeature -Name Web-Server >> $log
    Install-WindowsFeature -Name Web-Mgmt-Tools >> $log

    Add-FirewallException -port $HttpPort

    }
else {
    Add-Content -Value "EXSISITNG LOG: Azure PowerShell Endpoint - $date" -Path $log
}