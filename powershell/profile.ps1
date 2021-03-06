# prevent accidental system breaking changes
Set-PSDebug -Strict

# better autocomplete
Set-PSReadlineKeyHandler -Key Tab -Function Complete

# get rid of annoying bell on backspace
Set-PSReadlineOption -BellStyle None

# set home drive directory
set-location C:\

# enable np++ as editor
set-alias edit “C:\Program Files (x86)\Notepad++\notepad++.exe”

# check for admin rights
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# warn user if admin
if (($host.Name -match "ConsoleHost") -and ($isAdmin))
{
     Write-Host "You are using elevated powers`n" -ForegroundColor Red
}

# useful shortcuts for moving directories
function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }

# unix style to indicate if admin
function prompt 
{ 
    if ($isAdmin) 
    {
        $promptString = "[" + (Get-Location) + "] # "
        Write-Host $promptString -NoNewline -ForegroundColor Blue
        return " "
    }
    else 
    {
        $promptString = "[" + (Get-Location) + "] $ "
        Write-Host $promptString -NoNewline -ForegroundColor Blue
        return " "
    }
}

# add 'admin' to top of window if in admin shell
$Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin)
{
    $Host.UI.RawUI.WindowTitle += " [ADMIN]"
}

# start an admin interface
function admin
{
    if ($args.Count -gt 0)
    {   
       $argList = "& '" + $args + "'"
       Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
    }
    else
    {
       Start-Process "$psHome\powershell.exe" -Verb runAs
    }
}

# sudo runs admin command
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin

# github shortcuts
function github { cd "C:\Users\giaco\Documents\Github" }

# remove temp variables 
Remove-Variable identity
Remove-Variable principal

# welcome text at top of shell
Write-Color "Today: ", (Get-Date) -Color White, yellow
New-Alias Time Get-Date -Force
Write-Host "PowerShell"($PSVersionTable.PSVersion.Major)"`n"
