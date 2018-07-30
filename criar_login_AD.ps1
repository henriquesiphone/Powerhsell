#### Creating a New Domain User ### 
$wshell = New-Object -com wScript.shell
$wshell.Popup("Certifique-se de que está acessando pelo terminal server 172.16.146.20")

### Acquiring Unique Fields Data ### 


$SAMAccountLower = Read-Host -Prompt "Digite o Login do Usuario a ser criado (ex: henriquep.gw)" 

$GivenName = Read-Host -Prompt "Digite o primeiro Nome do Usuario a ser criado" 

$Surname = Read-Host -Prompt "Digite o Sobrenome do Usuario a ser criado" 

$Mail = $SAMAccountLower+"@suzano.com.br" 

$Department = Read-Host -Prompt "Digite o Departamento que o Usuario a ser criado pertencerá (ex: Compras)" 

$ManagerName = Read-Host -Prompt "Digite o nome do Gerente do colaborador, precisa ser o nome completo que aparece no AD" 

$ManagerStr = Get-ADUser -Filter 'Name -like $ManagerName' 

$Manager = $ManagerStr.DistinguishedName   

$Cred = Get-Credential

$Date = Read-Host -Prompt "Digite a Data de Expiração da conta do usuario (ex: dd/mm/aaaa)" 

$Company = Read-Host -Prompt "Informe a empresa que o colaborador pertence" 

$Office = Read-Host -Prompt "Informe a Unidade em que o colaborador ficará alocado" 

  

### Setting New User's Properties ### 

$User = @{ 

    Name                  = $GivenName + " " + $Surname 

    SamAccountName        = $SAMAccountLower 

    DisplayName           = $GivenName + " " + $Surname 

    GivenName             = $GivenName 

    Surname               = $Surname 

    EmailAddress          = $Mail 
    
    Department            = $Department

    Description           = $Department 

    Manager               = $Manager 

    AccountPassword       = $Cred.Password 

    AccountExpirationDate = $Date 

    UserPrincipalName     = $Mail 

    Enabled               = $True 

    ChangePasswordAtLogon = $False 

    PasswordNeverExpires  = $False 

    Country               = "BR" 

    Company               = $Company  

     Office                  = $Office} 
### Confirmando Informações###

[System.Windows.Forms.MessageBox]::show("Verifique se as informacoes estao corretas:

    The New User           $DisplayName      Vai ser criado com os seguintes atributos:

    Full Name:             $GivenName $Surname

    Username:              $SAMAccountLower

    Email Address is:      $Mail

    UserPrincipalName:     $Mail

    Enabled:               $True

    ChangePasswordAtLogon: $False

    PasswordNeverExpires:  $False

    Credential:            $Cred

    AccountExpirationDate: $Date

    Manager:               $Manager

    Department:            $Department

    Email Address is:      $Mail


Os atributos acima serao gravados no Active Directory


Clique em OK para contiuar." , "AD New User", 1)

 

### Checking If the New User Account Already Exists ###

if(Get-ADUser -Filter "samaccountname -eq '$SAMAccountLower'"){

    Write-Warning "Login $SAMAccountLower ja existe"

    $SAMAccountLower = $Surname.Substring(0,[System.Math]::Min(6, $Surname.Length)) + $GivenName.Substring(0,1)}

 

New-ADUser @User

$ADUser = Read-Host -Prompt "Vamos inserir as informações no campo editor de atributos, digite novamente o login que foi criado"
$departmentNumber2 = Read-Host -Prompt "Digite o centro de custo"
$CPF = Read-Host -Prompt "Informe o cpf, somente os números"
$RG = Read-Host -Prompt "Informe o RG"
$datanasc = Read-Host -Prompt "Informe a data de nascimento no seguinte formato: aaaammdd"
if ($departmentNumber2 -eq "" ){
Write-Warning "O centro de custo está vazio, por favor altere este campo"
}
if (!$CPF ){
Write-Warning "O cpf está em branco, vá até o AD e altere este campo"
$CPF = 0
}
if (!$RG ){
Write-Warning "O rg está em branco, vá até o AD e altere este campo"
$RG = 0
}
if (!$datanasc){
Write-Warning "A data de nascimento está em branco, vá até o AD e altere o campo"
$datanasc = 0
}

Set-ADUser -Identity $ADUser -Add @{"departmentNumber"="0000"+"$departmentNumber2"}
Set-ADUser -Identity $ADUser -Add @{"extensionAttribute4"="$CPF"}
Set-ADUser -Identity $ADUser -Add @{"extensionAttribute5"="$RG"}
Set-ADUser -Identity $ADUser -Add @{"extensionAttribute6"="$datanasc"}

$expireDate = (Get-ADUser -Identity $ADUser -Properties accountExpires).accountExpires
$renewedExpireDate = ([System.DateTime]::FromFileTime($expireDate)).AddDays(1)

Set-ADUser -Identity $ADUser -AccountExpirationDate $renewedExpireDate

$wshell = New-Object -com wScript.shell
$wshell.Popup("Processo finalizado, vá até o AD, confira as informações e mova o user para a Unidade Organizacional correta")
