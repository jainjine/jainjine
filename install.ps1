# Silent install Cylance

# Path for the workdir
$workdir = "c:\installer\"

# Check if work directory exists if not create it

If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }

# Download the installer

$source = "https://github.com/Techxagon2025/CylanceMSI/raw/main/CylanceUnifiedSetup_x64.msi"
$destination = "$workdir\CylanceUnifiedSetup_x64.msi"
Invoke-WebRequest $source -OutFile $destination

# Start the installation
$params = '/i', "$workdir\CylanceUnifiedSetup_x64.msi",
          '/qn', 'PIDKEY=m0hYOsPhsE30GP8TwM9NnN7d',
          '/L*v C:\installer\install.log'

Start-Process 'msiexec.exe' -ArgumentList $params -NoNewWindow -Wait -PassThru

# Wait XX Seconds for the installation to finish

Start-Sleep -s 120

# Remove the installer

rm -Force $workdir\Cylance*
