$User = Read-Host -Prompt "Informe o login que você deseja procurar"
Get-ADUser -Identity $User -Properties @("departmentNumber";"extensionAttribute4";"extensionAttribute5";"extensionAttribute6")
$User = Read-Host -Prompt "Pressione Enter para fechar"