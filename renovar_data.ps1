
$wshell = New-Object -com wScript.shell
$wshell.Popup("Certifique-se de que está acessando pelo terminal server 172.16.146.20 e com Login Admin")

$User = Read-Host -Prompt "Digite o login que deseja renovar"
$Date = Read-Host -Prompt "Informe a nova data de expiração no seguinte formato: DD/MM/AAAA"

Set-ADAccountExpiration -Identity $User -DateTime $Date
$expireDate = (Get-ADUser $User -Properties accountExpires).accountExpires
$renewedExpireDate = ([System.DateTime]::FromFileTime($expiredate)).AddDays(1)
Set-ADUser -Identity $User -AccountExpirationDate $renewedExpireDate

Get-ADUser -Identity $User -Properties @("departmentNumber";"extensionAttribute4";"extensionAttribute5";"extensionAttribute6")

Write-Host "Segue acima os atributos do user (cpf,rg,data de nascimento), se algum campo não aparecer o colaborador não possui o campo preenchido"

$wshell.Popup( "Observe em qual Unidade Organizacional o usuário está em 'DistinguishedName', caso esteja em 'Desativados', mova para a Unidade correta'")

$Question = Read-Host -Prompt "Deseja alterar as informações do editor de atributos (centro de custo, cpf, rg, data de nascimento)? s\n"
if($Question -eq "s"){

$CPF = Read-Host -Prompt "informe o CPF"
$RG = Read-Host -Prompt "informe o RG"
$datanasc = Read-Host -Prompt "Informe  data de nascimento aaaammdd"


Set-ADUser -Identity $User -Replace @{"extensionAttribute4"="$CPF"}
Set-ADUser -Identity $User -Replace @{"extensionAttribute5"="$RG"}
Set-ADUser -Identity $User -Replace @{"extensionAttribute6"="$datanasc"}

} 
