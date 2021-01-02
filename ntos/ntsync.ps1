# Backup-PSScripts
# Herbert Rietman - ROC Rivor


Function Remove-ToRecycleBin
{
    param(
        [ValidateScript({
            if( -Not ($_ | Test-Path) )
            {
                throw "File or folder does not exist."
            }
            return $True
        })]
        [System.IO.FileInfo]$Path
    )

    $Folder = Split-Path -Path $Path
    $File = Split-Path -Path $Path -Leaf
    $Shell = New-Object -ComObject "Shell.Application"
    $Folder = $Shell.Namespace("$Folder")
    $Item = $Folder.ParseName("$File")
    $Item.InvokeVerb("Delete")
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Shell) | Out-Null
}


# 7Zip command line arguments:
# a: create archive
# t7z: of type 7-zip
# mx1: lowest compression level
# "E:\Cloud\Dropbox\Documenten\ps\ps.7z": target file
# "D:\ps\*": source folder (folder name excluded because of \*)
# | Out-Null: no output
# (Measure-Command { .\Backup-PSScripts.ps1 }).TotalSeconds # 1.3 seconds for 27 MB
$SevenZip = "D:\Program Files\7-Zip\7z.exe"
$Folder = "E:\Cloud\Dropbox\Documenten\ps"
$Archive = "ps.7z"
$Target = Join-Path $Folder $Archive
$Source = "D:\ps\*"
$Arguments = "a -t7z -mx1 $Target $Source"

# Remove old backup to Recycle Bin
# Remove-Item $Archive -Force -Confirm:$false -ErrorAction SilentlyContinue
Remove-ToRecycleBin $Target

# Create new backup
Start-Process -WindowStyle Hidden -FilePath $SevenZip -ArgumentList $Arguments #  -Wait

