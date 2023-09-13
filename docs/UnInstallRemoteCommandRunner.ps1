#Requires -RunAsAdministrator
Set-PSDebug -Trace 0

Write-Output 'Uninstalling RemoteCommandRunner...'

if ( $psversiontable.psversion.major -lt 3 )
{
    Write-Output 'Powershell needs to be version 3 or greater'
    exit 1
}

$myshell = New-Object -com 'Wscript.Shell'

Write-Output 'Stop RemoteCommandRunner Service...'
Stop-Service RemoteCommandRunner 2>$null

serman uninstall RemoteCommandRunner
scoop uninstall RemoteCommandRunner
scoop uninstall serman
scoop uninstall 7zip
scoop uninstall git
scoop uninstall aria2
scoop uninstall scoop $myshell.sendkeys('Y') $myshell.sendkeys('{ENTER}')

Remove-Item -Recurse 'C:\scoop'
Remove-Item -Recurse 'C:\serman'

$taskName = 'DPUpdateRemoteCommandRunner'
$taskExists = Get-ScheduledTask | Where-Object { $_.TaskName -like $taskName }
if ($taskExists)
{
    Unregister-ScheduledTask -TaskName "$taskName" -Confirm:$false 2>$null
    Write-Output 'DPUpdateRemoteCommandRunner Task removed successfully...'
}
else
{
    Write-Output 'No DPUpdateRemoteCommandRunner task to remove...'
}

Write-Output 'RemoteCommandRunner uninstallation complete'
