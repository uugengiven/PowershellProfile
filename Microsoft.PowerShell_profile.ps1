$NPP = "C:\Programs\NotepadPlusPlus\notepad++.exe"
$SCRIPTS = "$env:USERPROFILE\Documents\psScripts\"
$Source = "$env:USERPROFILE\Documents\Projects\"

$GitEnabled = $false
if (Get-Command git -ErrorAction SilentlyContinue)
{
	$GitEnabled = $true
}

Set-Alias npp $NPP

Function Edit-Profile
{
    npp $profile
}

function IsAdmin()
{
	if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
		return $true
	} else {
		return $false
	}
	
}

Function Write-GitInfo($branchColor, $commitColor, $untrackedColor, $behindColor)
{
	$prompt_string = ""
	$prompt_commit = ""	
	$prompt_untracked = ""
	$prompt_behind = ""

	git branch | foreach {
		if ($_ -match "^\*(.*)"){
			$prompt_string += " [" + $matches[1] + " ] "
		}
	}
	git status | foreach {
		if ($_ -Match "Changes to be committed") {
			$prompt_commit = "* "
		}
		if ($_ -Match "Untracked") {
			$prompt_untracked = "? "
		}
		if ($_ -Match "Changes not staged") {
			$prompt_untracked = "? "
		}
		if ($_ -Match "Your branch is behind" ) {
			$prompt_behind = "O "
		}
	}
	
	Write-Host ($prompt_string) -nonewline -foregroundcolor $branchColor
	Write-Host ($prompt_untracked) -nonewline -foregroundcolor $untrackedColor
	Write-Host ($prompt_commit) -nonewline -foregroundcolor $commitColor
	Write-Host ($prompt_behind) -nonewline -foregroundcolor $behindColor
		
}

Function Write-UserInfo($userColor, $adminColor, $machineColor)
{
	$nameColor = $usercolor
	if (IsAdmin)
	{
		$nameColor = $adminColor
	}
	
	Write-Host ($env:username) -nonewline -foregroundcolor $nameColor
	Write-Host ('@' + [System.Environment]::MachineName + " ") -nonewline -foregroundcolor $machineColor
}

Function prompt
{
	$host.ui.rawui.Windowtitle = $(get-location)

	Write-UserInfo magenta red cyan
	if ($GitEnabled) {	Write-GitInfo green red red red }
	Write-Host (">") -nonewline -foregroundcolor yellow
	return " "	
}