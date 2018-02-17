$path = Get-ChildItem -Path env:userprofile
subst O: "$($path.Value)\OneDrive"
