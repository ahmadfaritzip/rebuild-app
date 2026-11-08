#!/usr/bin/env bash
# ==============================================================================
# rebuild-app Skill Installer (macOS, Linux, WSL, Git Bash)
# Installs rebuild-app into various AI agent harnesses:
#  - Claude Code (~/.claude/skills/rebuild-app)
#  - Pi Agent (~/.pi/agent/skills/rebuild-app)
#  - OpenCode / Codex / Copilot CLI (~/.agents/skills/rebuild-app)
#  - Cursor (.cursor/rules/ in current or specified workspace)
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_NAME="rebuild-app"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Installing '${SKILL_NAME}' skill across harnesses ===${NC}"

install_skill_dir() {
    local target_parent="$1"
    local harness_name="$2"
    local target_dir="${target_parent}/${SKILL_NAME}"

    mkdir -p "${target_dir}/references"
    cp -f "${SCRIPT_DIR}/SKILL.md" "${target_dir}/"
    cp -f "${SCRIPT_DIR}/REFERENCE.md" "${target_dir}/"
    cp -rf "${SCRIPT_DIR}/references/"* "${target_dir}/references/"
    echo -e "${GREEN}✓ Installed for ${harness_name}:${NC} ${target_dir}"
}

install_cursor_rule() {
    local workspace_dir="${1:-.}"
    local cursor_dir="${workspace_dir}/.cursor/rules"
    mkdir -p "${cursor_dir}"
    cp -f "${SCRIPT_DIR}/.cursor/rules/${SKILL_NAME}.mdc" "${cursor_dir}/"
    echo -e "${GREEN}✓ Installed Cursor Rule:${NC} ${cursor_dir}/${SKILL_NAME}.mdc"
}

# 1. Global Agents directory (Codex, OpenCode, Copilot CLI, Gemini CLI)
AGENTS_DIR="${HOME}/.agents/skills"
install_skill_dir "${AGENTS_DIR}" "Agents / OpenCode / Codex"

# 2. Claude Code
CLAUDE_DIR="${HOME}/.claude/skills"
install_skill_dir "${CLAUDE_DIR}" "Claude Code"

# 3. Pi Agent
PI_DIR="${HOME}/.pi/agent/skills"
install_skill_dir "${PI_DIR}" "Pi Agent"

# 4. Optional Cursor Rule for current directory
if [ -d ".git" ] || [ -d ".cursor" ]; then
    install_cursor_rule "."
fi

echo -e "\n${GREEN}Successfully installed '${SKILL_NAME}'!${NC}"
echo "You can now invoke or reference 'rebuild-app' across Claude Code, Pi Agent, Cursor, and OpenCode."
