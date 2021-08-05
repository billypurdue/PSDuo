function Create-DUOPhone() {
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [String]$number,
        [parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [String]$name,
        [parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [String]$extension,
        [parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [String]$type,
        [parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [String]$platform,
        [parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [String]$predelay,
        [parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [String]$postdelay
    )
    [string]$method = "POST"
    [string]$path = "/admin/v1/phones"
    $APiParams = $MyInvocation.BoundParameters
    
    $DuoRequest = Convertto-DUORequest -DuoMethodPath $path -Method $method -ApiParams $ApiParams
    $Response = Invoke-RestMethod @DuoRequest -verbose
    If ($Response.stat -ne 'OK') {
        Write-Warning 'DUO REST Call Failed'
        Write-Warning ($APiParams | Out-String)
        Write-Warning "Method:$method    Path:$path"
    } 
    $Output = $Response | Select-Object -ExpandProperty Response
    Write-Output $Output
}
