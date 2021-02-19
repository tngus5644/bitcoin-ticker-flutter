import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int coinPrice;
  CoinData coinData = CoinData();
  Map cryptoMap = {};
  @override
  void initState() {
    super.initState();
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
        children: makeCards(),
        // Platform.isIOS ? iOSPicker() : androidDropdown()
      ),
    );
  }

  List<Widget> makeCards() {
    List<Widget> cryptoCards = [];
    for (String i in cryptoList) {
      cryptoCards.add(CryptoCards(
        cryptoList: i,
        crypto: cryptoMap[i],
        selectedCurrency: selectedCurrency,
      ));
    }
    cryptoCards.add(Container(
        height: 150.0,
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 30.0),
        color: Colors.lightBlue,
        child: androidDropdown()));
    return cryptoCards;
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String i in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) async {
        cryptoMap = await coinData.getCoinData(value);
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItems = [];
    for (String i in currenciesList) {
      pickerItems.add(Text(i));
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
          });
          coinData.getCoinData(selectedCurrency);
        },
        children: pickerItems);
  }
}

class CryptoCards extends StatelessWidget {
  const CryptoCards({
    Key key,
    @required this.cryptoList,
    @required this.crypto,
    @required this.selectedCurrency,
  }) : super(key: key);
  final String cryptoList;
  final double crypto;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoList = $crypto $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
