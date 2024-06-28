import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseServie {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>>? collection;

  Future<bool> getCollectionData() async {
    collection = await db.collection("shoesly").get();
    return collection != null;
  }

  QueryDocumentSnapshot<Map<String, dynamic>>? getBrands() {
    QueryDocumentSnapshot<Map<String, dynamic>>? brands;
    if (collection != null) {
      brands = collection!.docs.firstWhere((element) => element.id == "brand");
    }
    return brands;
  }

  QueryDocumentSnapshot<Map<String, dynamic>>? getProducts() {
    QueryDocumentSnapshot<Map<String, dynamic>>? products;
    if (collection != null) {
      products =
          collection!.docs.firstWhere((element) => element.id == "product");
    }
    return products;
  }
}
