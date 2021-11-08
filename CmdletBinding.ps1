[CmdletBinding()]
Param(
    # This is temp part of code should be removed
    $var1="var1_testasdsa",
    $var2="sadasdas"
)

function varTest {
    param (
        [Parameter(Mandatory = $true)][string] $var1,
        [Parameter(Mandatory = $true)][string] $var2
    )
    Write-Host $var1
    Write-Host $var2
}

varTest $var2 $var1