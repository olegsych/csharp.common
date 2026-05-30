<#
.SYNOPSIS
    Synchronizes shared csharp.common files into the consuming repository.

.DESCRIPTION
    Creates symbolic links for shared files that should track csharp.common verbatim
    and copies files the consuming repo owns and may diverge from. Stages changes
    with `git add` but does not commit. Safe to run repeatedly.

    The consuming repo root is auto-detected as the parent of the directory
    containing this script's parent (i.e. `<consumer>/modules/csharp.common/`).

.NOTES
    Creating symbolic links on Windows requires Developer Mode or an elevated shell.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

[string] $SubmoduleRoot = $PSScriptRoot
[string] $TargetRoot    = Split-Path -Parent (Split-Path -Parent $SubmoduleRoot)

# Paths relative to both roots; symlinks track csharp.common, copies are owned by consumer.
[string[]] $Symlinks = @(
    '.editorconfig',
    'StrongName.snk',
    'Directory.Build.props',
    'Directory.Build.targets',
    '.github/instructions',
    '.github/agents',
    '.github/prompts',
    '.github/skills'
)

[string[]] $Copies = @(
    '.gitattributes',
    '.gitignore',
    '.github/copilot-instructions.md'
)

function Main {
    Write-Host "csharp.common: $SubmoduleRoot"
    Write-Host "consumer:      $TargetRoot"

    foreach ($path in $Symlinks) { SyncSymlink $path }
    foreach ($path in $Copies)   { SyncCopy    $path }

    Write-Host ''
    Write-Host "Done. Changes staged in $TargetRoot (not committed)."
}

function SyncSymlink([string] $relPath) {
    [string] $linkAbs   = Join-Path $TargetRoot    $relPath
    [string] $sourceAbs = Join-Path $SubmoduleRoot $relPath
    EnsureSource $sourceAbs

    EnsureParent $linkAbs
    [string] $linkParent = Split-Path -Parent $linkAbs
    [string] $linkName   = Split-Path -Leaf   $linkAbs
    [string] $target     = Resolve-Path -Relative -Path $sourceAbs -RelativeBasePath $linkParent

    if (Test-Path -LiteralPath $linkAbs) {
        $existing = Get-Item -LiteralPath $linkAbs -Force
        [string] $storedTarget = @($existing.Target)[0]
        if ($existing.LinkType -eq 'SymbolicLink' -and $storedTarget -eq $target) {
            Write-Host "symlink up-to-date: $relPath"
            StageChange $relPath
            return
        }
        Remove-Item -LiteralPath $linkAbs -Recurse -Force
    }

    Push-Location $linkParent
    try {
        New-Item -ItemType SymbolicLink -Path $linkName -Target $target | Out-Null
    } finally {
        Pop-Location
    }
    Write-Host "symlink created:    $relPath -> $target"
    StageChange $relPath
}

function SyncCopy([string] $relPath) {
    [string] $destAbs = Join-Path $TargetRoot    $relPath
    [string] $srcAbs  = Join-Path $SubmoduleRoot $relPath
    EnsureSource $srcAbs

    if (Test-Path -LiteralPath $destAbs) {
        $existing = Get-Item -LiteralPath $destAbs -Force
        if ($existing.LinkType -eq 'SymbolicLink') {
            Remove-Item -LiteralPath $destAbs -Force
        }
    }

    EnsureParent $destAbs
    Copy-Item -LiteralPath $srcAbs -Destination $destAbs -Force
    Write-Host "copied:             $relPath"
    StageChange $relPath
}

function EnsureSource([string] $path) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Source not found: $path"
    }
}

function EnsureParent([string] $path) {
    [string] $parent = Split-Path -Parent $path
    if ($parent -and -not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
}

function StageChange([string] $relPath) {
    & git -C $TargetRoot add -- $relPath
    if ($LASTEXITCODE -ne 0) { throw "git add failed for $relPath" }
}

Main
