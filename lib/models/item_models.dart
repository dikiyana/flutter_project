import 'package:cloud_firestore/cloud_firestore.dart';

class Item{
  final String id;
  final String nama;
  final String deskripsi;

  Item({required this.id, required this.nama, required this.deskripsi});

  factory Item.fromDoc(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id, 
      nama: data['nama'], 
      deskripsi: data['deskripsi']
    );
  }
  Map<String, dynamic> toMap(){
    return{
      'nama': nama,
      'deskripsi': deskripsi,
      'createdAt': FieldValue.serverTimestamp()
    };
  }
}