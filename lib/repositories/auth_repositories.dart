import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepositories {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepositories({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get user => _firebaseAuth.authStateChanges();

  Future<void> signUp(
    String namaLengkap,
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    // 1. Buat user di Firebase Auth
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user?.uid;
    if (uid == null) {
      throw Exception("Gagal membuat user");
    }

    // 2. Simpan data tambahan di Firestore
    await _firestore.collection('users').doc(uid).set({
      'nama_lengkap': namaLengkap,
      'username': username,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
