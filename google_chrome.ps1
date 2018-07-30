$hostname = Read-Host -Prompt "Informe o hostname ou Nome da máquina"


Try {
Test-Connection $hostname -ErrorAction Stop
} Catch {
$wshell = New-Object -com wScript.shell
$wshell.Popup("Acesso ao IP falhou, confira se o dado informado está correto")
exit
}

psexec \\$hostname cmd
pushd \\repositoriofb\d$\BIB\InstalacaoRapida\GOOGLE_CHROME\
Start googlechromestandaloneenterprise.msi /q


Read-Host "Verifique a instalação"