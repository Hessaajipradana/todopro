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
