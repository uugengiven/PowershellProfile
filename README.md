## Powershell_profile.ps1 for using git in powershell

Copy this file to `%USER_PROFILE%\Documents\WindowsPowershell\`

You may need to alter the directories for `$scripts`, `$source`, and `$npp` to match your system set up.

To use this fully, you will need to install the following programs:

* [Notepad++](https://notepad-plus-plus.org/download/) - Update your `$npp` variable to match the installed location of notepad++.exe
* [Git](https://git-scm.com/downloads) - This is optional, the script will work without it, you just won't get any Git specific formatting
* [AlphaFS](https://github.com/alphaleonis/AlphaFS/releases/latest) - download the zip file and copy the file `AlphaFS.2.0.1\lib\net451\AlphaFS.dll` to your `$scripts` directory

### Changes to the prompt:

The prompt now only shows the username @ computer name in most directories. If it is a git directory, there will be some extra info (see Git section).

If the powershell window is an admin window, the color of the username is in red.

The window title now shows the current directory.

### New Functions:

`Alpha-Delete $directory`

This will permanently delete a directory and all of its contents, even if there are file names/paths that are beyond the 260 character limit.

`Alpha-Copy $source $destination`

This will copy a source directory and all of its contents to the destination directory. This can work with file names/paths that are beyond the 260 character limit.

### Git:

If the current directory is a git directory, the prompt will display the current branch and will show whether the current branch has untracked files (?), changes to be committed (*) or change not pulled from the remote server (O).

ex. **user@machine [ master ] ? * O >**
This shows a git directory with the master branch as current with some items untracked, some tracked and ready for commit and that the local is behind the remote.
