<details>
<summary><b>🧩 Tugas 7 — Konsep Widget dan Struktur Flutter</b></summary>

### 1. Widget Tree dan Hubungan Parent–Child

Dalam Flutter, setiap elemen antarmuka—mulai dari teks, tombol, hingga keseluruhan aplikasi—merupakan **widget**. Seluruh widget disusun dalam struktur hierarki yang disebut **widget tree**, berbentuk seperti pohon dengan widget sebagai simpulnya.

Flutter memanfaatkan widget tree untuk membangun tampilan secara efisien. Ketika terjadi perubahan data, hanya widget yang terdampak yang akan dibangun ulang sehingga performa aplikasi tetap optimal.

Hubungan antar-widget disebut **parent–child relationship**:
- Widget **parent** membungkus satu atau lebih widget **child**
- Parent mengatur tata letak, ukuran, dan perilaku child
- Contoh: `Center` sebagai parent dan `Text` sebagai child

Beberapa widget seperti `Center`, `Container`, dan `Padding` hanya memiliki satu child, sedangkan `Column`, `Row`, dan `GridView` dapat memiliki banyak child. Sebuah widget dapat berperan sebagai parent sekaligus child tergantung posisinya dalam widget tree.

---

### 2. Widget yang Digunakan dan Fungsinya

#### 2.1 menu.dart
- **Scaffold**: Kerangka utama halaman (AppBar dan body)
- **AppBar**: Bagian atas halaman dengan judul *Mysterious Football Store*
- **Text**: Menampilkan teks
- **Padding**: Memberi jarak di sekitar widget
- **Column / Row**: Menyusun widget secara vertikal / horizontal
- **SizedBox**: Memberi jarak kosong antar-elemen
- **Card**: Menampilkan konten berbentuk kartu
- **Icon**: Menampilkan ikon grafis
- **RichText & TextSpan**: Menampilkan teks dengan berbagai gaya
- **GridView.count**: Menampilkan menu dalam bentuk grid
- **Material**: Memberikan gaya Material Design
- **InkWell**: Memberi efek sentuhan (ripple)
- **Container**: Mengatur ukuran, padding, dan dekorasi
- **SnackBar & ScaffoldMessenger**: Menampilkan notifikasi singkat
- **Center**: Memposisikan child di tengah layar

#### 2.2 main.dart
- **MaterialApp**: Root aplikasi berbasis Material Design
- **MyApp**: Root widget utama
- **MyHomePage**: Halaman utama dengan Scaffold dan AppBar

---

### 3. Fungsi MaterialApp sebagai Root Widget

MaterialApp merupakan pembungkus utama aplikasi Flutter yang:
- Mengatur tema global
- Menyediakan sistem navigasi
- Mengatur bahasa dan struktur aplikasi

Tanpa MaterialApp, widget seperti `Scaffold` dan `Theme` tidak dapat digunakan. Properti seperti `theme`, `title`, `home`, dan `routes` membuat pengelolaan aplikasi menjadi konsisten dan terstruktur.

---

### 4. Perbedaan StatelessWidget dan StatefulWidget

- **StatelessWidget**
  - Tidak memiliki state
  - Tampilan tidak berubah
  - Cocok untuk elemen statis (teks, ikon)

- **StatefulWidget**
  - Memiliki state yang dapat berubah
  - Menggunakan `setState()` untuk memperbarui UI
  - Cocok untuk komponen interaktif (form, counter)

---

### 5. BuildContext dan Perannya

BuildContext merepresentasikan posisi widget dalam widget tree. BuildContext digunakan untuk:
- Mengakses tema (`Theme.of(context)`)
- Navigasi (`Navigator.of(context)`)
- Mengakses data dari widget di atasnya

Dengan BuildContext, Flutter mengetahui hubungan antar-widget dan dapat membangun UI secara benar.

---

### 6. Hot Reload vs Hot Restart

- **Hot Reload**
  - Memperbarui UI tanpa menghilangkan state
  - Cocok untuk perubahan kecil

- **Hot Restart**
  - Menginisialisasi ulang aplikasi
  - Menghapus seluruh state
  - Cocok untuk perubahan besar pada struktur aplikasi

</details>

<details>
<summary><b>⚙️ Tugas 8 — Navigasi, Layout, dan Tema Aplikasi</b></summary>

### 1. Perbedaan Navigator.push() dan Navigator.pushReplacement()

