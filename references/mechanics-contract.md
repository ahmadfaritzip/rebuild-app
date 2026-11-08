# Craft Rebuild: Mechanics Contract & Evidence Grounding

Dalam filosofi Craft Anything (*Deep Mode*), rekonstruksi perangkat lunak harus berakar pada bukti faktual dari biner asli, bukan perkiraan acak. Setiap angka penting (konstanta, ukuran window, timeout, endpoint, parameter fisika/algoritma, batas retry) harus dicatat ke dalam `app/mechanics.json` dan `app/MECHANICS.md`.

---

## Format Schema `app/mechanics.json`

```json
{
  "version": 1,
  "values": [
    {
      "name": "window width",
      "group": "ui",
      "value": 1280,
      "unit": "px",
      "source": "function 0x140023a0"
    },
    {
      "name": "window height",
      "group": "ui",
      "value": 720,
      "unit": "px",
      "source": "function 0x140023a0"
    },
    {
      "name": "api timeout",
      "group": "network",
      "value": 5000,
      "unit": "ms",
      "source": "function 0x14005110"
    },
    {
      "name": "fallback theme",
      "group": "config",
      "value": "dark",
      "estimated": true
    }
  ]
}
```

---

## Aturan Baku (*Strict Contract*)

1. **Prioritas Dekompilasi Sebelum Estimasi**:
   - Cari nilai asli di biner menggunakan tool:
     - `native_strings_find` (mencari string label, format string, konstanta teks).
     - `native_function_pseudocode` (melihat dekompilasi pseudocode Ghidra).
     - `managed_members_list` (untuk aplikasi .NET / C#).
     - `js_app_map` (untuk aplikasi Electron / JS).
   - Nilai hanya boleh ditandai `"estimated": true` jika memang tidak ditemukan bukti eksplisit di dalam biner.

2. **Keterikatan Kode dengan Lembar Mekanik**:
   - Setiap nilai numerik yang memiliki atribut `source` **wajib digunakan di dalam kode sumber** (`src/main.rs`, `src/App.tsx`, dll.).
   - Jangan menuliskan angka yang berbeda di kode dari apa yang dicatat di `mechanics.json`.

3. **Dokumentasi Terbaca Manusia (`app/MECHANICS.md`)**:
   - Buat ringkasan Markdown `app/MECHANICS.md` yang merangkum parameter-parameter penting tersebut dalam format tabel:

| Nama Parameter | Kategori | Nilai | Satuan | Sumber Biner / Status |
|---|---|---|---|---|
| Window Width | UI | 1280 | px | `0x140023a0` |
| Window Height | UI | 720 | px | `0x140023a0` |
| API Timeout | Network | 5000 | ms | `0x14005110` |
| Fallback Theme | Config | dark | - | Estimated |
