$NPP = "C:\Programs\NotepadPlusPlus\notepad++.exe"
$SCRIPTS = "$env:USERPROFILE\Documents\psScripts\"
$Source = "$env:USERPROFILE\Documents\Projects\"

$GitEnabled = $false
if (Get-Command git -ErrorAction SilentlyContinue)
{
	$GitEnabled = $true
}

Set-Alias npp $NPP

$FSassembly = [Reflection.Assembly]::Loadfile($scripts + 'AlphaFS.dll')
$AlphaFSDir = [Alphaleonis.Win32.Filesystem.Directory]

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

Function Get-Directory($directory)
{
	# Helper function for AlphaFS as it doesn't know what directory it is being invoked from
	if (-Not [System.IO.Path]::IsPathrooted($directory)) {
		$directory = $pwd.path + "\" + (split-path $directory -leaf) }
		
	return $directory
}

Function Alpha-Delete($directory)
{
	#$FSassembly = [Reflection.Assembly]::Loadfile($Scripts + 'AlphaFS.dll')
	#$AlphaFSDir = [Alphaleonis.Win32.Filesystem.Directory]
	# These variables are now global for other usages

	$directory = Get-Directory($directory)

	$title = "Delete Files"
	$message = "Are you sure you wish to delete " + $directory

	$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "Deletes all the files in the folder."

	$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "Retains all the files in the folder."

	$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

	$result = $host.ui.PromptForChoice($title, $message, $options, 0) 
	
	if ($result -eq 0) {
	write-host "Deleted - " $directory
	$AlphaFSDir::Delete($directory, $true, $true) }
	
}

Function Alpha-Copy ($src, $dest)
{
	$src = Get-Directory($src)
	$dest = Get-Directory($dest)
	$AlphaFSDir::Copy($src, $dest)
}

Function Get-YoutubeMP3($url, $dest = "$env:USERPROFILE\Music")
{
	$dest = $dest + "\%(title)s-%(id)s.%(ext)s"
	& "$scripts\youtube-dl.exe" --extract-audio --audio-format "mp3" -o $dest $url
}

Function Get-YoutubeVideo($url, $dest = "$env:USERPROFILE\Music")
{
	$dest = $dest + "\%(title)s-%(id)s.%(ext)s"
	& "$scripts\youtube-dl.exe" -o $dest $url
}