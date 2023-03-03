// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:bitcoinfortressapp/trends_pages_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/app_localizations.dart';
import 'models/Bitcoin.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'util/color_util.dart';

class TopLooserAndGainer extends StatefulWidget {
  TopLooserAndGainer({super.key});
  @override
  TopLooserGainerState createState() => TopLooserGainerState();
}

class TopLooserGainerState extends State<TopLooserAndGainer> {
  // String? ApiUrl = "http://45.34.15.25:8080";
  SharedPreferences? sharedPreferences;

  String currentItem = "";

  // List of items in our dropdown menu
  List<String> items = [
    'Top Gainer',
    'Top Looser',
  ];

  @override
  void initState() {
    super.initState();
    currentItem = items[0];
    getData();
  }

  List<Bitcoin> myDataList = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: getColorFromHex("#21232D"),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: getColorFromHex("#141418"),
      //   elevation: 0,
      //   title: const Text(
      //     "Top Coins",
      //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      //   ),
      //   centerTitle: true,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.width / 1.5,
              // width: 240,
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[0],
                border: Border.all(color: getColorFromHex("#8FD1FE")),
                borderRadius: BorderRadius.circular(10),
                color: getColorFromHex("#E8F1FF"),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    currentItem,
                    // AppLocalizations.of(context)!.translate('home')!,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: getColorFromHex("#4A41F4"),
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 3,
                    // width: 240,
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: kElevationToShadow[0],
                      border: Border.all(color: getColorFromHex("#8FD1FE")),
                      borderRadius: BorderRadius.circular(10),
                      color: getColorFromHex("#E8F1FF"),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        // Initial Value
                        value: currentItem,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            currentItem = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (currentItem == "Top Gainer") Expanded(child: topGainer()),
          if (currentItem == "Top Looser") Expanded(child: topLooser())
        ],
      ),
    );
  }

  List<charts.Series<LinearSales, int>> _createSampleData(
      historyRate, diffRate) {
    List<LinearSales> listData = [];
    for (int i = 0; i < historyRate.length; i++) {
      double rate = historyRate[i]['rate'];
      listData.add(new LinearSales(i, rate));
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Tablet',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => diffRate < 0
            ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.green.shadeDefault,
        // areaColorFn specifies that the area skirt will be light red.
        // areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.count,
        measureFn: (LinearSales sales, _) => sales.rate,
        data: listData,
      ),
    ];
  }

  Widget topGainer() {
    var list = myDataList
        .where((element) => double.parse(element.diffRate!) > 0)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: items != null &&
                  items.length > 0 &&
                  myDataList != null &&
                  myDataList.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int i) {
                    return InkWell(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 11,
                            width: MediaQuery.of(context).size.width / 0.5,
                            // width: 240,
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[0],
                              // border: Border.all(color: getColorFromHex("#8FD1FE")),
                              borderRadius: BorderRadius.circular(20),
                              color: getColorFromHex("#E8F1FF"),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: FadeInImage(
                                              placeholder: AssetImage(
                                                  'assets/images/cob.png'),
                                              image: NetworkImage(
                                                  "http://45.34.15.25:8080/Bitcoin/resources/icons/${list[i].name!.toLowerCase()}.png"),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 7, 0, 0),
                                            child: Text(
                                              '${list[i].name}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: getColorFromHex(
                                                          "#576284"))),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            '\$${double.parse(list[i].rate!.toStringAsFixed(2))}',
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              fontSize: 16,
                                              color: getColorFromHex("#451873"),
                                              fontWeight: FontWeight.w600,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      callCurrencyDetails(list[i].name);
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 50,
                                      child: new charts.LineChart(
                                        _createSampleData(list[i].historyRate,
                                            double.parse(list[i].diffRate!)),
                                        layoutConfig: new charts.LayoutConfig(
                                            leftMarginSpec: new charts
                                                .MarginSpec.fixedPixel(5),
                                            topMarginSpec: new charts
                                                .MarginSpec.fixedPixel(10),
                                            rightMarginSpec: new charts
                                                .MarginSpec.fixedPixel(5),
                                            bottomMarginSpec: new charts
                                                .MarginSpec.fixedPixel(10)),
                                        defaultRenderer:
                                            new charts.LineRendererConfig(
                                          includeArea: true,
                                          stacked: true,
                                        ),
                                        animate: true,
                                        domainAxis: charts.NumericAxisSpec(
                                            showAxisLine: false,
                                            renderSpec:
                                                charts.NoneRenderSpec()),
                                        primaryMeasureAxis:
                                            charts.NumericAxisSpec(
                                                renderSpec:
                                                    charts.NoneRenderSpec()),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              double.parse(list[i].diffRate!) <
                                                      0
                                                  ? Container(
                                                      // color: Colors.red,
                                                      child: Icon(
                                                        Icons.arrow_downward,
                                                        color: getColorFromHex(
                                                            "#FF7C74"),
                                                        size: 15,
                                                      ),
                                                    )
                                                  : Container(
                                                      // color: Colors.green,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_upward_sharp,
                                                        color: getColorFromHex(
                                                            "#11CABE"),
                                                        size: 15,
                                                      ),
                                                    ),
                                              SizedBox(width: 2),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(list[i].perRate!,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: double.parse(list[
                                                                        i]
                                                                    .diffRate!) <
                                                                0
                                                            ? getColorFromHex(
                                                                "#FF7C74")
                                                            : getColorFromHex(
                                                                "#11CABE"))),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        callCurrencyDetails(list[i].name);
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
    );
  }

  Widget topLooser() {
    var list = myDataList
        .where((element) => double.parse(element.diffRate!) < 0)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: myDataList != null && myDataList.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int i) {
                    return InkWell(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 11,
                            width: MediaQuery.of(context).size.width / 0.5,
                            // width: 240,
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[0],
                              // border: Border.all(color: getColorFromHex("#8FD1FE")),
                              borderRadius: BorderRadius.circular(20),
                              color: getColorFromHex("#E8F1FF"),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: FadeInImage(
                                              placeholder: AssetImage(
                                                  'assets/images/cob.png'),
                                              image: NetworkImage(
                                                  "http://45.34.15.25:8080/Bitcoin/resources/icons/${list[i].name!.toLowerCase()}.png"),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 7, 0, 0),
                                            child: Text(
                                              '${list[i].name}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: getColorFromHex(
                                                          "#576284"))),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            '\$${double.parse(list[i].rate!.toStringAsFixed(2))}',
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              fontSize: 16,
                                              color: getColorFromHex("#451873"),
                                              fontWeight: FontWeight.w600,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      callCurrencyDetails(list[i].name);
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 50,
                                      child: new charts.LineChart(
                                        _createSampleData(list[i].historyRate,
                                            double.parse(list[i].diffRate!)),
                                        layoutConfig: new charts.LayoutConfig(
                                            leftMarginSpec: new charts
                                                .MarginSpec.fixedPixel(5),
                                            topMarginSpec: new charts
                                                .MarginSpec.fixedPixel(10),
                                            rightMarginSpec: new charts
                                                .MarginSpec.fixedPixel(5),
                                            bottomMarginSpec: new charts
                                                .MarginSpec.fixedPixel(10)),
                                        defaultRenderer:
                                            new charts.LineRendererConfig(
                                          includeArea: true,
                                          stacked: true,
                                        ),
                                        animate: true,
                                        domainAxis: charts.NumericAxisSpec(
                                            showAxisLine: false,
                                            renderSpec:
                                                charts.NoneRenderSpec()),
                                        primaryMeasureAxis:
                                            charts.NumericAxisSpec(
                                                renderSpec:
                                                    charts.NoneRenderSpec()),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              double.parse(list[i].diffRate!) <
                                                      0
                                                  ? Container(
                                                      // color: Colors.red,
                                                      child: Icon(
                                                        Icons.arrow_downward,
                                                        color: getColorFromHex(
                                                            "#FF7C74"),
                                                        size: 15,
                                                      ),
                                                    )
                                                  : Container(
                                                      // color: Colors.green,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_upward_sharp,
                                                        color: getColorFromHex(
                                                            "#11CABE"),
                                                        size: 15,
                                                      ),
                                                    ),
                                              SizedBox(width: 2),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(list[i].perRate!,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: double.parse(list[
                                                                        i]
                                                                    .diffRate!) <
                                                                0
                                                            ? getColorFromHex(
                                                                "#FF7C74")
                                                            : getColorFromHex(
                                                                "#11CABE"))),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        callCurrencyDetails(list[i].name);
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
    );
  }

  Future<void> callCurrencyDetails(name) async {
    _saveProfileData(name);
  }

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
}

class LinearSales {
  final int count;
  final double rate;

  LinearSales(this.count, this.rate);
}
