import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseServie {
  
  FirebaseFirestore db = FirebaseFirestore.instance;
  dynamic collection;

  getCollectionData() {
    db.collection("shoesly").get().then((data) {
      collection = data;
    });
  }

  getBrands() {
    for (var doc in collection) {
      print("${doc.id} => ${doc.data()}");
    }
  }
}
