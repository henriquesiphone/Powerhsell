
Import-Csv "C:\Users\admin.henriquep.gw\Desktop\usuarios.csv" | ForEach-Object {

	$samAccountName = $_."users"


	Add-DistributionGroupMember -Identify "Distribuição - Brasil" -Memmber $samAccountName

}