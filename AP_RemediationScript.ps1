$TranscriptPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs"
$TranscriptName = "AutoPatchRemediation.log"
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
$regkeys += [PsObject]@{ Name = "WUServer"; path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\"}
$regkeys += [PsObject]@{ Name = "UseWUServer"; path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\"}
$regkeys += [PsObject]@{ Name = "NoAutoUpdate"; path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\"}

foreach ($setting in $regkeys)
{
    write-host "checking $($setting.name)"
    if((Get-Item $setting.path -ErrorAction Ignore).Property -contains $setting.name)
    {
        write-host "remediating $($setting.name)"
        Remove-ItemProperty -Path $setting.path -Name $($setting.name)
    }
    else
    {
        write-host "$($setting.name) was not found"
    }
}
Stop-Transcript