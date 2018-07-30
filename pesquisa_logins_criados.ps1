[datetime]$whichDate = Read-Host "Informe a data de pesquisa no formato: dd/mm/aaaa"
[datetime]$myDate = ($whichDate).AddDays(-1)

Get-ADUser -Filter {SamAccountName -like "*a"} -properties office,whencreated | ? { $_.whenCreated -ge (get-date "$myDate")}|Select Samaccountname,whenCreated,office