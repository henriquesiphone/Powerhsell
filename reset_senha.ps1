$user = Read-Host -Prompt "Informe o login que será resetado"

Get-ADUser -Identity $User -Properties @("DepartmentNumber";"extensionAttribute4";"extensionAttribute5";"extensionAttribute6";"DistinguishedName")

Write-Host "Segue acima os dados do colababorador, caso cpf, rg ou data de nascimento não apareça, o campo está em branco e é necessário incluir"
$wshell = New-Object -com wScript.shell
$wshell.Popup("Verifique também em qual OU o usuário está no campo 'DistinguishedName'")
 

$password = Read-Host -Prompt "Informe a nova senha"
$pwdefault = Read-Host -Prompt "deseja que o colaborador altere a senha no primeiro acesso? s/n"
if ($pwdefault -eq "s"){
$newpwd = ConvertTo-SecureString -String "$password" -AsPlainText -Force
Set-ADAccountPassword $user -NewPassword $newpwd -Reset -PassThru | Set-ADUser -CHangePasswordAtLogon $true
}if ($pwdefault -eq "n"){
$newpwd = ConvertTo-SecureString -String "$password" -AsPlainText -Force
Set-ADAccountPassword $user -NewPassword $newpwd -Reset -PassThru | Set-ADUser -CHangePasswordAtLogon $false
}

$alter = Read-Host -Prompt "Deseja modificar o cpf, data de nascimento e rg do usuário? s/n"
if ($alter -eq "s"){
$departmentnumber2 = Read-Host -Prompt "Digite o centro de custo"
$CPF = Read-Host -Prompt "Informe o cpf, somente os números"
$RG = Read-Host -Prompt "Informe o RG"
$datanasc = Read-Host -Prompt "Informe a data de nascimento no seguinte formato: aammdd"

Set-ADUser -Identity $user -Replace @{"departmentNumber"="0000"+"$departmentNumber2"}
Set-ADUser -Identity $user -Replace @{"extensionAttribute4"="CPF"}
Set-ADUser -Identity $user -Replace @{"extensionAttribute5"="RG"}
Set-ADUser -Identity $user -Replace @{"extensionAttribute6"="datanasc"}

} if ($alter -eq "n"){
Read-Host -Prompt "Pressione enter para sair"
}

