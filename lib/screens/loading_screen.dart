import 'dart:io';

import 'package:bitcoin_ticker/screens/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bitcoin_ticker/services/price.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<int> price = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    getPriceData();
  }

  void getPriceData() async {
    var priceData;
    CryptoPrice cryptoPrice = CryptoPrice();

    try {
      for (int i = 0; i < 3; i++) {
        priceData = await cryptoPrice.getPrice(cryptoList[i], 'AUD');
        price[i] = priceData['rate'].toInt();
      }

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PriceScreen(price: price)));
    } catch (e) {
      print(e);
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}
