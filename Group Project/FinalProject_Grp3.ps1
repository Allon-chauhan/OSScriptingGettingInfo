function Get-DataUser 
{

    $AdminURL = Read-Host -Prompt "Please enter url"
    $response = Invoke-WebRequest -Uri $AdminURL #request Json from randomuser web page
    $userData = ConvertFrom-Json -InputObject $response #convert the json to an object
    $names = Select-Object -InputObject $($userData.results).name 
        $firstName = $names.first #system.string
        $lastName = $names.last #system.string
        #$nameTitle = $names.title #system.string
        $fullName = Out-String -InputObject $names #system.string 
        $profilePic = $($($userData.results).picture).large #get the host where the pic is
        $urlPic = $profilePic
        #$urlPic User picture in large size, use medium or thumbnail changing .net object in $profilePic
        #$path = 'C:\ProgramData\Microsoft\User Account Pictures' #path to save the pic default folder for windows user account
        # download pictures
        #$pics =  Invoke-WebRequest -Uri $urlPic 

        Invoke-WebRequest -Uri "$urlPic" -OutFile "C:\ProgramData\Microsoft\User Account Pictures\$firstName.jpg" 

        New-LocalUser -FullName $fullName -Description "new user SLC-CornwallCampus CNT" -Name ($firstName + " " +$lastName) -NoPassword 

}
#-----------------------------------------------------------------------------------------------------------------------------------

function Install-notepad
{
 
    Invoke-WebRequest -Uri "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9.1/npp.7.9.1.Installer.exe" -OutFile "D:\notepadplusplus.exe"


    Start-Process -FilePath "D:\notepadplusplus.exe" 

}
#-----------------------------------------------------------------------------------------------------------------------------------

Get-ComputerInfo -Property 'os*', 'cs*' | Out-File -FilePath "D:\Computer&CountryInfo.txt"

Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content) | Out-File -FilePath "D:\CountryDetails.txt"

$From = Get-Content -Path "D:\CountryDetails.txt"
Add-Content -Path "D:\Computer&CountryInfo.txt" -Value $From

$Username = "groupos910@gmail.com";
$Password = "Osbrayden4";

function Send-ToEmail([string]$email, [string]$attachmentpath)
{

    $message = new-object Net.Mail.MailMessage;
    $message.From = "groupos910@gmail.com";
    $message.To.Add($email);
    $message.Subject = "Computer Specifications and Country Information";
    $message.Body = "Attached file is having all the informations. Thank you.";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com", "587");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent"; 
    $attachment.Dispose();
 }
 

Get-DataUser 

Install-notepad

Send-ToEmail  -email "allonchauhan2002@gmail.com" -attachmentpath "D:\Computer&CountryInfo.txt";