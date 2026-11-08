# Craft Rebuild: Supported Tech Stacks & Scaffold Reference

Daftar tech stack resmi yang didukung dalam workflow rekonstruksi Craft Anything (diadaptasi langsung dari `stacks.toml`), struktur direktori di `app/`, dan perintah verifikasi build.

---

## 1. Rust (console)
**Penggunaan:** Program CLI / terminal tanpa jendela grafis.
- **Deteksi Target:** Biner konsol (misal CLI tools, parser, utility).
- **Struktur Direktori:**
  ```text
  app/
  ├── Cargo.toml
  └── src/
      └── main.rs
  ```
- **Manifest (`Cargo.toml`):**
  ```toml
  [package]
  name = "rebuilt-cli"
  version = "0.1.0"
  edition = "2021"

  [dependencies]
  clap = { version = "4.5", features = ["derive"] }
  anyhow = "1.0"
  ```
- **Aturan Implementasi:**
  - Baca argumen via `std::env::args()` atau `clap`.
  - Cetak output ke `stdout` dan `stderr` identik dengan biner aslinya.
  - Gunakan `std::process::exit(code)` dengan exit code yang sama dengan aslinya.
- **Verifikasi Build:**
  ```bash
  cargo build --quiet
  ```

---

## 2. Rust + egui (eframe)
**Penggunaan:** Program desktop GUI native Windows/Linux/macOS dengan kinerja tinggi.
- **Deteksi Target:** GUI desktop native default.
- **Struktur Direktori:**
  ```text
  app/
  ├── Cargo.toml
  └── src/
      └── main.rs
  ```
- **Manifest (`Cargo.toml`):**
  ```toml
  [package]
  name = "rebuilt-app"
  version = "0.1.0"
  edition = "2021"

  [dependencies]
  eframe = "0.30"
  egui = "0.30"
  ```
- **Aturan Implementasi:**
  - Buat struct aplikasi yang mengimplementasikan `eframe::App`.
  - Desain antarmuka (layout, tombol, panel, form, warna) menyerupai target biner asli.
- **Verifikasi Build:**
  ```bash
  cargo build --quiet
  ```

---

## 3. Rust + macroquad
**Penggunaan:** Game 2D/3D ringan atau simulasi grafis real-time.
- **Struktur Direktori:**
  ```text
  app/
  ├── Cargo.toml
  └── src/
      └── main.rs
  ```
- **Manifest (`Cargo.toml`):**
  ```toml
  [package]
  name = "rebuilt-game"
  version = "0.1.0"
  edition = "2021"

  [dependencies]
  macroquad = "0.4"
  ```
- **Verifikasi Build:**
  ```bash
  cargo build --quiet
  ```

---

## 4. Next.js + TypeScript (Static Export)
**Penggunaan:** Website, web portal, atau web dashboard.
- **Struktur Direktori:**
  ```text
  app/
  ├── package.json
  ├── next.config.mjs
  ├── tsconfig.json
  └── src/
      └── app/
          ├── layout.tsx
          └── page.tsx
  ```
- **Manifest (`package.json`):**
  ```json
  {
    "name": "rebuilt-site",
    "version": "0.1.0",
    "private": true,
    "scripts": {
      "build": "next build"
    },
    "dependencies": {
      "next": "^15.0.0",
      "react": "^19.0.0",
      "react-dom": "^19.0.0"
    }
  }
  ```
- **Konfigurasi (`next.config.mjs`):**
  ```js
  /** @type {import('next').NextConfig} */
  const nextConfig = {
    output: 'export',
    trailingSlash: true,
    images: { unoptimized: true }
  };
  export default nextConfig;
  ```
- **Verifikasi Build:**
  ```bash
  npm install && npm run build
  # Hasil statis harus berada di app/out
  ```

---

## 5. React + TypeScript (Vite)
**Penggunaan:** Single Page Application (SPA), dashboard interaktif, front-end web app.
- **Struktur Direktori:**
  ```text
  app/
  ├── package.json
  ├── vite.config.ts
  ├── tsconfig.json
  ├── index.html
  └── src/
      ├── main.tsx
      └── App.tsx
  ```
- **Manifest (`package.json`):**
  ```json
  {
    "name": "rebuilt-vite-app",
    "version": "0.1.0",
    "private": true,
    "scripts": {
      "build": "tsc -b && vite build"
    },
    "dependencies": {
      "react": "^19.0.0",
      "react-dom": "^19.0.0"
    },
    "devDependencies": {
      "@vitejs/plugin-react": "^4.3.0",
      "typescript": "^5.6.0",
      "vite": "^6.0.0"
    }
  }
  ```
- **Konfigurasi (`vite.config.ts`):**
  ```ts
  import { defineConfig } from 'vite';
  import react from '@vitejs/plugin-react';

  export default defineConfig({
    plugins: [react()],
    base: './'
  });
  ```
- **Verifikasi Build:**
  ```bash
  npm install && npm run build
  # Hasil build harus berada di app/dist
  ```

---

## 6. Electron
**Penggunaan:** Aplikasi desktop cross-platform berbasis web/Node.js.
- **Struktur Direktori:**
  ```text
  app/
  ├── package.json
  ├── main.js (atau main.ts)
  ├── preload.js
  ├── index.html
  └── renderer.js
  ```
- **Aturan Implementasi:**
  - Jaga `contextIsolation: true` dan `nodeIntegration: false`.
  - Komunikasi antara window dan node backend harus melalui `preload.js` dan `ipcRenderer`/`ipcMain`.
- **Verifikasi Build:**
  ```bash
  npm install && npm run build
  ```

---

## 7. Python
**Penggunaan:** Program CLI, script analitik, backend service, atau toolkit.
- **Struktur Direktori:**
  ```text
  app/
  ├── pyproject.toml
  ├── requirements.txt
  └── src/
      └── main.py
  ```
- **Verifikasi Build:**
  ```bash
  python -m py_compile src/*.py
  ```

---

## 8. Tambahan Styling / UI Components

### shadcn/ui + Tailwind CSS
- Digunakan saat pengguna meminta desain modern bergaya shadcn/tailwind.
- Variabel CSS (`--background`, `--primary`, `--radius`, dll.) disesuaikan dengan warna dan ukuran token biner/web asli.
- Inisialisasi:
  ```bash
  npx shadcn@latest init --yes --defaults
  ```
