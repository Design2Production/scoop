$deviceAddress = $args[0]

if (!$deviceAddress)
{
    Write-Output 'DPEMS IP Address must be specified eg. 10.10.10.3:8000'
    exit
}

try
{
    # disable the watchdog - both network and serial
    # the proxy will reenable it once it runs
    #$setting = Get-Content -Raw -Path C:\ProgramData\DP\DeviceProxy\setting.json | ConvertFrom-Json
    #$deviceAddress = $setting.deviceAddress
    $postCommand = "$deviceAddress/setWatchDog"
    Write-Output $postCommand

    $body = @{
        'status' = 'false'
    } | ConvertTo-Json

    $header = @{
        'Accept'       = 'application/json'
        'Content-Type' = 'application/json'
    }

    for ($i = 0; $i -lt 3; $i++)
    {
        $response = Invoke-WebRequest -Uri "$postCommand" -Method 'Post' -Body $body -Headers $header
        if ($response.StatusCode -eq 200)
        {
            Write-Output 'Stop WatchDog Successful'
            break;
        }
        else
        {
            Write-Output "Stop WatchDog Failed:$($response.StatusCode)"
        }
    }
}
catch
{
    Write-Output "Stop WatchDog Exception:$_.Exception.Message"
}    
