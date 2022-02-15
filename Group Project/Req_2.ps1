$response = Invoke-WebRequest -Uri 'https://randomuser.me/api/' #request Json from randomuser web page
$userData = ConvertFrom-Json -InputObject $response #convert the json to an object
$names = Select-Object -InputObject $($userData.results).name 
     $firstName = $names.first #system.string
     $lastName = $names.last #system.string
     $nameTitle = $names.title #system.string
     $fullName = Out-String -InputObject $names #system.string 
     $profilePic = $($($userData.results).picture).large #get the host where the pic is
     $urlPic = $profilePic
     #$urlPic User picture in large size, use medium or thumbnail changing .net object in $profilePic
     $path = 'C:\ProgramData\Microsoft\User Account Pictures' #path to save the pic default folder for windows user account
     # download pictures
     #$pics =  Invoke-WebRequest -Uri $urlPic 

     $downloadedPic = Invoke-WebRequest -Uri "$urlPic" -OutFile "C:\ProgramData\Microsoft\User Account Pictures\$firstName.jpg" 

    New-LocalUser -FullName $fullName -Description "new user SLC-CornwallCampus CNT" -Name ($firstName + " " +$lastName) -NoPassword 



function Get-DataUser {
    
     #$picRequest = Invoke-WebRequest -Uri $profilePic | New-Item -Path .\Desktop\pic -ItemType file
    }
