import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String cryptoBTC = '0.0';
  String cryptoETH = '0.0';
  String cryptoLTC = '0.0';

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String typeofCurrency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(typeofCurrency),
        value: typeofCurrency,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getCurrencyConverted();
        });
      },
    );
  }

  CupertinoPicker iosPickerItem() {
    List<Text> pickerItem = [];
    for (String typeofCurrency in currenciesList) {
      var newItem = Text(typeofCurrency);
      pickerItem.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 35.0,
      onSelectedItemChanged: (valueIndex) {},
      children: pickerItem,
    );
  }

  whichOS() {
    if (Platform.isIOS) {
      return iosPickerItem();
    } else if (Platform.isAndroid) {
      return androidDropDown();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyConverted();
  }

  getCurrencyConverted() async {
    var currencyData = await CoinData().getConversionRates(selectedCurrency);

    setState(() {
      cryptoBTC = currencyData[0].toStringAsFixed(2);
      cryptoETH = currencyData[1].toStringAsFixed(2);
      cryptoLTC = currencyData[2].toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: currencyCardWidget(
                cryptoType: 'BTC',
                cryptoValue: cryptoBTC,
                selectedCurrency: selectedCurrency),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: currencyCardWidget(
                  cryptoType: 'ETH',
                  cryptoValue: cryptoETH,
                  selectedCurrency: selectedCurrency)),
          Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: currencyCardWidget(
                  cryptoType: 'LTC',
                  cryptoValue: cryptoLTC,
                  selectedCurrency: selectedCurrency)),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: whichOS(),
          ),
        ],
      ),
    );
  }
}

class currencyCardWidget extends StatelessWidget {
  const currencyCardWidget({
    @required this.cryptoValue,
    @required this.selectedCurrency,
    @required this.cryptoType,
  });

  final String cryptoValue;
  final String selectedCurrency;
  final String cryptoType;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoType = $cryptoValue $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
