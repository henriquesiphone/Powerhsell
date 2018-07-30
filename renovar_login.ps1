$User = Read-Host -Prompt "Digite o login que deseja renovar"
$Date = Read-Host -Prompt "Informa a nova data de expiração no seguinte formato: DD/MM/AAAA"

Set-ADAccountExpiration -Identity $User -DateTime $Date
$expireDate = (Get-ADUser $User -Properties accountExpires).accountExpires
$renewedExpireDate = ([System.DateTime]::FromFileTime($expiredate)).AddDays(1)
Set-ADUser -Identity $User -AccountExpirationDate $renewedExpireDate

Get-ADUser -Identity $User -Properties @("departmentNumber";"extensionAttribute4";"extensionAttribute5";"extensionAttribute6")

$Question = Read-Host -Prompt "Deseja alterar as informações do editor de atributos (centro de custo, cpf, rg, data de nascimento)? s\n"
if($Question -eq "s"){

$CPF = Read-Host -Prompt "informe o CPF"
$RG = Read-Host -Prompt "informe o RG"
$datanasc = Read-Host -Prompt "Informe  data de nascimento aaaammdd"


Set-ADUser -Identity $User -Add @{"extensionAttribute4"="$CPF"}
Set-ADUser -Identity $User -Add @{"extensionAttribute5"="$RG"}
Set-ADUser -Identity $User -Add @{"extensionAttribute6"="$datanasc"}

}
