Import-Module .\Foundations.psm1

function Invoke-ElasticAPIConfiguration () {
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
            HelpMessage="The index in elastic to store the message in. This is used to construct the URL endpoint for post/get.",
            Position=1
        )]
        [ValidateNotNullOrEmpty()]
        [String] $ElasticIndex,

        [Parameter(
            Mandatory=$False,
            HelpMessage="Flag if this uses SSL or not. This is used to construct the URL endpoint."
        )]
        [Switch] $SSLEnabled
    )
    Begin{
        if ($SSLEnabled){
            $URI = "https://" + $ServerConnection + "/" + $ElasticIndex + "/_doc"; 
        }else{
            $URI = "http://" + $ServerConnection + "/"+ $ElasticIndex + "/_doc";
        }
    }Process{
        $env:ES_URL = $URI
    }End{
        if(!$env:ES_URL){
            Write-Error "Unable to store into environment variables"
        }
    }
}
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
            HelpMessage="The index in elastic to store the message in. This is used to construct the URL endpoint for post/get.",
            Position=1
        )]
        [ValidateNotNullOrEmpty()]
        [String] $ElasticIndex,

        [Parameter(
            Mandatory=$False,
            HelpMessage="Flag if this uses SSL or not. This is used to construct the URL endpoint."
        )]
        [Switch] $SSLEnabled,

        [Parameter( 
            Mandatory=$True,
            HelpMessage="The data to store."
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Data,

        [Parameter(
            Mandatory=$False,
            HelpMessage="The URL source of the data in the message."
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Source
    )

    Begin {
        if ($SSLEnabled){
            $URI = "https://" + $ServerConnection + "/" + $ElasticIndex + "/_doc " + $id; 
        }else{
            $URI = "http://" + $ServerConnection + "/"+ $ElasticIndex + "/_doc " + $id;
        }
        
    }
    Process {
        Invoke-UserMessage -MessageToUser "Connection to $URI pending.." -Level Success
        Invoke-UserMessage -MessageToUser "Will post $Data in the $ElasticIndex index" -Level Standard
        #Invoke-RestMethod -Method Put -Uri $URI -Body $Data

    }
    End{
        Write-Host "---"
    }
}

function Invoke-ElasticQuery () {
    Param{
        [Parameter(
            Mandatory=$True,
            HelpMessage="The search parameters specified within a powershell hastable"
        )]
        [ValidateNotNullOrEmpty()]
        [Hashtable] $QueryObject
    }
    Begin{

    }Process{
        
    }End{

    }
}
Export-ModuleMember Invoke-ElasticMessage
Export-ModuleMember Invoke-ElasticQuery
