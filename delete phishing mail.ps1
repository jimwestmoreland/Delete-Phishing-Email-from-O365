
#Required:
# -a list of smtp addresses in a plain text file, one smtp address per line
# -you must enter the subject you want to search for on line 19 in the -contentmatchquery option
# -all the permissions necessary to run the cmdlets in the script

#Connect to O365 compliance center
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

#Join all the addresses in a string to pass to the New-Compliance Search
$targetlist = get-content -Path C:\path\textlist.txt

#Create the search <update the subject line before you run this>
New-ComplianceSearch -Name "Delete Phishing Mail" -ExchangeLocation $targetlist -ContentMatchQuery 'subject:"<Enter Subject of email>"' -AllowNotFoundExchangeLocationsEnabled $true

#Delete the messages
New-ComplianceSearchAction -SearchName "Delete Phishing Mail" -Purge -PurgeType SoftDelete

#Remove the search
Remove-ComplianceSearch -Identity "Delete Phishing Mail"


