Common editor configuration and build infrastructure for C# projects.

Use the shared files directly from this repository and get future changes with a [symbolic links](https://msdn.microsoft.com/en-us/library/windows/desktop/aa365680.aspx) from a [Git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

# permissions

Creation of symbolic links on Windows requires a special permission. 
If you are running your development tools as administrator, you already have it. 
If your run your tools without elevation, you can get it by 
[enabling Developer mode](https://docs.microsoft.com/en-us/windows/uwp/get-started/enable-your-device-for-development#accessing-settings-for-developers).

# add submodule
```
mkdir modules
cd modules
git submodule add https://github.com/olegsych/csharp.common.git
git commit
cd ..
```

# link shared files
```
cmd /c mklink .editorconfig .\modules\csharp.common\.editorconfig
git add .editorconfig

cmd /c mklink .gitattributes .\modules\csharp.common\.gitattributes
git add .gitattributes

cmd /c mklink .gitignore .\modules\csharp.common\.gitignore
git add .gitignore

cmd /c mklink directory.build.props .\modules\csharp.common\directory.build.props
git add directory.build.props

git commit
```

# clone

Clone repository with submodules and symlinks.
```
git clone --recurse-submodules -c core.symlinks=true <URL>
```

Enable submodules and symlinks in previously cloned repositories.
```
git pull origin
git config core.symlinks true
git submodule init
git submodule update
```
