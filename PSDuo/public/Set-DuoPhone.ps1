function Set-DUOPhone() {
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [String]$userid,
        [parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [String]$number
    )
    [string]$method = "POST"
    [string]$path = "/admin/v1/users/$userid/phones"
    
    $duocellinfo = get-duophone -number $number

    $APiParams = @{phone_id = $duocellinfo.phone_id}

    $DuoRequest = Convertto-DUORequest -DuoMethodPath $path -Method $method -ApiParams $APiParams -verbose
    $Response = Invoke-RestMethod @DuoRequest -verbose
    If ($Response.stat -ne 'OK') {
        Write-Warning 'DUO REST Call Failed'
     
        Write-Warning ($APiParams | Out-String)
        Write-Warning "Method:$method    Path:$path"
    } 
    $Output = $Response | Select-Object -ExpandProperty Response
    Write-Output $Output
}
