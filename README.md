<details> <summary><b>🧩 Tugas 7 — Konsep Widget dan Struktur Flutter</b></summary>
Apa itu Widget Tree dan Hubungan Parent–Child

Dalam Flutter, setiap elemen antarmuka — mulai dari teks, tombol, hingga keseluruhan aplikasi — merupakan widget. Semua widget disusun dalam bentuk hierarki yang disebut widget tree. Struktur ini berbentuk seperti pohon di mana setiap simpulnya adalah widget.

Flutter menggunakan konsep ini untuk membangun tampilan aplikasi secara efisien. Ketika terjadi perubahan, misalnya data diperbarui, hanya widget yang terpengaruh yang akan dibangun ulang. Hal ini membuat performa aplikasi menjadi lebih optimal.

Hubungan antar-widget dikenal sebagai parent–child relationship. Satu widget induk (parent) dapat membungkus satu atau beberapa widget anak (child). Parent mengatur posisi, ukuran, dan perilaku anak-anaknya. Contohnya, dalam susunan “Center dengan Text di dalamnya,” widget Center berperan sebagai parent dan Text sebagai child. Beberapa widget seperti Center, Container, dan Padding hanya memiliki satu child, sedangkan widget seperti Column, Row, dan GridView dapat memiliki banyak child sekaligus. Sebuah widget juga bisa menjadi parent sekaligus child tergantung konteksnya di dalam struktur aplikasi.

Widget yang Digunakan dan Fungsinya

menu.dart
Scaffold berfungsi sebagai kerangka utama halaman yang menyediakan struktur dasar seperti AppBar dan Body.
AppBar menampilkan bagian atas halaman yang berisi judul “Turboa Shop.”
Text digunakan untuk menampilkan tulisan di layar.
Padding memberi jarak di sekitar elemen agar tidak menempel pada tepi layar.
Column menyusun elemen secara vertikal, sedangkan Row menyusunnya secara horizontal.
SizedBox digunakan sebagai jarak kosong antar-elemen.
Card menampilkan konten berbentuk kartu dengan bayangan lembut.
Icon menampilkan simbol grafis seperti ikon profil atau tombol.
RichText dan TextSpan memungkinkan teks dengan beberapa gaya dalam satu baris.
GridView.count menampilkan menu dalam bentuk grid agar tampilan lebih rapi.
Material memberi gaya khas Material Design, dan InkWell menambahkan efek sentuhan (ripple).
Container mengatur ukuran, padding, dan dekorasi dari widget lain.
SnackBar dan ScaffoldMessenger menampilkan notifikasi singkat di bagian bawah layar.
Center memposisikan widget anak di tengah area tampilan.

main.dart
MaterialApp menjadi akar aplikasi Flutter berbasis Material Design, mengatur tema, navigasi, dan halaman awal.
MyApp adalah root widget utama yang memanggil MaterialApp.
MyHomePage menampilkan halaman utama dengan struktur Scaffold, AppBar, dan konten utama.

Fungsi MaterialApp dan Alasan Menjadi Root Widget

MaterialApp adalah pembungkus utama aplikasi Flutter yang menyediakan kerangka desain Material Design. Ia mengatur tema global, navigasi, bahasa, serta struktur dasar aplikasi. Tanpa MaterialApp, banyak widget seperti Scaffold atau Theme tidak akan berfungsi.
Melalui properti seperti theme, title, home, dan routes, MaterialApp membuat tampilan aplikasi menjadi konsisten dan memudahkan pengelolaan navigasi. Widget ini menjadi root karena menyediakan konteks yang dibutuhkan widget lain untuk mengakses tema dan sistem navigasi.

Perbedaan StatelessWidget dan StatefulWidget

StatelessWidget digunakan untuk tampilan yang tidak berubah selama aplikasi berjalan. Ia cocok untuk elemen statis seperti teks, ikon, atau logo yang tidak memerlukan pembaruan data.

StatefulWidget digunakan untuk tampilan yang dapat berubah tergantung interaksi pengguna atau data dinamis. Ia memiliki dua bagian: kelas widget itu sendiri dan kelas state yang menyimpan data dinamis. Saat data berubah, fungsi setState() dipanggil untuk memperbarui tampilan.

