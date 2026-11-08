# Rebuild App — Technical Reference

Detailed architecture, stack definitions, contracts, and self-healing compiler protocols for `rebuild-app`.

## Supported Target Stacks

| Target Type | Recommended Stack | Build Command | Output Artifact |
|---|---|---|---|
| Desktop GUI | `Rust (egui / eframe)` | `cargo build --release` | `target/release/<name>.exe` |
| CLI / Console | `Rust (console)` | `cargo build --release` | `target/release/<name>.exe` |
| Modern Web | `Next.js App Router` | `npm run build` | `.next/` |
| Single Page App | `Vite + React (TypeScript)` | `npm run build` | `dist/` |
| Desktop Webview | `Electron (TypeScript)` | `npm run build` | `dist/` |
| Script / Utility | `Python 3` | `python -m py_compile src/*.py` | `src/__pycache__/` |

See detailed templates and configurations in [references/stacks.md](references/stacks.md).

## Mechanics Contract Specification

The reconstruction engine records extracted operational numbers in `app/mechanics.json`.
Each entry requires:
- `value`: extracted numeric or string constant.
- `unit`: metric or display unit (px, ms, count, hex).
- `source`: binary provenance (function symbol, virtual address, or section offset).
- `estimated`: boolean flag indicating whether the value was derived without exact binary evidence.

See the complete JSON Schema and examples in [references/mechanics-contract.md](references/mechanics-contract.md).

## Self-Healing Compilation Protocol

1. Execute the build command from within the `app/` directory.
2. Read stderr on failure.
3. Parse the compiler error message and locating coordinates (file, line, column).
4. Apply the minimal targeted fix using `edit`.
5. Repeat the compilation command.
6. Terminate after exit code zero or a maximum of five iterative cycles.

See concrete compiler error patterns and recovery strategies in [references/check-rules.md](references/check-rules.md).
