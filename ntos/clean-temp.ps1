# Remove old temporary files
# Herbert Rietman - ROC Rivor

# Requires -RunAsAdministrator
Param ([int] $RetentionDays = 30)

$DefaultRetentionDays = 30
If (!$PSBoundParameters.ContainsKey('RetentionDays'))
{
    $RetentionDays = $DefaultRetentionDays
}

$D_tmp = "D:\tmp"

# (Get-ChildItem $D_tmp -Recurse).Count
# (Get-ChildItem $D_tmp -Recurse | Where-Object CreationTime -lt  (Get-Date).AddDays(-$RetentionDays)).Count

Get-ChildItem $D_tmp -Recurse | Where-Object LastwriteTime -lt  (Get-Date).AddDays(-$RetentionDays)  | `
    Remove-Item -Force -Recurse -ErrorAction SilentlyContinue -Confirm:$False #-WhatIf
