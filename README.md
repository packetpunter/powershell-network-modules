# Usage
```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
Import-Module PATH_TO_PSM1
```

## Using DNS-Tools
```powershell
 Invoke-DNSTimeTest -Server 10.1.0.1 -TimeBetweenRequests .3 -NumberOfTests 4
```
```
WARNING: DNS Packets this fast may be blocked by next-generation firewalls
**********************************************************************************
    DNS Server: 10.1.0.1 Average Response Time(s): 0.021846325
**********************************************************************************
```
```powershell
Invoke-DNSTimeTest -Server 8.8.8.8 -TimeBetweenRequests .3 -NumberOfTests 4 -Verbose
```
```
VERBOSE: Setting Default list of URLs..                                                                                 
WARNING: DNS Packets this fast may be blocked by next-generation firewalls                                              
VERBOSE: www.google.com
VERBOSE: docs.microsoft.com
VERBOSE: www.purple.com
VERBOSE: nmsu.edu
VERBOSE: www.google.com
VERBOSE: docs.microsoft.com
VERBOSE: www.purple.com
VERBOSE: nmsu.edu
VERBOSE: www.google.com
VERBOSE: docs.microsoft.com
VERBOSE: www.purple.com
VERBOSE: nmsu.edu
VERBOSE: www.google.com
VERBOSE: docs.microsoft.com
VERBOSE: www.purple.com
VERBOSE: nmsu.edu
**********************************************************************************
    DNS Server: 8.8.8.8 Average Response Time(s): 0.0770782
**********************************************************************************
```