# ==============================================================================
# rebuild-app Skill Installer (Windows PowerShell)
# Installs rebuild-app into various AI agent harnesses:
#  - Claude Code (~/.claude/skills/rebuild-app)
#  - Pi Agent (~/.pi/agent/skills/rebuild-app)
#  - OpenCode / Codex / Copilot CLI (~/.agents/skills/rebuild-app)
#  - Cursor (.cursor/rules/ in current workspace)
# ==============================================================================

[CmdletBinding()]
param(
    [switch]$Uninstall,
    [string]$CursorWorkspace = ""
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillName = "rebuild-app"

Write-Host "=== Installing '$SkillName' skill across harnesses ===" -ForegroundColor Cyan

function Copy-SkillDir {
    param(
        [string]$TargetParent,
        [string]$HarnessName
    )
    $targetDir = Join-Path $TargetParent $SkillName
    $refDir = Join-Path $targetDir "references"

    if (-not (Test-Path $refDir)) {
        New-Item -ItemType Directory -Path $refDir -Force | Out-Null
    }

    Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $targetDir -Force
    Copy-Item -Path (Join-Path $ScriptDir "REFERENCE.md") -Destination $targetDir -Force
    Copy-Item -Path (Join-Path $ScriptDir "references\*") -Destination $refDir -Recurse -Force

    Write-Host " [OK] Installed for $HarnessName : $targetDir" -ForegroundColor Green
}

function Remove-SkillDir {
    param(
        [string]$TargetParent,
        [string]$HarnessName
    )
    $targetDir = Join-Path $TargetParent $SkillName
    if (Test-Path $targetDir) {
        Remove-Item -Path $targetDir -Recurse -Force
        Write-Host " [REMOVED] $HarnessName : $targetDir" -ForegroundColor Yellow
    }
}

$userProfile = [Environment]::GetFolderPath("UserProfile")
$agentsDir = Join-Path $userProfile ".agents\skills"
$claudeDir = Join-Path $userProfile ".claude\skills"
$piDir     = Join-Path $userProfile ".pi\agent\skills"

if ($Uninstall) {
    Write-Host "Uninstalling $SkillName..." -ForegroundColor Yellow
    Remove-SkillDir $agentsDir "Agents / OpenCode / Codex"
    Remove-SkillDir $claudeDir "Claude Code"
    Remove-SkillDir $piDir     "Pi Agent"
    Write-Host "Uninstallation complete." -ForegroundColor Green
    exit 0
}

# 1. Global Agents directory (~/.agents/skills)
Copy-SkillDir $agentsDir "Agents / OpenCode / Codex / Gemini CLI"

# 2. Claude Code (~/.claude/skills)
Copy-SkillDir $claudeDir "Claude Code"

# 3. Pi Agent (~/.pi/agent/skills)
Copy-SkillDir $piDir "Pi Agent"

# 4. Cursor rule if workspace specified or current directory has .git / .cursor
$targetCursor = $CursorWorkspace
if ([string]::IsNullOrWhiteSpace($targetCursor) -and ((Test-Path ".git") -or (Test-Path ".cursor"))) {
    $targetCursor = (Get-Location).Path
}

if (-not [string]::IsNullOrWhiteSpace($targetCursor)) {
    $cursorRulesDir = Join-Path $targetCursor ".cursor\rules"
    if (-not (Test-Path $cursorRulesDir)) {
        New-Item -ItemType Directory -Path $cursorRulesDir -Force | Out-Null
    }
    $mdcSrc = Join-Path $ScriptDir ".cursor\rules\$SkillName.mdc"
    if (Test-Path $mdcSrc) {
        Copy-Item -Path $mdcSrc -Destination $cursorRulesDir -Force
        Write-Host " [OK] Installed Cursor Rule : $(Join-Path $cursorRulesDir "$SkillName.mdc")" -ForegroundColor Green
    }
}

Write-Host "`nSuccessfully installed '$SkillName' across all harnesses!" -ForegroundColor Green
Write-Host "The skill is now ready to use with Claude Code, Pi Agent, Cursor, and OpenCode/Codex." -ForegroundColor Gray
