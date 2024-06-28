import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseServie {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>>? collection;

//get all the collection named shoesly from the firestore
  Future<bool> getCollectionData() async {
    collection = await db.collection("shoesly").get();
    return collection != null;
  }

//segregate brand document from the retrieved collection
  QueryDocumentSnapshot<Map<String, dynamic>>? getBrands() {
    QueryDocumentSnapshot<Map<String, dynamic>>? brands;
    if (collection != null) {
      brands = collection!.docs.firstWhere((element) => element.id == "brand");
    }
    return brands;
  }

//segregate product document from the retrieved collection
  QueryDocumentSnapshot<Map<String, dynamic>>? getProducts() {
    QueryDocumentSnapshot<Map<String, dynamic>>? products;
    if (collection != null) {
      products =
          collection!.docs.firstWhere((element) => element.id == "product");
    }
    return products;
  }
}
