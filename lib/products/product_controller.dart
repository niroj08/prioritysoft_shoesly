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

//update the change in the internet connectivity and if there seems to be any change do the needed
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;
    hasInternet.value = !result.contains(ConnectivityResult.none);

    if (hasInternet.value && databaseServie.collection == null) {
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

//prepare the list of string for the brand name which will be used in view to show in top filter section
  setBrandsNames() {
    getBrandsFromDb();
    dynamic brands = brandsDocument!.data().values;

    for (var brand in brands.first) {
      brandValue.add(brand['name']);
    }
  }

//prepare the list of products from the documents retrieved from firestore database
  setProducts() {
    getProductsFromDb();
    dynamic productsVal = prodcutsDocument!.data().values;

    for (var product in productsVal.first) {
      allProducts.add(ProductItem.fromJson(product));
      products.add(ProductItem.fromJson(product));
    }
  }

//images are stored locally and pass the brand name as argument to get the logo of the brand
  String getBrandImage(String brand) {
    return 'assets/brands/Name=$brand, Color=Grey.png';
  }

//images are store locally and pass the brand name as argument to get the image of the product
  String getProductImage(String brand) {
    return 'assets/product_images/Brand=$brand.png';
  }

//update the product list as per the user selection of the brand
  void onChangedBrandSelection(int val) {
    tag.value = val;
    products.clear();
    if (brandValue[val] == "All") {
      products.addAll(allProducts);
    } else {
      products.addAll(allProducts.where((element) =>
          element.brand!.toLowerCase() == brandValue[val].toLowerCase()));
    }
  }
}
