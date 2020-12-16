set-executionpolicy unrestricted
$ErrorActionPreference = 'Stop'

Install-PackageProvider NuGet -Force | out-null
Import-PackageProvider NuGet -Force | out-null
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted | out-null

if(!(Get-Module -ListAvailable -Name 'Az.*'))
{
    Install-Module -Name Az -AllowClobber -RequiredVersion 4.4.0 -SkipPublisherCheck -Repository PSGallery

    Uninstall-Module -Name Az.Accounts -ErrorAction SilentlyContinue
    Install-Module -Name Az.Accounts -RequiredVersion 1.9.3 -Repository PSGallery
    Uninstall-Module -Name Az.Compute -ErrorAction SilentlyContinue
    Install-Module -Name Az.Compute -RequiredVersion 1.4.0 -Repository PSGallery
    Uninstall-Module -Name Az.Resources -ErrorAction SilentlyContinue
    Install-Module -Name Az.Resources -RequiredVersion 2.4.0 -Repository PSGallery
}

if(!(Get-Module -ListAvailable -Name Microsoft.RDInfra.RDPowerShell))
{
    Install-Module -Name Microsoft.RDInfra.RDPowerShell
}

if(!(Get-Module -ListAvailable -Name ADAL.PS))
{
    Install-Module -Name ADAL.PS
}

if(!(Get-Module -ListAvailable -Name AzureTableEntity))
{
    Install-Module -Name AzureTableEntity
}

if(!(Get-Module -ListAvailable -Name AzureAD))
{
    Install-Module -Name AzureAD -Repository PSGallery
}

Clear-AzContext -Scope CurrentUser -Force | Out-Null
Connect-AzAccount

[System.AppDomain]::CurrentDomain.GetAssemblies()
