param(
    [Parameter(Mandatory)]
    [string] $TenantId,

    [Parameter(Mandatory)]
    [string] $SubscriptionId
)

Set-AzContext -TenantId $TenantId
$Context = Get-AzContext

$Profile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$Client = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($Profile)
$Token = $Client.AcquireAccessToken($Context.Tenant.Id)

$Uri = "https://management.azure.com/subscriptions/$SubscriptionId/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation?api-version=2018-07-01-preview"

$RequestHeaders = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}

Invoke-RestMethod -Method Post -Uri $Uri -Headers $RequestHeaders -StatusCodeVariable "StatusCode" -ResponseHeadersVariable "ResponseHeaders"

if ($StatusCode -eq 202) {
    Write-Host "Evaluation successfully triggered." -ForegroundColor "Green"
    Write-Host "Current status can be found here:" -ForegroundColor "Green"
    Write-Host $ResponseHeaders["Location"] -ForegroundColor "Cyan"
} else {
    Write-Host "Evaluation was not triggered." -ForegroundColor "Red"
}
