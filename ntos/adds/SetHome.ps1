# Program:  Set users home directory
# Version:  1.0
# Authors:  ROC Rivor

# EDIT THESE TO MAKE IT WORK!
$LDAP = "*"
$DEST = "*\$sam"

Import-Module ActiveDirectory
Get-ADUser -Filter * -SearchBase $LDAP | Foreach-Object {
    $sam = $_.SamAccountName
    Set-ADuser -Identity $_ -HomeDrive "H:" -HomeDirectory $DEST }
