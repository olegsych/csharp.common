# Visual Studio .editorconfig for C#

[Visual Studio editor configuration](https://docs.microsoft.com/en-us/visualstudio/ide/create-portable-custom-editor-options)
inspired by [Beck's rules of simple design](https://www.martinfowler.com/bliki/BeckDesignRules.html)
to make C# code terse and precise without loss of readability.

## Basic usage

Copy the `.editorconfig` file to the root of your repository.

## Advanced usage on Windows

To use the shared `.editorconfig` directly from this repository and get future changes automatically,
you can reference it with a [symbolic link](https://msdn.microsoft.com/en-us/library/windows/desktop/aa365680.aspx)
from a [Git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

### Required Windows permissions

Creation of symbolic links on Windows requires a special permission. 
If you are running your development tools as administrator, you already have it. 
If your run your tools without elevation, you can get it by 
[enabling Developer mode](https://docs.microsoft.com/en-us/windows/uwp/get-started/enable-your-device-for-development#accessing-settings-for-developers).

### Creating a link to .editorconfig

- Add this repository as a submodule to yours.
```
git submodule add https://github.com/olegsych/csharp.editorconfig.git
git commit
```

- Create a symbolic link to the `.editorconfig`.
```
git submodule add https://github.com/olegsych/csharp.editorconfig.git
cmd /c mklink .editorconfig .\csharp.editorconfig\.editorconfig
git add .editorconfig
git commit
```

### Cloning a repository with links

- Include submodules and symlinks when cloning a repository
```
git clone --recurse-submodules -c core.symlinks=true <URL>
```

- Enable submodules and symlinks in previously cloned repositories.
```
git pull origin
git config core.symlinks true
git submodule init
git submodule update
```