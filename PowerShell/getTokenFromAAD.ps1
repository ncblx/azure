[CmdletBinding()]
Param(
    # This is temp part of code should be removed
    $tenantId="93f33571-550f-43cf-b09f-cd331338d086",
    $appId="19688ae0-fa83-48fb-998b-89249cd614ce",
    $spPassword="hOq7Q~hrWA7GvcgOrzm8uy3FYkRmcDQKonFX~",
    # This part should be uncommented
    # [Parameter(Mandatory = $true, Position=1)][string] $tenantId,
    # [Parameter(Mandatory = $true, Position=2)][string] $appId,
    # [Parameter(Mandatory = $true, Position=3)][SecureString] $spPassword,
    [switch] $Addreport = $false

)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if($null -eq (Get-InstalledModule `
    -Name "MicrosoftPowerBiMgmt.Admin" `
    -ErrorAction SilentlyContinue))
    {
        Write-Host "`nMicrosoftPowerBiMgmt.Admin does not installed"
        Install-Module -Name MicrosoftPowerBiMgmt.Admin -Scope CurrentUser -Force -Verbose
    }
else {
    Write-Host "`nMicrosoftPowerBiMgmt.Admin installed"
}

# Decoding password, need to uncommented 
# $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($spPassword)
# $plnpasswd = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

# Write-Host $plnpasswd
# Need to remove
$plnpasswd = $spPassword
function getTokenFromAAD 
{
    Param(
        [Parameter(Mandatory = $true)][string] $tenantId,
        [Parameter(Mandatory = $true)][string] $appId,
        [Parameter(Mandatory = $true)][String] $plnpasswd

    )
    $aadurl = "https://login.microsoftonline.com";
    $powerbiurl = "https://analysis.windows.net/powerbi/api"
    Write-Host "`nAAD URL:" $aadurl
    Write-Host "Tenant ID:" $tenantId
    Write-Host "APP ID:" $appId
    # Write-Host "Password:" $plpasswd
    $bearertoken = Invoke-RestMethod -Uri $aadurl/$tenantId/oauth2/token?api-version=1.0 -Method Post -Body `
        @{"grant_type" = "client_credentials"; "resource" = $powerbiurl; "client_id" = $($appId); "client_secret" = $($plnpasswd)}
    Write-Host "`n" $bearertoken
    return $bearertoken.access_token 
}


$token = getTokenFromAAD $tenantId $appId $plnpasswd
if($Addreport){
    Addreport $token
}