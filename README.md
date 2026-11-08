# Rebuild App

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Multi-Harness](https://img.shields.io/badge/Harness-Claude%20Code%20%7C%20Pi%20Agent%20%7C%20Cursor%20%7C%20OpenCode-brightgreen.svg)](#multi-harness-support)
[![Specification](https://img.shields.io/badge/Spec-Agentic%20STE-blueviolet.svg)](SKILL.md)

Autonomous clean-room software reconstruction skill for AI coding agents. Reconstructs compiled executables, libraries, and application packages (PE, ELF, Mach-O, APK, ASAR, etc.) into modern, clean, and compilable source code using an evidence-first approach and self-healing compilation.

---

## Overview

When given a compiled binary or application archive, an agent equipped with `rebuild-app` autonomously discovers its architecture, extracts exact operational constants into a grounded mechanics contract, generates source code without copying proprietary assets, and resolves all compiler errors through an autonomous feedback loop.

### 6-Phase Autonomous Workflow

```text
Target Binary ──► [Phase 1: Triage & Inspection]
                        │
                        ▼
                  [Phase 2: Blueprint & Stack Selection]
                        │
                        ▼
                  [Phase 3: Mechanics Contract Extraction (mechanics.json)]
                        │
                        ▼
                  [Phase 4: Clean-Room Code Generation (app/)]
                        │
                        ▼
                  [Phase 5: Autonomous Self-Healing Compile Loop]
                        │
                        ▼
                  [Phase 6: Final Delivery & Execution Command]
```

1. **Phase 1: Target Triage and Inspection** — Analyzes binary format, architecture, strings, and disassembles entrypoints using tools such as Craft Anything MCP, Ghidra, radare2, or Hopper.
2. **Phase 2: Stack Selection and Blueprint** — Selects optimal modern tech stack (Rust egui, Rust console, Next.js, Vite+React, Electron, Python) and scaffolds `app/`.
3. **Phase 3: Mechanics Contract Extraction** — Extracts numerical constants (window geometry, paddings, timeouts, formula factors) into `app/mechanics.json` and `app/MECHANICS.md`.
4. **Phase 4: Clean-Room Code Generation** — Generates complete application logic with placeholder assets, strictly avoiding copyright infringements.
5. **Phase 5: Self-Healing Compilation** — Runs one-shot build commands (`cargo build`, `npm run build`), parses compiler stderr, and autonomously applies targeted fixes until exit code 0.
6. **Phase 6: Final Delivery** — Reports stack, capabilities, and execution commands in 3–5 sentences.

---

## Multi-Harness Support

`rebuild-app` is built to be agnostic and compatible across major AI agent harnesses:

| Harness | Supported Path | Description |
|---|---|---|
| **Claude Code** | `~/.claude/skills/rebuild-app` | Native Anthropic skill structure (`SKILL.md`) |
| **Pi Agent** | `~/.pi/agent/skills/rebuild-app` | Native Pi agent skill loader |
| **Codex / OpenCode / Copilot CLI** | `~/.agents/skills/rebuild-app` | Cross-runtime `.agents/` skill standard |
| **Cursor** | `.cursor/rules/rebuild-app.mdc` | Workspace MDC rule format |
| **Gemini CLI / Antigravity** | `~/.agents/skills/rebuild-app` | Global skill discovery |
| **Custom LLM / Web Prompt** | `prompts/rebuild-app.md` | Copy-pasteable system instruction |

---

## Installation

### Automated Install (Recommended)

Clone the repository and run the installation script:

#### Linux / macOS / WSL / Git Bash:
```bash
git clone https://github.com/<your-username>/rebuild-app.git
cd rebuild-app
bash install.sh
```

#### Windows PowerShell:
```powershell
git clone https://github.com/<your-username>/rebuild-app.git
cd rebuild-app
.\install.ps1
```

*To also install the Cursor rule into your current workspace, run: `.\install.ps1 -CursorWorkspace .`*

---

### Manual Installation

#### 1. For Claude Code
Copy the repository contents to `~/.claude/skills/rebuild-app`:
```bash
mkdir -p ~/.claude/skills/rebuild-app
cp -r SKILL.md REFERENCE.md references/ ~/.claude/skills/rebuild-app/
```

#### 2. For Pi Agent
Copy to `~/.pi/agent/skills/rebuild-app`:
```bash
mkdir -p ~/.pi/agent/skills/rebuild-app
cp -r SKILL.md REFERENCE.md references/ ~/.pi/agent/skills/rebuild-app/
```

#### 3. For Cursor
Copy the rule to your project:
```bash
mkdir -p .cursor/rules
cp .cursor/rules/rebuild-app.mdc .cursor/rules/
```

#### 4. For OpenCode / Codex
Copy to `~/.agents/skills/rebuild-app`:
```bash
mkdir -p ~/.agents/skills/rebuild-app
cp -r SKILL.md REFERENCE.md references/ ~/.agents/skills/rebuild-app/
```

---

## Directory Structure

```text
rebuild-app/
├── SKILL.md                     # Main skill definition (Agentic STE compliant)
├── REFERENCE.md                 # In-depth architectural & stack reference
├── references/                  # Specialized technical specifications
│   ├── stacks.md                # Supported stacks (Rust, Next.js, Vite, Electron, etc.)
│   ├── mechanics-contract.md    # mechanics.json schema and extraction contract
│   └── check-rules.md           # Self-healing compile protocols and validation rules
├── .cursor/
│   └── rules/
│       └── rebuild-app.mdc      # Standalone rule file for Cursor IDE
├── prompts/
│   └── rebuild-app.md           # Universal system prompt for web / custom harnesses
├── install.sh                   # Cross-platform bash installer
├── install.ps1                  # Windows PowerShell installer
├── LICENSE                      # MIT License
└── README.md                    # Documentation
```

---

## Pushing to GitHub

To publish this skill to your GitHub account:

```bash
cd rebuild-app

# 1. Initialize git
git init
git add .
git commit -m "feat: initial release of rebuild-app multi-harness skill"

# 2. Add remote and push (replace with your repository URL)
git branch -M main
git remote add origin https://github.com/<your-username>/rebuild-app.git
git push -u origin main
```

---

## License

MIT License. See [LICENSE](LICENSE) for details.
