
Import-Csv "C:\Users\admin.henriquep.gw\Desktop\usuarios.csv" | ForEach-Object {

	$samAccountName = $_."users"


	Add-DistributionGroupMember -Identify "Distribui��o - Brasil" -Memmber $samAccountName

}