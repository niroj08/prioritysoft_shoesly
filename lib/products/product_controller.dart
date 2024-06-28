import 'dart:async';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prioritysoft_shoesly/repository/firestore_database.dart';
import 'package:prioritysoft_shoesly/repository/model/product.dart';

class ProductController extends GetxController {
  RxBool hasInternet = false.obs;
  RxBool isCollecitonLoading = true.obs;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  FirestoreDatabaseServie databaseServie = FirestoreDatabaseServie();

  RxInt tag = 0.obs;
  List<String> brandValue = ["All"];
  QueryDocumentSnapshot<Map<String, dynamic>>? brandsDocument;
  QueryDocumentSnapshot<Map<String, dynamic>>? prodcutsDocument;

  RxList<ProductItem> products = <ProductItem>[].obs;
  List<ProductItem> allProducts = [];

  @override
  void onInit() {
    super.onInit();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;
    hasInternet.value = !result.contains(ConnectivityResult.none);

    if (hasInternet.value) {
      databaseServie.getCollectionData().then((onValue) {
        if (onValue) {
          isCollecitonLoading.value = !onValue;
          setBrandsNames();
          setProducts();
        }
      });
    }

    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  getBrandsFromDb() {
    brandsDocument = databaseServie.getBrands();
  }

  getProductsFromDb() {
    prodcutsDocument = databaseServie.getProducts();
  }

  setBrandsNames() {
    getBrandsFromDb();
    dynamic brands = brandsDocument!.data().values;

    for (var brand in brands.first) {
      brandValue.add(brand['name']);
    }
  }

  setProducts() {
    getProductsFromDb();
    dynamic productsVal = prodcutsDocument!.data().values;

    for (var product in productsVal.first) {
      allProducts.add(ProductItem.fromJson(product));
      products.add(ProductItem.fromJson(product));
    }
  }

  String getBrandImage(int index) {
    return 'assets/brands/Name=${products[index].brand!}, Color=Grey.png';
  }

  String getProductImage(int index) {
    return 'assets/product_images/Brand=${products[index].brand!}.png';
  }

  void onChangedBrandSelection(int val) {
    tag.value = val;
    products.clear();
    if (brandValue[val] == "All") {
      products.addAll(allProducts);
    } else {
      products.addAll(allProducts
          .where((element) => element.brand!.toLowerCase() == brandValue[val].toLowerCase()));
    }
  }
}
