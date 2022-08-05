[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)] [string]$configFile,
    [Parameter(Mandatory = $false)] [string]$userEmail,
    [Parameter(Mandatory = $false)] [string]$workspaceName,
    [Parameter(Mandatory = $false)] [string]$accessRight,
    [Parameter(Mandatory = $false)] [string]$spId,
    [Parameter(Mandatory = $false)] [string]$group,
    [Parameter(Mandatory = $false)] [string]$gatewayName,
    [Parameter(Mandatory = $false)] [string]$reportConfigFile,
    [Parameter(Mandatory = $false)] [string]$reportDirectory,
    [Parameter(Mandatory = $false)] [string]$AddSchedule,
    [Parameter(Mandatory = $false)] [string]$scheduleIson,
    [switch]$addUserToworskpace = $false,
    [switch]$addSPToWorskpace = $false,
    [switch]$addGroupToWorskpace = $false,
    [switch]$updateteway = $false,
    [switch]$uploadReport = $false
)

if ($null -eq (Get-InstalledModule `
            -Name "Microsoft PowerBIMgmt. Admin" `
            -ErrorAction SilentlyContinue)) {
    Write-Host "nMicrosoft PowerBIMgmt Admin does not installed"
    Install-Module -Name MicrosoftPowerBIMgmt.Admin -Scope CurrentUser -Force
}
else {
    Write-Host "nMicrosoft PowerBIMgmt.Admin installed"
}

Import-Module -Name $PSScriptRoot\setupPowerBI.psm1 -Force `
    -Argumentlist $configfile

# Set the values from the config file passed as the argument
$settings = readConfig $configFile
$tenantId = $settings.azure.tenantId
# $subscriptionName = $settings.azure.subscriptionName
# $subscriptionId = $settings.azure.subscriptionid
# $clientId = $settings.azure.clientid
$powerbiurl = $settings.azure.powerbiUrl
$cloudEnv = $settings.environment.cloudEnv
$vmkeyVaultName = = $settings.azure.vmkeyVaultName
$keyVaultScuser = $settings.azure.keyVaultsScUser
$keyVaultScSecret = $settings.azure.keyVaultScSecret
# $scheduleJson = $settings.schedule

Import-Module -Name $PSScriptRoot\managePowerBI.psm1 -Force `
    - Argumentlist $tenantId, $powerbiurl, $userEmail, $workspaceName, $accessRight, $spId, `
    $group, $gatewayName, $cloudEnv, $reportConfigfile, $reportDirectory, $vmkeyVaultName, `
    $keyVaultScuser, $keyVaultScSecret, $AddSchedule, $scheduleJson

(!(
    $addUserToworskpace -or
    $addSPToWorskpace -or
    $addGroupToWorskpace -or
    $updateGteway -or
    $uploadReport
))

{
    throw "Please select valid option for the Deployment"
}
if ($addUserToWorskpace) {
    addUserToworskpace
}
if ($addSPToWorskpace) {
    addSPToWorskpace
}
if ($addGroupToWorskpace) {
        addGroupToWorskpace
}
if ($updateGteway) {
    updateteway
}
if ($uploadReport) {
    uploadReport
}