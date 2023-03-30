# DP Windows Uninstallation of Proxy

1. Download the uninstall script
<pre>
Invoke-WebRequest -Uri https://design2production.github.io/scoop/UnInstallDeviceProxy.ps1 -OutFile UnInstallDeviceProxy.ps1
</pre>

If the installation script fails with ***Invoke-WebRequest : The request was aborted: Could not create SSL/TLS secure channel*** then enter the following command and retry the Web-Request
<pre>
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
</pre>

2. Allow Powershell to execute local scripts, when prompted, select **[A] Yes to All** + **ENTER** to allow local scripts to be executed
<pre>
set-executionpolicy remotesigned -scope currentuser  
</pre>

3. Run the uninstall script:
<pre>
.\UnInstallDeviceProxy.ps1
</pre>
