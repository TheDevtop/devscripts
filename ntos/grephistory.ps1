# grephistory
# history | grep string for Powershell
# Herbert Rietman - ROC Rivor

function Search-History {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $true, Position = 0)] [string]$String
                )
    $HistoryFile = "$env:userprofile\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
    Get-Content $HistoryFile | Select-String -Pattern $String
}
