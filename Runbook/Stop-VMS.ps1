param($stop = $true)

$rg = "NPO-Torino-Azure"


$cred = Get-AutomationPSCredential -Name 'NPOServiceAccount'

Login-AzureRmAccount -Credential $cred | fl


get-azureRmSubscription


(get-azureRmSubscription)[0] | select-azurermsubscription

$vms = Get-AzureRmVM -ResourceGroupName $rg

if($stop)
{
	$vms | foreach{$_ | Stop-AzureRmVm -force}
}
else
{
	$vms | foreach{$_ | Start-AzureRmVm -force}
}

$vms | foreach {$_ | get-azurermvm -status} | foreach {"$($_.Name)`t$($_.Statuses[$_.Statuses.Count - 1].DisplayStatus)"}