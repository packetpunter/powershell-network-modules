# Usage
```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
Import-Module PATH_TO_PSM1
```

## Using DNS-Tools
```powershell
 Invoke-DNSTimeTest -Server 10.1.0.1 -TimeBetweenRequests .3 -NumberOfTests 4; Invoke-DNSTimeTest -Server 10.2.0.177 -TimeBetweenRequests .3 -NumberOfTests 4
```
```
WARNING: DNS Packets this fast may be blocked by next-generation firewalls
**********************************************************************************
    DNS Server: 10.2.0.4 Average Response Time(s): 0.021846325
**********************************************************************************
```
