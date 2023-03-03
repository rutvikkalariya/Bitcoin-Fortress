import 'dart:convert';

import 'package:bitcoinfortressapp/trends_pages_up.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_helper.dart';
import 'localization/app_localizations.dart';
import 'models/Bitcoin.dart';
import 'models/PortfolioBitcoin.dart';
import 'util/color_util.dart';

class PortfolioPage extends StatefulWidget {
  // Function() noCoinTap;
  PortfolioPage({
    Key? key,
  }) : super(key: key);

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  List<Bitcoin> bitcoinList = [];
  SharedPreferences? sharedPreferences;
  num _size = 0;
  TabController? _tabController;
  double totalValuesOfPortfolio = 0.0;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String? ApiUrl = 'http://45.34.15.25:8080';

  TextEditingController? coinCountTextEditingController;
  TextEditingController? coinCountEditTextEditingController;
  final dbHelper = DatabaseHelper.instance;
  List<PortfolioBitcoin> items = [];
  List<Bitcoin> myDataList = [];

  @override
  void initState() {
    callBitcoinApi();
    getData();
    _tabController = new TabController(length: 2, vsync: this);
    coinCountTextEditingController = new TextEditingController();
    coinCountEditTextEditingController = new TextEditingController();
    dbHelper.queryAllRows().then((notes) {
      notes.forEach((note) {
        items.add(PortfolioBitcoin.fromMap(note));
        totalValuesOfPortfolio = totalValuesOfPortfolio + note["total_value"];
      });
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/BG.png",
                  fit: BoxFit.fill,
                ),
                height: MediaQuery.of(context).size.height / 9,
                width: double.infinity,
                // padding: EdgeInsets.zero,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 40, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('total_portfolio_bls')!,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\$${totalValuesOfPortfolio.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                              color: Colors.white)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
            child: Text(
              AppLocalizations.of(context)!.translate('Added_coins')!,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black)),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 8,
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
            child: Row(
              children: [
                // Container(
                //   height: MediaQuery.of(context).size.height / 12,
                //   width: MediaQuery.of(context).size.width / 6,
                //   // width: 240,
                //   margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                //   decoration: BoxDecoration(
                //     boxShadow: kElevationToShadow[0],
                //     border: Border.all(color: getColorFromHex("#8FD1FE")),
                //     borderRadius: BorderRadius.circular(10),
                //     color: getColorFromHex("#E8F1FF"),
                //   ),
                //   child: Center(
                //       child: IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.add,
                //             size: 30,
                //           ))),
                // ),
                // SizedBox(width: 10),
                Expanded(
                  child: items != null &&
                          items.length > 0 &&
                          bitcoinList != null &&
                          bitcoinList.length > 0
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int i) {
                            var graphList = bitcoinList
                                .where(
                                    (element) => element.name == items[i].name)
                                .toList();
                            return InkWell(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(children: [
                                    Container(
                                      height: 50,
                                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: FadeInImage(
                                        placeholder:
                                            AssetImage('assets/images/cob.png'),
                                        image: NetworkImage(
                                            "$ApiUrl/Bitcoin/resources/icons/${items[i].name.toLowerCase()}.png"),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _showdeleteCoinFromPortfolioDialog(
                                            items[i]);
                                      },
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        margin:
                                            EdgeInsets.fromLTRB(45, 0, 0, 0),
                                        // height: 20,
                                        // width: 80,
                                        child: Image.asset(
                                            "assets/images/deletecoin.png"),
                                      ),
                                    ),
                                  ]),
                                  Text(
                                    '${items[i].name}',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: getColorFromHex("#4A41F4"),
                                    )),
                                  ),
                                ],
                              ),
                              onTap: () {
                                showPortfolioEditDialogUpdate(items[i]);
                              },
                            );
                          })
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('no_coins_added')!,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
            child: Text(
              AppLocalizations.of(context)!.translate('coins')!,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black)),
              textAlign: TextAlign.left,
            ),
          ),
          Flexible(
            child: myDataList != null && myDataList.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: GridView.builder(
                      itemCount: myDataList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            callCurrencyDetails(myDataList[index].name);
                          },
                          child: Container(
                            // height: MediaQuery.of(context).size.height / 14,
                            // width: MediaQuery.of(context).size.width / 6,
                            // // width: 240,
                            // margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[0],
                              // border: Border.all(color: getColorFromHex("#8FD1FE")),
                              borderRadius: BorderRadius.circular(10),
                              color: getColorFromHex("#CEEBFF"),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 30),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (myDataList.isNotEmpty) {
                                              showPortfolioDialog(
                                                  myDataList[index]);
                                            }
                                          },
                                          child: Flexible(
                                            child: Container(
                                              height: 45,
                                              margin: EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: FadeInImage(
                                                placeholder: AssetImage(
                                                    'assets/images/plusoval.png'),
                                                image: NetworkImage(
                                                    "$ApiUrl/Bitcoin/resources/icons/${myDataList[index].name!.toLowerCase()}.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${myDataList[index].name}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19,
                                                color:
                                                    getColorFromHex("#4A41F4"),
                                              )),
                                            ),
                                            Text(
                                              '${double.parse(myDataList[index].rate!.toStringAsFixed(2))}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color:
                                                    getColorFromHex("#4A41F4"),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      double.parse(
                                                  myDataList[index].diffRate!) <
                                              0
                                          ? Container(
                                              // color: Colors.red,
                                              child: Icon(
                                                Icons.arrow_downward,
                                                color:
                                                    getColorFromHex("#FF7C74"),
                                                size: 15,
                                              ),
                                            )
                                          : Container(
                                              // color: Colors.green,
                                              child: Icon(
                                                Icons.arrow_upward_sharp,
                                                color:
                                                    getColorFromHex("#11CABE"),
                                                size: 15,
                                              ),
                                            ),
                                      SizedBox(width: 2),
                                      Text(myDataList[index].perRate!,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .translate('no_coins_added')!,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

//showPortfolioDialog method for Add coins-----------------
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
                      height: MediaQuery.of(context).size.height / 3.9,
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
                              height: MediaQuery.of(context).size.height / 10,
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
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                          color: getColorFromHex("#4A41F4"),
                                        )),
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   height:
                                  //       MediaQuery.of(context).size.height / 17,
                                  //   width:
                                  //       MediaQuery.of(context).size.width / 8,
                                  //   // width: 50,
                                  //   // height: 20,
                                  //   margin: EdgeInsets.fromLTRB(70, 5, 0, 5),
                                  //   decoration: BoxDecoration(
                                  //     boxShadow: kElevationToShadow[0],
                                  //     border: Border.all(
                                  //         color: getColorFromHex("#8FD1FE")),
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     color: getColorFromHex("#E8F1FF"),
                                  //   ),
                                  //   child: IconButton(
                                  //       onPressed: () {},
                                  //       icon: Icon(
                                  //         Icons.arrow_drop_down_outlined,
                                  //         size: 28,
                                  //       )),
                                  // ),
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

//_addSaveCoinsToLocalStorage method for add save coin data to local storage-----------------
  _addSaveCoinsToLocalStorage(Bitcoin bitcoin) async {
    if (_formKey2.currentState!.validate()) {
      if (items != null && items.length > 0) {
        PortfolioBitcoin? bitcoinLocal =
            items.firstWhere((element) => element.name == bitcoin.name);
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
        sharedPreferences!.setInt("index", 4);
        sharedPreferences!.setString("title",
            AppLocalizations.of(context)!.translate('portfolio').toString());
        sharedPreferences!.commit();
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PortfolioPage()));
    } else {}
  }

