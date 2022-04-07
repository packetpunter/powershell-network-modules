class ValidateASN: System.Management.Automation.ValidateArgumentsAttribute {
    # https://en.wikipedia.org/wiki/Autonomous_system_(Internet) for list of valid ASN ranges
    [void] Validate ([object]$arguments, [System.Management.Automation.EngineIntrinsics]$engineIntrinsics){
        switch([Int] $arguments) {
            {$PSItem -le 1}{ Throw [System.ArgumentException]::new() }
            {$PSItem -ge 64496 -and $PSItem -le 131072}{Throw [System.ArgumentException]::new()}
            {$PSItem -gt 4199999999 }{Throw [System.ArgumentException]::new()}   
        }
    }
}

function Get-SplunkASNPrefixSearch() {
    Param(
        [Parameter(
            Mandatory=$True,
            HelpMessage="Autonomous System Number to find Prefixes for",
            Position=0
        )]
        [ValidateASN()]
        [String] $ASN,

        [Parameter(
            Mandatory=$False,
            HelpMessage="Outfile path for query results in CSV"
        )]
        [ValidateNotNullOrEmpty()]
        [String] $CSVToFile
    )
    Begin {
        $BGPViewURL = "https://api.bgpview.io/asn/{}/prefixes"
        $QConfirm = "Query for AS#"+$ASN+"? (Y/N)"
        $Confirmation = Read-Host $QConfirm
        $Prefixes = @()
    }
    
    Process{
        if ($Confirmation -eq 'Y') {
            $URL = $BGPViewURL -replace "{}",$ASN
            $Data = Invoke-WebRequest -Uri $URL -UseBasicParsing -Method Get | ConvertFrom-Json
            foreach($Prefix_set in $Data.data.ipv4_prefixes) {
                $Prefixes = $Prefixes + $Prefix_set.prefix
            }
        }else{
            Write-Host "Cancelled"
            Break
        }
    }
    End{
        Write-Verbose "# Found prefixes: {}".replace("{}", $Prefixes.Length)
        $SPL_FULL = 'index="networking" (xXx) | eval destProto=transport+"/"+dest_port| stats count by src_ip, dest_ip, destProto, vendor_action, session_end_reason'
        $Tuple = '(src_ip="{}" OR dest_ip="{}") OR'
        $TupleFin = '(src_ip="{}" OR dest_ip="{}")'
        $Tups = @()
        for ($i = 0; $i -lt $Prefixes.Length; $i++){
            $p = $Prefixes[$i]
            Write-Verbose "Processing prefix {}".replace("{}", $p)
            if($i -ne $Prefixes.Length-1){
                $TempTupl = $Tuple -replace "{}",$p
                $Tups += $TempTupl
            }else{
                $TempTupleFin = $TupleFin -replace "{}",$p
                $Tups += $TempTupleFin
            }
        }

        $FinalFull = $SPL_FULL -replace "xXx",$Tups
        Write-Host `n`n$FinalFull`n`n
        
        if ($CSVToFile) {
            $OutputData = @()
            $date = Get-Date -Format "MM-dd-yyyyTHH:mm:ss"
            Write-Verbose "CIDR`tASN`tTimeStamp:"
            foreach($cidr in $Prefixes){
                Write-Verbose "x`ty`tz".replace("x",$cidr).replace("y",$ASN).replace("z", $date)
                $Entry = New-Object psobject
                $Entry | Add-Member -MemberType NoteProperty -Name "CIDR" -Value $cidr
                $Entry | Add-Member -MemberType NoteProperty -Name "ASN" -Value $ASN
                $Entry | Add-Member -MemberType NoteProperty -Name "Timestamp" -Value $date
                $OutputData += $Entry
            }
            $OutputData | Export-CSV -Path $CSVToFile -Append
        }
    }
}

Export-ModuleMember Get-SplunkASNPrefixSearch