Common editor configuration and build infrastructure for C# projects.

Use the shared files directly from this repository and get future changes with a [symbolic links](https://msdn.microsoft.com/en-us/library/windows/desktop/aa365680.aspx) from a [Git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

# permissions

Creation of symbolic links on Windows requires a special permission. 
If you are running your development tools as administrator, you already have it. 
If your run your tools without elevation, you can get it by 
[enabling Developer mode](https://docs.microsoft.com/en-us/windows/uwp/get-started/enable-your-device-for-development#accessing-settings-for-developers).

# add submodule to repository
```
mkdir modules
cd modules
git submodule add https://github.com/olegsych/csharp.common.git
cd ..
.\modules\csharp.common\init.ps1
git commit
```

# clone repository with submodules and symlinks
```
git clone --recurse-submodules -c core.symlinks=true <URL>
```

# enable submodules and symlinks in previously cloned repository
```
git pull origin
git config core.symlinks true
git submodule init
git submodule update
```

# update submodule to latest version
```
git submodule update --remote
.\modules\csharp.common\init.ps1
git commit
```
