[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)] [string]$configFile,
    [Parameter(Mandatory = $false)] [string]$userEmail,
    [Parameter(Mandatory = $false)] [string]$workspaceName,
    [Parameter(Mandatory = $false)] [string]$accessRight,
    [Parameter(Mandatory = $false)] [string]$spId,
    [Parameter(Mandatory = $false)] [string]$group,
    [Parameter(Mandatory = $false)] [string]$gatewayName,
    [Parameter(Mandatory = $false)] [string]$freportConfigFile,
    [Parameter(Mandatory = $false)] [string]$reportDirectory,
    [parameter(Mandatory = $false)] [string]$DatasetName,
    [parameter(Mandatory = $false)] [string]$Parameterlist,
    [switch]$addUserToWorskpace = $false,
    [switch]$addSPToWorskpace = $false,
    [switch]$addGroupToWorskpace = $false,
    [switch]$updateGteway = $false,
    [switch]$uploadReport = $false,
    [switch]$updatePowerBIDatasetParameters = $false,
    [switch]$rebindReports = $false
)

if (condition) {
    <# Action to perform if the condition is true #>
}

if ($null -eq (Get-InstalledModule `
            -Name "MicrosoftPowerBIMgmt.Admin" `
            -ErrorAction SilentlyContinue)) {
    Write-Host "'MicrosoftPowerBIMgmt. Admin does not installed"
    Install-Module-Name MicrosoftPowerBIMgmt. Admin-Scope CurrentUser-Force
}
else {
    Write-Host " nMicrosoftPowerBIMgmt. Admin installed"
}


Import-Module-Name $P5ScriptRoot\setupPowerBI.psml-Force `
    -ArgumentList SconfigFile

#Set the values from the config file passed as the argument
$settings = readConfig $configFile
$tenantId = $settings.azure.tenantId
# $subscriptionName = $settings.azure.subscriptionName
# $subscriptionId = $settings.azure.subscriptionId
# $clientId = $settings.azure.clientId
$powerbiUr1 = $settings.azure.powerbiUrl
$ubscloudEnv = $settings.environment.ubscloudEnv
$vmKeyVaultName = $settings.azure.vmKeyVaultName
$keyVaultScUser = $settings.azure.keyVaultScUser
#keyVaultScSecret = $settings. azure. keyVaultScSecret



Import-Module-Name $PSScriptRoot\managePowerBI.psm1 -Force `
    -ArgumentList $tenantId, $powerbiUr1, SuserEmail, SworkspaceName, $accessRight, $spId, $group, $gatewayName, $ubscloudEnv, $reportConfigFile, $reportDirectory, $vmKeyVaultName, $keyVaultScUser, $keyVaultScSecret,
$DatasetName, $Parameterlist



if (!(
        $addUserToWorskpace -or
        $addSPToWorskpace -or
        $addGroupToWorskpace -or
        $updateGteway -or
        $uploadReport -or
        $updatePowerBIDatasetParameters -or
        $rebindReports
    ))
{
    throw "Please select valid option for the Deployment"
}
    
    
    
if ($addUserToWorskpace) {
    addUserToWorskpace
}

if ($addSPToWorskpace) {
    addSPToWorskpace
}
    
    
if ($addGroupToWorskpace) {
    addGroupToWorskpace
}

if ($updateGteway) {
    updateGteway
}

if ($uploadReport) {
    uploadReport
}

if ($updatePowerBIDatasetParameters) {
    updatePowerBIDatasetParameters
}
if ($rebindReports) {
    rebindReports
}