# TodoList Pro

![TodoList Pro](https://img.shields.io/badge/Flutter-Framework-blue?style=flat-square&logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Cloud-yellow?style=flat-square&logo=firebase)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

**TodoList Pro** adalah aplikasi manajemen tugas berbasis Flutter yang dirancang untuk membantu meningkatkan produktivitas Anda. Proyek ini merupakan bagian dari tugas akademik oleh **Fatwa Reksa Aji Pradana (NIM: A11202214393)**.

---

## 📜 Fitur Utama

- **Manajemen Tugas yang Mudah**: Tambahkan, edit, dan hapus tugas Anda dengan antarmuka yang intuitif.
- **Undo Penghapusan**: Batalkan penghapusan tugas secara langsung.
- **Dark Mode dengan Glassmorphism**: Antarmuka yang modern dengan tema gelap dan efek kaca.
- **Real-Time Sync**: Integrasi dengan Firebase untuk sinkronisasi data.
- **Desain Responsif**: Dapat digunakan di berbagai perangkat.

---

## 🛠️ Teknologi yang Digunakan

- **Flutter**: Framework utama untuk pengembangan antarmuka.
- **Dart**: Bahasa pemrograman yang digunakan dalam Flutter.
- **Firebase**: Backend untuk autentikasi dan penyimpanan data.
- **Google Fonts**: Untuk penggunaan font yang estetis.

---

## 📂 Struktur Proyek

```plaintext
todolist_app/
├── android/                # Konfigurasi proyek Android
├── ios/                    # Konfigurasi proyek iOS
├── lib/                    # Sumber kode aplikasi Flutter
│   ├── helpers/            # Logika database lokal
│   ├── models/             # Definisi model data (Todo)
│   ├── screens/            # Halaman utama aplikasi (LandingPage, TodoPage)
│   ├── widgets/            # Widget yang dapat digunakan ulang (TodoForm, TodoListItem)
│   └── main.dart           # Entry point aplikasi
├── pubspec.yaml            # Konfigurasi dependencies
└── README.md               # Dokumentasi proyek
```

---

## 🚀 Cara Menjalankan Proyek

### 1. Kloning Repositori
Kloning repositori ini ke komputer lokal Anda menggunakan perintah berikut:
```bash
git clone https://github.com/Hessaajipradanadana/todopro.git
cd todolist-pro
```

### 2. Instal Dependencies
Pastikan Anda telah menginstal **Flutter SDK**. Kemudian jalankan perintah berikut untuk menginstal semua dependencies yang diperlukan:
```bash
flutter pub get
```

### 3. Konfigurasi Firebase
1. Tambahkan file **google-services.json** ke folder `android/app/`.
2. Tambahkan file **GoogleService-Info.plist** ke folder `ios/Runner/`.

Jika Anda belum memiliki konfigurasi Firebase, ikuti langkah berikut:
- Buat proyek di [Firebase Console](https://console.firebase.google.com/).
- Ikuti panduan untuk menyiapkan Firebase untuk Flutter di [dokumentasi resmi Firebase](https://firebase.google.com/docs/flutter/setup).

### 4. Jalankan Aplikasi
Jalankan aplikasi di emulator atau perangkat fisik dengan perintah:
```bash
flutter run
```

---

## 🎨 Tangkapan Layar

### Halaman Landing
![Landing Page](https://via.placeholder.com/800x400?text=Landing+Page)

### Halaman Todo
![Todo Page](https://via.placeholder.com/800x400?text=Todo+Page)

---

## 🧑‍💻 Pengembang

Proyek ini dikembangkan oleh:

- **Fatwa Reksa Aji Pradana**  
  - **NIM**: A11202214393  
  - **Email**: [ajipradana5256@gmail.com](mailto:ajipradana5256@gmail.com)  
  - **GitHub**: [Hessaajipradana](https://github.com/Hessaajipradana)

---

## 📄 Lisensi

Proyek ini dilisensikan di bawah **MIT License**. Lihat file [LICENSE](LICENSE) untuk informasi lebih lanjut.

---

## 🌟 Kontribusi

Kontribusi sangat dihargai! Silakan buat pull request atau diskusikan di [issues](https://github.com/Hessaajipradana/todolist-pro/issues).

---

## 🔗 Referensi

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Google Fonts](https://fonts.google.com/)