//callCurrencyDetails method for Save coins ---------------------------------------------------------
  Future<void> callCurrencyDetails(name) async {
    _saveProfileData(name);
  }

//_saveProfileData method for Save data ---------------------------------------------------------
  _saveProfileData(String name) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences!.setString("currencyName", name);
      sharedPreferences!.setInt("index", 1);
      sharedPreferences!.setString(
          "title", AppLocalizations.of(context)!.translate('trends') ?? '');
      sharedPreferences!.commit();
    });

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TrendPage()));
  }

//callBitcoinApi method for Added coins list---------------------------------------------------------
  Future<void> callBitcoinApi() async {
    var uri = '$ApiUrl/Bitcoin/resources/getBitcoinList?size=${_size}';
    var response = await get(Uri.parse(uri));
    final data = json.decode(response.body) as Map;
    //  print(data);
    if (data['error'] == false) {
      setState(() {
        bitcoinList.addAll(data['data']
            .map<Bitcoin>((json) => Bitcoin.fromJson(json))
            .toList());
        isLoading = false;
        _size = _size + data['data'].length;
      });
    } else {
      //  _ackAlert(context);
      setState(() {});
    }
  }

//getData method for coin list---------------------------------------------------------
  void getData() async {
    var uri = Uri.parse(
        "http://45.34.15.25:8080/Bitcoin/resources/getBitcoinListLoser?size=0");
    var response = await get(uri);
    final data = json.decode(response.body) as Map;
    if (data['error'] == false) {
      setState(() {
        myDataList.addAll(data['data']
            .map<Bitcoin>((json) => Bitcoin.fromJson(json))
            .toList());
        // isLoading = false;
        // size = size + data['data'].length;
        print(myDataList.length);
        // print(myDataList);
      });
    } else {
      setState(() {});
    }
  }

