while($true)
{
    $AdminURL = Read-Host -Prompt "Please enter url"
    #  "https://randomuser.me"

    $test = Test-Connection -Quiet $AdminURL

    if($test -eq $true)
    {
        break
    }
    else 
    {
        Write-Output "Enter Correct URL!"    
    }
}

Invoke-WebRequest -URI $AdminURL