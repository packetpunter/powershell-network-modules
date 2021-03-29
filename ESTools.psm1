Import-Module .\Foundations.psm1
function Invoke-ElasticMessage () {
    Param(
        [Parameter(
            Mandatory=$True,
            HelpMessage="The server information with TCP port, e.g. 'thebestcluster.lan:9200' ",
            Position=0
        )]
        [ValidateNotNullOrEmpty()]
        [String] $ServerConnection,

        [Parameter(
            Mandatory=$True,
            HelpMessage="The message to post in a key,value pair. e.g. @('Name','TheBest')",
            Position=1
        )]
        [ValidateNotNullOrEmpty()]
        [System.Array] $MessageKVPair,

        [Parameter(
            Mandatory=$False,
            HelpMessage="Flag if this uses SSL or not",
            Position=2
        )]
        [Switch] $SSLEnabled

    )

    Begin {
        if ($SSLEnabled){
            $URI = "https://" + $ServerConnection + "/"
        }else{
            $URI = "http://" + $ServerConnection + "/"
        }
        
    }
    Process {
        Invoke-UserMessage -MessageToUser "Connection to $URI pending.." -Level Success
        Invoke-UserMessage -MessageToUser "Will post $MessageKVPair" -Level Standard

    }
    End{
        Write-Host "---"
    }
}