//update coins---------------------------------------------------------
  Future<void> showPortfolioEditDialogUpdate(PortfolioBitcoin bitcoin) async {
    coinCountEditTextEditingController!.text =
        bitcoin.numberOfCoins.toInt().toString();
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
                    AppLocalizations.of(context)!.translate('update_coins')!,
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
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#8FD1FE"),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/images/cob.png'),
                                  image: NetworkImage(
                                      "$ApiUrl/Bitcoin/resources/icons/${bitcoin.name.toLowerCase()}.png"),
                                ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            bitcoin.name,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: getColorFromHex("#4A41F4"))),
                          ),
                          Container(
                            child: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: getColorFromHex("#4A41F4"),
                              size: 30,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '\$ ${bitcoin.totalValue.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: getColorFromHex("#4A41F4"))),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#8FD1FE"),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextFormField(
                        key: _formKey,
                        controller: coinCountEditTextEditingController,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: getColorFromHex("#4A41F4")),
                        textAlign: TextAlign.start,
                        cursorColor: getColorFromHex("#4A41F4"),
                        decoration: InputDecoration(
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
                          if (coinCountEditTextEditingController!.value.text ==
                                  null ||
                              coinCountEditTextEditingController!.value.text ==
                                  "" ||
                              int.parse(coinCountEditTextEditingController!
                                      .value.text) <=
                                  0) {
                            return "at least 1 coin should be added";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        _updateSaveCoinsToLocalStorage(bitcoin);
                      },
                      child: Container(
                          padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: getColorFromHex("#4A41F4"),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('update_coins')!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            textAlign: TextAlign.start,
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ));
  }

  // getCurrentRateDiff(PortfolioBitcoin items, List<Bitcoin> bitcoinList) {
  //   Bitcoin j = bitcoinList.firstWhere((element) => element.name == items.name);

  //   double newRateDiff = j.rate! - items.rateDuringAdding;
  //   return newRateDiff;
  // }

//delete Save coins---------------------------------------------------------
  _updateSaveCoinsToLocalStorage(PortfolioBitcoin bitcoin) async {
    if (coinCountEditTextEditingController!.text.isNotEmpty &&
        coinCountEditTextEditingController!.text != 0) {
      int adf = int.parse(coinCountEditTextEditingController!.text);
      print(adf);
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: bitcoin.name,
        DatabaseHelper.columnRateDuringAdding: bitcoin.rateDuringAdding,
        DatabaseHelper.columnCoinsQuantity:
            double.parse(coinCountEditTextEditingController!.value.text),
        DatabaseHelper.columnTotalValue: (adf) * (bitcoin.rateDuringAdding),
      };
      final id = await dbHelper.update(row);
      print('inserted row id: $id');
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences!.setString("currencyName", bitcoin.name);
        sharedPreferences!.setInt("index", 3);
        sharedPreferences!.setString("title",
            AppLocalizations.of(context)!.translate('portfolio') ?? '');
        sharedPreferences!.commit();
      });
      // Navigator.pushNamedAndRemoveUntil(context, '/homePage', (r) => false);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PortfolioPage()));
    }
  }

//delete coins---------------------------------------------------------
  void _showdeleteCoinFromPortfolioDialog(PortfolioBitcoin item) {
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
                    AppLocalizations.of(context)!.translate('remove_coins')!,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        AppLocalizations.of(context)!.translate('do_you')!,
                        style: TextStyle(
                            fontSize: 22,
                            color: getColorFromHex("#4A41F4"),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#E8F1FF"),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/images/cob.png'),
                                  image: NetworkImage(
                                      "$ApiUrl/Bitcoin/resources/icons/${item.name.toLowerCase()}.png"),
                                ),
                              )),
                          SizedBox(width: 10),
                          Text(
                            item.name,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: getColorFromHex("#4A41F4")),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        _deleteCoinsToLocalStorage(item);
                      },
                      child: Container(
                          padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: getColorFromHex("#4A41F4"),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('remove_coins')!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            textAlign: TextAlign.start,
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ));
  }

//delete coins---------------------------------------------------------
  _deleteCoinsToLocalStorage(PortfolioBitcoin item) async {
    final id = await dbHelper.delete(item.name);
    print('inserted row id: $id');
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences!.setInt("index", 3);
      sharedPreferences!.setString(
          "title", AppLocalizations.of(context)!.translate('coins') ?? '');
      sharedPreferences!.commit();
    });
    // Navigator.pushNamedAndRemoveUntil(context, '/homePage', (r) => false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PortfolioPage()));
  }
}
