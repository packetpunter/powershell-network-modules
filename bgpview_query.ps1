function Get-SplunkASNPrefixSearch() {
    Param(
        [Parameter(
            Mandatory=$True,
            HelpMessage="Autonomous System Number to find Prefixes for",
            Position=0
        )]
        [ValidateNotNullOrEmpty()]
        [String] $ASN
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
            $Data = iwr -Uri $URL -UseBasicParsing -Method Get | ConvertFrom-Json
            foreach($Prefix_set in $Data.data.ipv4_prefixes) {
                $Prefixes = $Prefixes + $Prefix_set.prefix
            }
        }else{
            Write-Host "Cancelled"
        }
    }
    End{
        Write-Host "End.. prefixes:" $Prefixes.Length
        $SPL_FULL = 'index="networking" (xXx) | eval destProto=transport+"/"+dest_port| stats count by src_ip, dest_ip, destProto, vendor_action, session_end_reason'
        $Tuple = '(src_ip="{}" OR dest_ip="{}") OR'
        $TupleFin = '(src_ip="{}" OR dest_ip="{}")'
        $Tups = @()
        for ($i = 0; $i -lt $Prefixes.Length; $i++){
            $p = $Prefixes[$i]
            Write-Host "Processing prefix" $p
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

    }
}

Export-ModuleMember Get-SplunkASNPrefixSearch