Secara sederhana, StatelessWidget digunakan untuk antarmuka yang tetap, sedangkan StatefulWidget digunakan untuk komponen interaktif seperti form input atau counter.

BuildContext dan Perannya

BuildContext adalah objek yang menunjukkan posisi suatu widget dalam struktur widget tree. Ia digunakan untuk mengakses informasi dari widget di atasnya, seperti tema, navigasi, atau data yang dibagikan.
Misalnya, pemanggilan Theme.of(context) memanfaatkan BuildContext untuk mendapatkan tema dari MaterialApp.
Dengan BuildContext, Flutter dapat mengetahui bagaimana widget diatur dan saling terhubung, sehingga dapat menampilkan dan memperbarui elemen dengan benar.

Hot Reload vs Hot Restart

Hot reload memungkinkan perubahan kode terlihat secara langsung tanpa kehilangan state aplikasi. Ini digunakan untuk memperbarui tampilan atau logika kecil dengan cepat.
Hot restart memulai ulang seluruh aplikasi dan menghapus state yang ada. Ini cocok digunakan setelah melakukan perubahan besar pada struktur aplikasi atau logika awal.
Perbedaannya, hot reload mempertahankan state sedangkan hot restart menginisialisasi ulang semuanya dari awal.

</details>
<details> <summary><b>⚙️ Tugas 8 — Navigasi, Layout, dan Tema Aplikasi</b></summary>
Perbedaan Navigator.push() dan Navigator.pushReplacement()

Keduanya digunakan untuk navigasi antarhalaman, namun memiliki perbedaan cara kerja. Navigator.push() menambahkan halaman baru di atas halaman aktif sehingga pengguna bisa kembali ke halaman sebelumnya dengan tombol back.
Navigator.pushReplacement() menggantikan halaman yang sedang aktif dengan halaman baru dan menghapus halaman sebelumnya dari tumpukan, sehingga pengguna tidak dapat kembali lagi.

Dalam aplikasi Football Shop, Navigator.push() digunakan ketika pengguna membuka form tambah produk agar bisa kembali ke halaman utama setelahnya.
Sedangkan Navigator.pushReplacement() digunakan setelah pengguna menyimpan produk agar diarahkan kembali ke halaman utama tanpa bisa kembali ke form lama.

Hierarki Scaffold, AppBar, dan Drawer

Konsistensi desain dijaga dengan memanfaatkan kombinasi Scaffold, AppBar, dan Drawer. Scaffold menjadi kerangka utama yang menyediakan AppBar di bagian atas dan Drawer di sisi kiri.
AppBar menampilkan judul halaman seperti “Turboa Shop” atau “Add Product Form” agar pengguna selalu tahu konteks halaman yang dibuka.
Drawer berfungsi sebagai menu navigasi yang memudahkan pengguna berpindah antarhalaman tanpa kembali ke menu utama. Kombinasi ketiganya membuat seluruh halaman tampak seragam, terstruktur, dan mudah digunakan.

Kelebihan Layout Widget (Padding, SingleChildScrollView, ListView)

Padding digunakan untuk memberi jarak antar-elemen agar tampilan lebih rapi dan nyaman dilihat.
SingleChildScrollView memungkinkan tampilan form yang panjang tetap bisa digulir sehingga semua elemen bisa diakses di layar kecil.
ListView cocok untuk menampilkan daftar elemen yang panjang karena memiliki kemampuan scroll bawaan.
Dalam halaman Add Product Form, kombinasi Padding, SingleChildScrollView, dan Column digunakan agar form tetap responsif dan tidak berantakan di berbagai ukuran layar.

Penyesuaian Tema dan Identitas Visual

Agar aplikasi memiliki identitas visual yang konsisten, digunakan tema warna yang sesuai dengan brand Turboa Shop, yaitu biru tua sebagai warna primer dan biru muda sebagai warna sekunder.
Warna primer digunakan pada AppBar dan tombol utama, sedangkan warna sekunder digunakan pada Drawer dan elemen pendukung.
Pengaturan warna dilakukan melalui ThemeData di file main.dart, dan seluruh elemen mengakses warna tema melalui Theme.of(context).colorScheme.
Dengan penerapan ini, aplikasi memiliki tampilan yang seragam, profesional, dan mencerminkan identitas toko secara konsisten di semua halaman.

</details>