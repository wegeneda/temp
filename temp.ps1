# Connect to Azure
#<- Authentication
$connectionName = "AzureRunAsConnection"
$servicePrincipalConnection =  Get-AutomationConnection -Name $connectionName -ErrorAction Stop
# Logging in to Azure...
$connectionResult = Add-azaccount -ServicePrincipal -TenantId $servicePrincipalConnection.TenantId -ApplicationId $servicePrincipalConnection.ApplicationId -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint -ErrorAction Stop 
# Authentication ->

#foreach ($sub in $Subscriptions) {
$EDate = Get-Date

$array+=Search-AzGraph -Query "project name, size = properties.hardwareProfile.vmSize, properties.licenseType, `
resourceGroup, subscriptionId, type, properties.storageProfile.osDisk.osType, location | where type =~ 'Microsoft.Compute/virtualMachines'" 

$ahubVM = $array | ?{$_.properties_licenseType -eq "Windows_Server"}

write-output $ahubVM

