Common editor configuration and build infrastructure for C# projects.

Use the shared files directly from this repository and get future changes with
[symbolic links](https://msdn.microsoft.com/en-us/library/windows/desktop/aa365680.aspx)
from a [Git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

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
git commit -m 'Add modules/csharp.common'
cd ..
```

# add shared files to repository
```
copy .\modules\csharp.common\.gitattributes .\
copy .\modules\csharp.common\.gitignore .\
git add .
git commit -m 'Copy files from modules/csharp.common that can no longer be symlinked by Git 2.32+'

mkdir src
cd src
cmd /c mklink version.json ..\modules\csharp.common\version.json
cd ..
cmd /c mklink .editorconfig .\modules\csharp.common\.editorconfig
cmd /c mklink StrongName.snk .\modules\csharp.common\StrongName.snk
cmd /c mklink directory.build.props .\modules\csharp.common\directory.build.props
git add .
git commit -m 'Link files from modules/csharp.common'
```

# clone repository with submodules and symlinks
```
git clone --recurse-submodules -c core.symlinks=true <URL>
```

# Enable recursion into submodules by default
```
git config --global submodule.recurse true
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
git add .
git commit -m 'Update modules/csharp.common to latest version'
```
