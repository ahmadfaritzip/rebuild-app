# Craft Rebuild: Verification & Autonomous Self-Healing Rules

Bagian ini mengatur siklus validasi build (*BuildCheck*) dan mekanisme perbaikan mandiri (*Self-Healing Loop*) yang dilakukan oleh agen tanpa mengganggu pengguna.

---

## 1. Perintah Verifikasi per Toolchain

| Toolchain | Lokasi | Perintah Build Wajib | Syarat Lulus |
|---|---|---|---|
| **Rust** | `app/Cargo.toml` | `cargo build --quiet` | Exit code 0, menghasilkan biner di `app/target/debug/` |
| **Node / Vite / React** | `app/package.json` | `npm install && npm run build` | Exit code 0, menghasilkan bundle di `app/dist/` atau `app/out/` |
| **Electron** | `app/package.json` | `npm install && npm run build` | Exit code 0, syntax check valid |
| **Python** | `app/pyproject.toml` | `python -m py_compile src/*.py` | Exit code 0, tidak ada syntax error |

> **PERINGATAN KERAS:** Jangan pernah menjalankan server dev atau watcher yang tidak berhenti (`cargo watch`, `npm run dev`, `vite`, `npm start`). Selalu gunakan perintah build/compile yang keluar (*exits*) dengan status code.

---

## 2. Siklus Autonomous Self-Healing (Perbaikan Otomatis)

Saat melakukan kompilasi:
```text
[Run Build] ────────► Exit Code == 0? ──(Ya)──► Lanjut ke Penyerahan
     ▲                         │
     │                        (Tidak)
     │                         ▼
[Ulangi Build] ◄──── [Edit & Perbaiki Kode] ◄──── [Analisis Error Compiler]
```

1. **Jalankan Perintah Build**:
   Gunakan tool `bash` atau `ctx_execute` untuk menjalankan perintah build di direktori `app/`.
2. **Jika Kompilasi Gagal**:
   - Baca output error compiler (baris, kolom, tipe error, misalnya `error[E0425]: cannot find value`, TypeScript `TS2304`, dll.).
   - Jangan tanyakan ke pengguna! Perbaiki langsung file sumber menggunakan tool `edit`.
   - Jalankan build ulang.
   - Ulangi siklus ini hingga 3–5 iterasi sampai kompilasi berhasil 100%.

---

## 3. Verifikasi Fungsional

1. **Console Program (`RunsCheck`)**:
   - Uji program hasil build dengan argumen standar (misal `--help`, `-v`, atau input uji sederhana).
   - Pastikan teks output dan exit code konsisten dengan ekspektasi program asli.

2. **GUI Program (`LaunchCheck`)**:
   - Pastikan biner berhasil dikompilasi ke executable native.
   - Verifikasi tidak ada panik atau *unhandled exception* saat inisialisasi window.
