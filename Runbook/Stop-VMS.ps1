param([bool] $stop = $true
	, [String] $TenantId = '8b07f925-16b1-4b2a-bac8-4698520516b2'
	, [String] $rg = "NPO-Torino-Azure"
	, [String] $credname = 'NPOServiceAccount'
)

$ErrorActionPreference = "Stop";
$my_dir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$cred = Get-AutomationPSCredential -Name $credname

Login-AzureRmAccount -Credential $cred -ServicePrincipal -TenantId $TenantId | fl 

"-----------------------------" 
"*****************************" | oh

#get-azureRmSubscription 

#(get-azureRmSubscription)[0] | select-azurermsubscription

$vms = Get-AzureRmVM -ResourceGroupName $rg

if($stop)
{
	$vms | foreach{"Stop $($_.Name)"; $_ | Stop-AzureRmVm -force}
}
else
{
	$vms | foreach{"Start $($_.Name)"; $_ | Start-AzureRmVm -force}
}

$vms | foreach {$_ | get-azurermvm -status} | foreach {"$($_.Name)`t$($_.Statuses[$_.Statuses.Count - 1].DisplayStatus)"}