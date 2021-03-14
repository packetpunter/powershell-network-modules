function Invoke-DNSTimeTest() {
    Param(
        [Parameter(
            Mandatory=$False,
            HelpMessage="Server to run Queries against",
            Position=0
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Server,

        [Parameter(
            Mandatory=$False,
            HelpMessage="Number of Queries to Run",
            Position=1
        )]
        [ValidateNotNullOrEmpty()]
        [Int] $NumberOfTests,

        [Parameter(
            Mandatory=$False,
            HelpMessage="List of URLs to Query for test",
            Position=3
        )]
        [ValidateNotNullOrEmpty()]
        [String[]] $ListOfURLs,

        [Parameter(
            Mandatory=$False,
            HelpMessage="Seconds between each query",
            Position=4
        )]
        [ValidateNotNullOrEmpty()]
        [Float] $TimeBetweenRequests
    )

    Begin{
        
        $totalMeasurement = 0
        if (!$Server){
            $Server = "8.8.8.8"
            Write-Verbose "Using a default DNS server of 8.8.8.8 (Google DNS)"
        }

        if (!$NumberOfTests){
            $NumberOfTests = 10; 
            Write-Verbose "Setting 10 as the number of tests.." 
        }

        if(!$ListOfURLs){
            $ListOfURLs = ("www.google.com","docs.microsoft.com","www.purple.com","nmsu.edu")   
            Write-Verbose "Setting Default list of URLs.."
        }

        if($TimeBetweenRequests -and $TimeBetweenRequests -le .5){
            Write-Warning "DNS Packets this fast may be blocked by next-generation firewalls"
        }elseif(!$TimeBetweenRequests){
            $TimeBetweenRequests = .7
            Write-Verbose "Setting default time between requests to .7 seconds"
        }
     
        $t = 1;
        $totalNumberTests = $NumberOfTests * ($ListOfURLs.Length);
        
    }
    
    Process{
        
        for($i=1; $i -ile $NumberOfTests; $i++){
            $percent = [Float]$t/$totalNumberTests * 100;
            Write-Progress -Id 0 -Activity "Running name resolution test against $Server" -Status "Procedures Running:" -PercentComplete $percent
            $ListOfURLs | ForEach-Object -Process {
                $t++;
                Write-Progress -Id 1 -ParentId 0 -Activity "Resolving $_ with $TimeBetweenRequests sec spacing between requests" 
                $test = Measure-Command {Resolve-DnsName $_ -Server $Server -Type A}
                $result = $test.TotalSeconds
                $totalMeasurement += $result
                
                Start-Sleep -Seconds $TimeBetweenRequests
            }

        }
    }

    End{
        $average = $totalMeasurement / $NumberOfTests
        Write-Host "**********************************************************************************"
        Write-Host "  " " DNS Server:" $Server "Average Response Time(s):" $average 
        Write-Host "**********************************************************************************"

    }

}

Export-ModuleMember Invoke-DNSTimeTest
