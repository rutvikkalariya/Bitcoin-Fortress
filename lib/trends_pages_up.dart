// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dashboard_helper.dart';
import 'localization/app_localizations.dart';
import 'models/Bitcoin.dart';
import 'models/PortfolioBitcoin.dart';
import 'package:collection/collection.dart';
import 'util/color_util.dart'; // You have to add this manually, for some reason it cannot be added automatically

class TrendPage extends StatefulWidget {
  const TrendPage({Key? key}) : super(key: key);

  @override
  _TrendPageState createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  int buttonType = 3;
  String name = "";
  String step2 = "";
  double coin = 0;
  String result = '';
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String? currencyNameForImage;
  String _type = "Week";
  List<LinearSales> currencyData = [];
  List<Bitcoin> bitcoinList = [];
  double diffRate = 0;
  String? ApiUrl = 'http://45.34.15.25:8080';
  List<PortfolioBitcoin> items = [];

  final dbHelper = DatabaseHelper.instance;

  SharedPreferences? sharedPreferences;
  @override
  void initState() {
    callBitcoinApi();
    super.initState();
    coinCountTextEditingController = TextEditingController();
    dbHelper.queryAllRows().then((notes) {
      notes.forEach((note) {
        items.add(PortfolioBitcoin.fromMap(note));
        // totalValuesOfPortfolio = totalValuesOfPortfolio + note["total_value"];
      });
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var analytics = FirebaseAnalytics.instance;
      analytics.logEvent(name: 'open_trends');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  // color: getColorFromHex("#21242D"),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/images/cob.png'),
                          image: NetworkImage(
                              "$ApiUrl/Bitcoin/resources/icons/${currencyNameForImage.toString().toLowerCase()}.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                        ),
                        Text(
                          "$coin",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: getColorFromHex("#4A41F4"))),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        decoration: BoxDecoration(
                          color: getColorFromHex("#2AEFB4"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(diffRate < 0 ? '-' : "+",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: diffRate < 0
                                            ? Colors.black
                                            : Colors.black))),
                            Icon(Icons.attach_money,
                                size: 16,
                                color:
                                    diffRate < 0 ? Colors.black : Colors.black),
                            Text('$result',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: diffRate < 0
                                            ? Colors.black
                                            : Colors.black))),
                            Icon(
                              Icons.keyboard_arrow_up,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            // padding: EdgeInsets.only(top: 0),
            child: ListView(
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Row(
                        children: <Widget>[
                          Center(
                            child: Container(
                                width: MediaQuery.of(context).size.width / 1.01,
                                height:
                                    MediaQuery.of(context).size.height / 2.1,
                                child: SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  enableAxisAnimation: true,
                                  enableSideBySideSeriesPlacement: true,
                                  series: <ChartSeries>[
                                    LineSeries<LinearSales, double>(
                                      dataSource: currencyData,
                                      xValueMapper: (LinearSales data, _) =>
                                          data.date,
                                      yValueMapper: (LinearSales data, _) =>
                                          data.rate,
                                      color: getColorFromHex("#FF3980"),
                                      dataLabelSettings: DataLabelSettings(
                                          isVisible: true,
                                          borderColor:
                                              getColorFromHex("#FF3980"),
                                          color: getColorFromHex("#FF3980")),
                                      markerSettings:
                                          MarkerSettings(isVisible: true),
                                    )
                                  ],
                                  primaryXAxis: NumericAxis(
                                    isVisible: false,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    isVisible: false,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 40.0,
                          height: 40.0,
                          child: new ElevatedButton(
                            child: new Text(
                              "7D",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 15,
                                color: buttonType == 3
                                    ? Colors.white
                                    : getColorFromHex("#576284"),
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              backgroundColor: buttonType == 3
                                  ? getTrends2Color()
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                buttonType = 3;
                                _type = "Week";
                                callBitcoinApi();
                              });
                            },
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 40.0,
                          height: 40.0,
                          child: new ElevatedButton(
                            child: new Text(
                              '1M',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: buttonType == 4
                                    ? Colors.white
                                    : getColorFromHex("#576284"),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              backgroundColor: buttonType == 4
                                  ? getTrends2Color()
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                buttonType = 4;
                                _type = "Month";
                                callBitcoinApi();
                              });
                            },
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 40.0,
                          height: 40.0,
                          child: new ElevatedButton(
                            child: new Text(
                              '1Y',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: buttonType == 5
                                    ? Colors.white
                                    : getColorFromHex("#576284"),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              backgroundColor: buttonType == 5
                                  ? getTrends2Color()
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                buttonType = 5;
                                _type = "Year";
                                callBitcoinApi();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (bitcoinList.isNotEmpty) {
                          showPortfolioDialog(bitcoinList[0]);
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 14,
                        width: MediaQuery.of(context).size.width / 2.5,
                        padding: EdgeInsets.fromLTRB(35, 8, 35, 8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        decoration: BoxDecoration(
                          color: getColorFromHex("#4A41F4"),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                              AppLocalizations.of(context)!.translate('Add')!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> callBitcoinApi() async {
    final SharedPreferences prefs = await _sprefs;
    var currencyName = prefs.getString("currencyName") ?? 'BTC';
    setState(() {
      currencyNameForImage = currencyName;
    });
    var uri =
        '$ApiUrl/Bitcoin/resources/getBitcoinGraph?type=$_type&name=$currencyName';
    print(uri);
    var response = await get(Uri.parse(uri));
    //  print(response.body);
    final data = json.decode(response.body) as Map;
    //print(data);
    if (data['error'] == false) {
      setState(() {
        bitcoinList = data['data']
            .map<Bitcoin>((json) => Bitcoin.fromJson(json))
            .toList();
        double count = 0;
        diffRate = double.parse(data['diffRate']);
        if (diffRate < 0)
          result = data['diffRate'].replaceAll("-", "");
        else
          result = data['diffRate'];
        currencyData = [];
        bitcoinList.forEach((element) {
          currencyData.add(new LinearSales(count, element.rate!));
          name = element.name!;
          step2 = element.rate!.toStringAsFixed(2);
          double step3 = double.parse(step2);
          coin = step3;
          count = count + 1;
        });

        var list = bitcoinList.where(
            (element) => element.name.toString() == currencyName.toString());
      });
    } else {
      //  _ackAlert(context);
    }
  }

  TextEditingController? coinCountTextEditingController;
  final _formKey2 = GlobalKey<FormState>();

  Future<void> showPortfolioDialog(Bitcoin bitcoin) async {
    coinCountTextEditingController!.text = "";
    showCupertinoModalPopup(
        context: context,
        builder: (ctxt) => Container(
              height: MediaQuery.of(context).size.height,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.translate('add_coins')!,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: getColorFromHex("#4A41F4"),
                            fontWeight: FontWeight.w500,
                            fontSize: 21)),
                    textAlign: TextAlign.start,
                  ),
                  leading: InkWell(
                    child: Container(
                      child: Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: getColorFromHex("#4A41F4"),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  leadingWidth: 35,
                ),
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _addSaveCoinsToLocalStorage(bitcoin);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 14,
                        width: MediaQuery.of(context).size.width / 2.5,
                        padding: EdgeInsets.fromLTRB(35, 8, 35, 8),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        decoration: BoxDecoration(
                          color: getColorFromHex("#4A41F4"),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                              AppLocalizations.of(context)!.translate('Add')!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.8,
                      width: MediaQuery.of(context).size.width / 0.5,
                      // width: 240,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: kElevationToShadow[0],
                        border: Border.all(color: getColorFromHex("#8FD1FE")),
                        borderRadius: BorderRadius.circular(10),
                        color: getColorFromHex("#E8F1FF"),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 9.5,
                              width: MediaQuery.of(context).size.width / 1.3,
                              // width: 240,
                              // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[0],
                                border: Border.all(
                                    color: getColorFromHex("#8FD1FE")),
                                borderRadius: BorderRadius.circular(10),
                                color: getColorFromHex("#E8F1FF"),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 5),
                                  Container(
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: FadeInImage(
                                          placeholder: AssetImage(
                                              'assets/images/cob.png'),
                                          image: NetworkImage(
                                              "$ApiUrl/Bitcoin/resources/icons/${bitcoin.name!.toLowerCase()}.png"),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        bitcoin.name ?? '',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: getColorFromHex("#4A41F4"),
                                        )),
                                      ),
                                      Text(
                                        bitcoin.rate!.toStringAsFixed(2),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: getColorFromHex("#4A41F4"),
                                        )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: MediaQuery.of(context).size.height / 14,
                              width: MediaQuery.of(context).size.width / 1.3,
                              // width: 240,
                              // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              // padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[0],
                                border: Border.all(
                                    color: getColorFromHex("#8FD1FE")),
                                borderRadius: BorderRadius.circular(10),
                                color: getColorFromHex("#E8F1FF"),
                              ),
                              child: Form(
                                key: _formKey2,
                                child: TextFormField(
                                  controller: coinCountTextEditingController,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintStyle: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16)),
                                    hintText: 'Enter Number of Coins',
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ], // O
                                  //only numbers can be entered
                                  validator: (val) {
                                    if (coinCountTextEditingController!.text ==
                                            "" ||
                                        int.parse(
                                                coinCountTextEditingController!
                                                    .value.text) <=
                                            0) {
                                      return "At least 1 coin should be added";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  _addSaveCoinsToLocalStorage(Bitcoin bitcoin) async {
    if (_formKey2.currentState!.validate()) {
      if (items != null && items.length > 0) {
        PortfolioBitcoin? bitcoinLocal =
            items.firstWhereOrNull((element) => element.name == bitcoin.name);
        if (bitcoinLocal != null) {
          Map<String, dynamic> row = {
            DatabaseHelper.columnName: bitcoin.name,
            DatabaseHelper.columnRateDuringAdding: bitcoin.rate,
            DatabaseHelper.columnCoinsQuantity:
                double.parse(coinCountTextEditingController!.value.text) +
                    bitcoinLocal.numberOfCoins,
            DatabaseHelper.columnTotalValue:
                double.parse(coinCountTextEditingController!.value.text) *
                        (bitcoin.rate!) +
                    bitcoinLocal.totalValue,
          };
          final id = await dbHelper.update(row);
          print('inserted row id: $id');
        } else {
          Map<String, dynamic> row = {
            DatabaseHelper.columnName: bitcoin.name,
            DatabaseHelper.columnRateDuringAdding: bitcoin.rate,
            DatabaseHelper.columnCoinsQuantity:
                double.parse(coinCountTextEditingController!.value.text),
            DatabaseHelper.columnTotalValue:
                double.parse(coinCountTextEditingController!.value.text) *
                    (bitcoin.rate!),
          };
          final id = await dbHelper.insert(row);
          print('inserted row id: $id');
        }
      } else {
        Map<String, dynamic> row = {
          DatabaseHelper.columnName: bitcoin.name,
          DatabaseHelper.columnRateDuringAdding: bitcoin.rate,
          DatabaseHelper.columnCoinsQuantity:
              double.parse(coinCountTextEditingController!.text),
          DatabaseHelper.columnTotalValue:
              double.parse(coinCountTextEditingController!.value.text) *
                  (bitcoin.rate!),
        };
        final id = await dbHelper.insert(row);
        print('inserted row id: $id');
      }

      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences!.setString("currencyName", bitcoin.name ?? '');
        sharedPreferences!.setInt("index", 2);
        sharedPreferences!.setString("title",
            AppLocalizations.of(context)!.translate('portfolio').toString());
        sharedPreferences!.commit();
      });

      Navigator.pushNamedAndRemoveUntil(context, '/homePage', (r) => false);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => PortfolioPage()));
    } else {}
  }
}

class LinearSales {
  final double date;
  final double rate;

  LinearSales(this.date, this.rate);
}
