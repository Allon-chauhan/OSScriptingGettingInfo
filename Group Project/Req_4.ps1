Get-ComputerInfo -Property 'os*', 'cs*' | Out-File -FilePath "D:\ComputerInfo.txt"

$Username = "groupos910@gmail.com";
$Password = "Osbrayden4";
$path = "D:\ComputerInfo.txt";

function Send-ToEmail([string]$email, [string]$attachmentpath)
{

    $message = new-object Net.Mail.MailMessage;
    $message.From = "chauhanallonashish@gmail.com";
    $message.To.Add($email);
    $message.Subject = "Computer Specifications";
    $message.Body = "Attached file is having the specifications. ";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com", "587");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent" ; 
    $attachment.Dispose();
 }
Send-ToEmail  -email "allonchauhan2002@gmail.com" -attachmentpath $path;