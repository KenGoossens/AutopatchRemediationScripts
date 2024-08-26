$TranscriptPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs"
$TranscriptName = "AutoPatchDetection.log"
new-item $TranscriptPath -ItemType Directory -Force

# stopping orphaned transcripts
try
{
    stop-transcript|out-null
}
  catch [System.InvalidOperationException]
{}

Start-Transcript -Path $TranscriptPath\$TranscriptName -Append


# initialize the array
[PsObject[]]$regkeys = @()
# populate the array with each object
$regkeys += [PsObject]@{ Name = "DoNotConnectToWindowsUpdateInternetLocations"; path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\"}
$regkeys += [PsObject]@{ Name = "DisableWindowsUpdateAccess"; path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\"}
$regkeys += [PsObject]@{ Name = "NoAutoUpdate"; path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\"}


foreach ($setting in $regkeys)
{
    write-host "checking $($setting.name)"
    if((Get-Item $setting.path -ErrorAction Ignore).Property  -contains $setting.name)
    {
        write-host "$($setting.name) is not correct"
        $RemediationNeeded = $true
    }
}


if ($RemediationNeeded -eq $true)
{
    write-host "registry settings are incorrect"
    Stop-Transcript
    exit 1
}
else 
{
    write-host "registry settings are correct"
    Stop-Transcript
    exit 0
}
