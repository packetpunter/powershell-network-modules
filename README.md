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
### A default option
```powershell
Invoke-DNSTimeTest -Verbose
```
```
VERBOSE: Using a default DNS server of 8.8.8.8 (Google DNS)
VERBOSE: Setting 10 as the number of tests..
VERBOSE: Setting Default list of URLs..
VERBOSE: Setting default time between requests to .7 seconds
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
VERBOSE: www.google.com
VERBOSE: docs.microsoft.com
VERBOSE: www.purple.com
VERBOSE: nmsu.edu
VERBOSE: www.google.com
VERBOSE: docs.microsoft.com
VERBOSE: www.purple.com
VERBOSE: nmsu.edu
**********************************************************************************
    DNS Server: 8.8.8.8 Average Response Time(s): 0.06273592
**********************************************************************************
```
### Compounded Requests
```powershell
Invoke-DNSTimeTest -Server 10.2.0.4 -TimeBetweenRequests .3 -NumberOfTests 20; Invoke-DNSTimeTest -Server 10.2.0.177 -TimeBetweenRequests .3 -NumberOfTests 20; Invoke-DNSTimeTest -Server 10.2.0.1 -TimeBetweenRequests .3 -NumberOfTests 20 -ListOfURLs ("www.google.com","www.unm.edu","console.aws.amazon.com","nmt.edu","phs.org")
```
```
WARNING: DNS Packets this fast may be blocked by next-generation firewalls
****************************************************************************************************
    DNS Server: 10.2.0.4 Average Response Time(s): 0.01356106 for 80 different queries
****************************************************************************************************
WARNING: DNS Packets this fast may be blocked by next-generation firewalls
****************************************************************************************************
    DNS Server: 10.2.0.177 Average Response Time(s): 0.009862355 for 80 different queries
****************************************************************************************************
WARNING: DNS Packets this fast may be blocked by next-generation firewalls
****************************************************************************************************
    DNS Server: 10.2.0.1 Average Response Time(s): 0.020605915 for 100 different queries
****************************************************************************************************
```
# Notes
This tool makes a lot of assumptions. It assumes the specified DNS server is valid, so this cannot be used to test whether or not a thing IS a dns server. It also assumes a certain set of queries are standard. 
As a user can specify the list of Domains to query, it ought to be mentioned that this tool does not check for valid record type responses (e.g. it won't check if the response is NXDOMAIN vs the A record).

As a side note, what this is really doing is wrapping a timer around Resolve-DnsName or dig (depending on the OS).
