Oke, paham 👍
Masalahnya di screenshot itu formatting Markdown jadi berantakan (karena ada tanda `bash` yang bikin block code terlalu panjang).

Aku sudah rapikan `README.md` biar lebih clean dan mudah dibaca di GitHub:

---

````markdown
# Final Project - Mobile Development
## Aplikasi Admin Online Shop

Aplikasi sederhana berbasis Flutter untuk mengelola produk toko online.  
Dibuat sebagai final project bootcamp Flutter.

---

## ✨ Fitur
- **Autentikasi** dengan email & password (Firebase Authentication)
- **Registrasi (Sign Up)** dengan data tambahan (nama lengkap, username, email)
- **Home Page**
  - Menampilkan nama user
  - Menampilkan daftar produk dari Firestore
  - Tombol tambah produk
  - Tombol menuju profil
- **Profile Page**
  - Menampilkan data pengguna
  - Tombol logout
- **CRUD Produk**: tambah, edit, hapus produk

---

## 🚀 Cara Menjalankan
1. Clone repository
   ```bash
   git clone https://github.com/dikiyana/flutter_project.git
````

2. Masuk ke folder project

   ```bash
   cd flutter_project
   ```

3. Install dependencies

   ```bash
   flutter pub get
   ```

4. Konfigurasi Firebase

   * Aktifkan **Authentication (Email/Password)** di Firebase Console
   * Aktifkan **Cloud Firestore**
   * Jalankan konfigurasi Firebase:

     ```bash
     flutterfire configure
     ```

5. Jalankan aplikasi

   ```bash
   flutter run
   ```

---

## 📂 Struktur Project

```
lib/
 ├── blocs/                # State management (contoh: Auth BLoC)
 │    └── auth/
 ├── firebase/             # Service Firebase (Auth, Firestore, dsb)
 ├── models/               # Model data (User, Produk)
 ├── pages/                # Halaman UI (Login, Signup, Home, Profile, Form Produk)
 ├── repositories/         # Repository pattern untuk akses data
 ├── app.dart              # Root widget aplikasi
 ├── firebase_options.dart # Konfigurasi Firebase
 └── main.dart             # Entry point aplikasi
```

---

## 🛠 Teknologi

* [Flutter](https://flutter.dev)
* [Firebase Authentication](https://firebase.google.com/products/auth)
* [Cloud Firestore](https://firebase.google.com/products/firestore)
* [BLoC State Management](https://bloclibrary.dev)

---

## 👤 Author

**Dikiyana Pratama**
Bootcamp Flutter – Final Project

```


