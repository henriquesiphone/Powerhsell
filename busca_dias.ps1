$Properties =
@(
"departmentNumber",
"extensionAttribute4",
"extensionAttribute5",
"extensionAttribute6",
"AccountExpirationDate",
"WhenCreated"
)
$dias = Read-Host "Informe o número de dias que deseja buscar"
$checktime = (get-date).adddays(-$dias)
get-ADUser -Properties $Properties -filter {whencreated -ge $checktime}

$question = Read-Host "pressione enter para sair"