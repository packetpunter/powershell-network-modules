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


## Using bgpview_query.ps1
```powershell
 Get-SplunkASNPrefixSearch -ASN 32934
```
Or this module is broken into two separate cmdlets if you're into that sort of thing
```powershell
$fb_prefixes = Invoke-BGPViewASNQuery -ASN 32934 -CSVToFile ./as32934.csv
Get-SPLForSubnets -PrefixList $fb_prefixes
```

This module is just for people that use Splunk and need to look up traffic for a certain ASN in splunk, it assumes the traffic logs exist in splunk with 'src_ip' and 'dest_ip' transformations applied and stored in the networking index.
Adding ```-Verbose``` gives more data about CIDRs found for the ASN in a readable format

# Notes
Use these at your own risk, don't be a dick either.