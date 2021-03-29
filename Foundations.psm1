function Invoke-UserMessage () {
    Param(
        [Parameter(
            Mandatory=$True,
            HelpMessage="The output that the program will print to the user.",
            Position=0
        )]
        [ValidateNotNullOrEmpty()]
        [String] $MessageToUser,

        [Parameter(
            Mandatory=$True,
            HelpMessage="The level of the message. This changes the symbol in the printed message. Error prints a '-', Standard prints a '*', Success prints a '+'",
            Position=1
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Level
    )
    Begin {
        Switch($Level){
            "Error" { $MessageLevel = "-" }
            "Standard" { $MessageLevel = "*" }
            "Success" { $MessageLevel = "+" }
        }
    }
    Process{
        $output = "[" + $MessageLevel + "]" + "`t" + $MessageToUser
    }
    End{
        Write-Output $output
        
    }
}
Export-ModuleMember Invoke-UserMessage