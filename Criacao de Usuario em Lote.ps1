#### Creating a Bulk of New Domain User ###

$Users = Import-CSV C:\Criar_Users\Users.csv -Delimiter “;” | ForEach-Object {New-Aduser -Name $_.FullName -DisplayName $_.FullName -GivenName $_.GivenName -Surname  $_.SurName -Description $_.Department -SamAccountName $_.SamAccountLower -UserPrincipalName $_.UserPrincipalName -StreetAddress $_.StreetAddress -State $_.State -City $_.City -Department $_.Department -Title $_.Title -ChangePasswordAtLogon $False -Company "ADT Sys Corp" -AccountPassword (ConvertTo-SecureString -AsPlainText "123@mudar"-Force) -Enabled $True}

