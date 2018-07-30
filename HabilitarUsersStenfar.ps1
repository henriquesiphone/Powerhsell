
Import-Csv "C:\Users\admin.henriquep.gw\Desktop\usuarios.csv" | ForEach-Object {

	$samAccountName = $_."users"

	Get-ADUser -Identity $samAccountName | Enable-ADAccount
	Write-Host "-User "$samAccountName" Enabled"

	Get-ADUser $samAccountName -properties * | Set-ADUser -Description " "

	$newpwd = ConvertTo-SecureString -String "Suzano@2017" -AsPlainText –Force
	Set-ADAccountPassword $samAccountName -NewPassword $newpwd -Reset -PassThru | Set-ADuser -ChangePasswordAtLogon $true

}