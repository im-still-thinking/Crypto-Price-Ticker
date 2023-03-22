import 'package:bitcoin_ticker/utilities/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import '../utilities/coin_data.dart';
import '../utilities/reusable_card.dart';
import '../services/price.dart';

//ignore: must_be_immutable
class PriceScreen extends StatefulWidget {
  PriceScreen({this.price});

  List<int> price;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CryptoPrice cryptoPrice = CryptoPrice();

  String selectedCurrency = 'AUD';
  String rwCurr = 'AUD';

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList
          .map<DropdownMenuItem<String>>(
            (value) => DropdownMenuItem(
              child: Text(value),
              value: value,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() async {
          selectedCurrency = value;
          rwCurr = value;
          updatePrice();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          rwCurr = currenciesList[selectedIndex];
          updatePrice();
        });
      },
      children: currenciesList.map<Text>((value) => Text(value)).toList(),
    );
  }

  void updatePrice() async {
    var priceData;

    try {
      for (int i = 0; i < 3; i++) {
        priceData = await cryptoPrice.getPrice(cryptoList[i], rwCurr);
        widget.price[i] = priceData['rate'].toInt();
      }
    } catch (e) {
      print(e);
      for (int i = 0; i < 3; i++) {
        widget.price[i] = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ReusableCard(
            cryptoList[0],
            rwCurr,
            widget.price[0].toString(),
          ),
          ReusableCard(
            cryptoList[1],
            rwCurr,
            widget.price[1].toString(),
          ),
          ReusableCard(
            cryptoList[2],
            rwCurr,
            widget.price[2].toString(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
