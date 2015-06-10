This is a repo that holds my PowerShell_profile.ps1

Copy this file, after updating the directories to match your machine, to %USER_PROFILE%\Documents\WindowsPowershell\

Changes to the prompt:

The prompt now only shows the username @ computer name in most directories. If it is a git directory, there will be some extra info (see Git section).

If the powershell window is an admin window, the color of the username is in red.

The window title now shows the current directory.

Git:

If the current directory is a git directory, the prompt will show the current branch and will show whether the current branch has untracked files (?), changes to be committed (*) or change not pulled from the remote server (O).