- **Navigator.push()**
  - Menambah halaman ke stack navigasi
  - Pengguna dapat kembali ke halaman sebelumnya

- **Navigator.pushReplacement()**
  - Mengganti halaman saat ini
  - Halaman sebelumnya dihapus dari stack

Pada aplikasi *Mysterious Football Store*:
- `Navigator.push()` digunakan untuk membuka form tambah produk
- `Navigator.pushReplacement()` digunakan setelah submit agar tidak kembali ke form

---

### 2. Hierarki Scaffold, AppBar, dan Drawer

- **Scaffold**: Kerangka utama halaman
- **AppBar**: Menampilkan judul halaman
- **Drawer**: Menu navigasi samping

Kombinasi ketiganya menciptakan tampilan yang konsisten, terstruktur, dan mudah digunakan.

---

### 3. Kelebihan Layout Widget

- **Padding**: Merapikan jarak antar-elemen
- **SingleChildScrollView**: Memungkinkan form panjang tetap bisa discroll
- **ListView**: Menampilkan daftar data dengan scroll bawaan

Pada halaman *Add Product Form*, widget tersebut dikombinasikan agar tampilan tetap responsif di berbagai ukuran layar.

---

### 4. Penyesuaian Tema dan Identitas Visual

Aplikasi menggunakan tema warna neon sebagai identitas visual:
- Warna utama: AppBar dan tombol
- Warna sekunder: Drawer dan elemen pendukung

Pengaturan dilakukan melalui `ThemeData` di `main.dart` dan diakses menggunakan `Theme.of(context).colorScheme`.

</details>

<details>
<summary><b>🔐 Tugas 9 — Integrasi Flutter dengan Backend Django</b></summary>

### 1. Alasan Menggunakan Model Dart untuk JSON

Model Dart digunakan untuk mengubah JSON yang tidak bertipe menjadi objek Dart bertipe jelas.

Tanpa model (`Map<String, dynamic>`):
- Tidak ada validasi tipe
- Rentan typo pada key JSON
- Sulit dipelihara saat proyek membesar

Dengan model Dart:
- Struktur data terdokumentasi
- Mendukung null-safety
- Lebih aman dan mudah dikembangkan

---

### 2. Perbedaan Package http dan CookieRequest

- **http**
  - Request stateless
  - Tidak menyimpan sesi atau cookie

- **CookieRequest**
  - Mengelola cookie session Django
  - Digunakan untuk autentikasi

---

### 3. Alasan CookieRequest Dibagikan dengan Provider

Jika setiap halaman membuat CookieRequest baru:
- Session hilang
- Django menganggap user belum login

Solusi:
- Gunakan **Provider**
- Satu instance CookieRequest untuk seluruh aplikasi

---

### 4. Konfigurasi Konektivitas Flutter ↔ Django

#### 4.1 ALLOWED_HOSTS
- Tambahkan `10.0.2.2` untuk emulator Android

#### 4.2 CORS
- Mengizinkan request lintas domain/port

#### 4.3 Cookie & SameSite
- Gunakan `SAMESITE=None` agar cookie terkirim

#### 4.4 Permission Internet
- Tambahkan izin internet di AndroidManifest.xml

Kesalahan konfigurasi dapat menyebabkan:
- Connection refused
- 403 Forbidden
- Login gagal

---

### 5. Alur Pengiriman dan Penampilan Data

1. User mengisi form di Flutter
2. Data divalidasi dan diubah ke JSON
3. POST dikirim ke Django via CookieRequest
4. Django memproses dan mengirim JSON
5. Flutter melakukan GET
6. JSON diubah menjadi model Dart
7. Data ditampilkan dengan ListView / FutureBuilder

---

### 6. Mekanisme Autentikasi

#### 6.1 Register
- Flutter kirim data
- Django buat user
- User diarahkan ke login

#### 6.2 Login
- Flutter kirim username & password
- Django buat session
- Cookie disimpan oleh CookieRequest

#### 6.3 Logout
- Flutter panggil logout
- Django hapus session
- User kembali ke halaman login

---

### 7. Langkah Implementasi

1. Konfigurasi Django (CORS, cookie, ALLOWED_HOSTS)
2. Buat endpoint login, register, logout (JSON)
3. Setup Flutter (Provider, http, pbp_django_auth)
4. Bagikan CookieRequest dengan Provider
5. Buat model Dart
6. Implementasi halaman produk dan form
7. Tambahkan filter “My Products”
8. Lengkapi navigasi aplikasi

</details>
