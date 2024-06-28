import 'dart:async';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prioritysoft_shoesly/repository/firestore_database.dart';

class ProductController extends GetxController {
  RxBool hasInternet = false.obs;
  RxBool isCollecitonLoading = true.obs;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  FirestoreDatabaseServie databaseServie = FirestoreDatabaseServie();

  RxInt tag = 0.obs;

  RxList<String> brandValue = ["All"].obs;
  QueryDocumentSnapshot<Map<String, dynamic>>? brandsDocument;

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
        }
      });
    }

    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  getBrands() {
    brandsDocument = databaseServie.getBrands();
  }

  setBrandsNames() {
    getBrands();
   dynamic brands = brandsDocument!.data().values;

    for (var brand in brands.first) {
      brandValue.add(brand['name']);
    }
    return brandValue;
  }
}
