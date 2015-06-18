## Powershell_profile.ps1 for using git in powershell

Copy this file, after updating the directories to match your machine, to %USER_PROFILE%\Documents\WindowsPowershell\

### Changes to the prompt:

The prompt now only shows the username @ computer name in most directories. If it is a git directory, there will be some extra info (see Git section).

If the powershell window is an admin window, the color of the username is in red.

The window title now shows the current directory.

New Functions:
--------------

Really-Delete $directory

This will permanently delete a directory and all of its contents, even if there are file names/paths that are beyond the 260 character limit.

### Git:

If the current directory is a git directory, the prompt will display the current branch and will show whether the current branch has untracked files (?), changes to be committed (*) or change not pulled from the remote server (O).

ex. **user@machine [ master ] ? * O >**
This shows a git directory with the master branch as current with some items untracked, some tracked and ready for commit and that the local is behind the remote.
