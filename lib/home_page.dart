import 'package:bitcoinfortressapp/top_looser_gainer_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'localization/AppLanguage.dart';
import 'localization/app_localizations.dart';
import 'models/LanguageData.dart';
import 'portfolios_page_up.dart';
import 'privacy_policy_up.dart';
import 'trends_pages_up.dart';
import 'util/color_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  int _selectedIndex = 0;
  String _lable = 'home';
  SharedPreferences? sharedPreferences;
  final PageStorageBucket bucket = PageStorageBucket();
  String? languageCodeSaved;

  List<LanguageData> languages = [
    LanguageData(languageCode: "en", languageName: "English"),
    LanguageData(languageCode: "it", languageName: "Italian"),
    LanguageData(languageCode: "de", languageName: "German"),
    LanguageData(languageCode: "sv", languageName: "Swedish"),
    LanguageData(languageCode: "fr", languageName: "French"),
    LanguageData(languageCode: "nb", languageName: "Norwegian"),
    LanguageData(languageCode: "es", languageName: "Spanish"),
    LanguageData(languageCode: "nl", languageName: "Dutch"),
    LanguageData(languageCode: "fi", languageName: "Finnish"),
    LanguageData(languageCode: "ru", languageName: "Russian"),
    LanguageData(languageCode: "pt", languageName: "Portuguese"),
    LanguageData(languageCode: "ar", languageName: "Arabic"),
  ];

  @override
  void initState() {
    getSharedPrefData();

    super.initState();
  }

  Future<void> getSharedPrefData() async {
    final SharedPreferences prefs = await _sprefs;
    setState(() {
      _selectedIndex = prefs.getInt("index") ?? 0;
      print("==>SELECTED INDEX==?" + _selectedIndex.toString());
      _onItemTapped(_selectedIndex);
      _lable = prefs.getString("title") ??
          AppLocalizations.of(context)!.translate('home')!;
      languageCodeSaved = prefs.getString('language_code') ?? "en";
      _saveProfileData();
    });
  }

  _saveProfileData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences!.setInt("index", 0);
      sharedPreferences!.setString(
          "title", AppLocalizations.of(context)!.translate('home') ?? '');
      // sharedPreferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: getColorFromHex("#181A1B"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            // color: getColorFromHex("#0B52E1"),
            borderRadius: BorderRadius.circular(35),
          ),
          child: _lable == AppLocalizations.of(context)!.translate('home')
              ? Text(
                  AppLocalizations.of(context)!.translate('home')!,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: getColorFromHex("#4A41F4"),
                          fontWeight: FontWeight.w500,
                          fontSize: 21)),
                  textAlign: TextAlign.start,
                )
              : _lable == AppLocalizations.of(context)!.translate('top_coins')
                  ? Text(
                      AppLocalizations.of(context)!.translate('top_coins')!,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: getColorFromHex("#4A41F4"),
                              fontWeight: FontWeight.w500,
                              fontSize: 21)),
                      textAlign: TextAlign.start,
                    )
                  : _lable ==
                          AppLocalizations.of(context)!.translate('portfolio')
                      ? Text(
                          AppLocalizations.of(context)!.translate('portfolio')!,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: getColorFromHex("#4A41F4"),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21)),
                          textAlign: TextAlign.start,
                        )
                      : _lable ==
                              AppLocalizations.of(context)!.translate('trends')
                          ? Text(
                              AppLocalizations.of(context)!
                                  .translate('trends')!,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: getColorFromHex("#4A41F4"),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 21)),
                              textAlign: TextAlign.start,
                            )
                          : _lable ==
                                  AppLocalizations.of(context)!
                                      .translate('privacy_policy')
                              ? Text(
                                  AppLocalizations.of(context)!
                                      .translate('privacy_policy')!,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: getColorFromHex("#4A41F4"),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21)),
                                  textAlign: TextAlign.start,
                                )
                              : Text(
                                  AppLocalizations.of(context)!
                                      .translate('home')!,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: getColorFromHex("#4A41F4"),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21)),
                                  textAlign: TextAlign.start,
                                ),
        ),
        // leading: InkWell(
        //   child: Container(
        //     child: Image.asset(
        //       "assets/images/navigation_icon.png",
        //       height: 20,
        //       width: 20,
        //     ),
        //     margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        //   ),
        //   onTap: () {
        //     privacyPolicyBottomSheet(context);
        //   },
        // ),
        // leadingWidth: 35,
        actions: [
          InkWell(
            child: Container(
              child: Image.asset(
                "assets/images/translation.png",
                height: 25,
                width: 25,
                color: Colors.black,
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(
                          child: Text(AppLocalizations.of(context)!
                              .translate('select_language')!)),
                      content: Container(
                          width: double.maxFinite,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: languages.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                          onTap: () async {
                                            appLanguage.changeLanguage(Locale(
                                                languages[i].languageCode!));
                                            await getSharedPrefData();
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(languages[i].languageName!),
                                              languageCodeSaved ==
                                                      languages[i].languageCode
                                                  ? Icon(
                                                      Icons
                                                          .radio_button_checked,
                                                      color: Color(0xff0B52E1),
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .radio_button_unchecked,
                                                      color: Color(0xff0B52E1),
                                                    ),
                                            ],
                                          )),
                                      Divider()
                                    ],
                                  ),
                                );
                              })),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff0B52E1),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!
                              .translate('cancel')!),
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: PageStorage(
        child: selectedWidget(),
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.white,
        // notchMargin:
        //     5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              child: Container(
                child: Image.asset(
                  "assets/images/homebottom.png",
                  // color: _selectedIndex == 0 ? Colors.amber : Colors.white,
                ),
                height: 30,
                width: 40,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              ),
              onTap: () {
                _onItemTapped(0);
              },
            ),
            InkWell(
              child: Container(
                child: Image.asset(
                  "assets/images/topcoinbottom.png",
                  // color: _selectedIndex == 1
                  //     ? getColorFromHex("#5EBBFF")
                  //     : Colors.white
                ),
                height: 30,
                width: 40,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              ),
              onTap: () {
                _onItemTapped(1);
              },
            ),
            InkWell(
              child: InkWell(
                  child: Container(
                child: Image.asset(
                  "assets/images/walletbottom.png",
                ),
                height: 30,
                width: 40,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              )),
              onTap: () {
                _onItemTapped(2);
              },
            ),
            InkWell(
              child: Container(
                child: Image.asset(
                  "assets/images/trendsbottom.png",
                ),
                height: 30,
                width: 40,
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              ),
              onTap: () {
                _onItemTapped(3);
              },
            ),
            InkWell(
              child: Container(
                child: Image.asset(
                  "assets/images/addcoinbottom.png",
                ),
                height: 30,
                width: 40,
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              ),
              onTap: () {
                _onItemTapped(4);
              },
            ),
            // IconButton(icon: Icon(Icons.menu, color: Colors.white,), onPressed: () {},),
          ],
        ),
      ),
    );
  }

  Widget selectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return HomePageReal();
      case 1:
        return TopLooserAndGainer();
      case 2:
        return PortfolioPage();
      case 3:
        return TrendPage();
      case 4:
        return PrivacyPolicyPage();
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0)
        _lable = AppLocalizations.of(context)!.translate('home')!;
      else if (index == 1)
        _lable = AppLocalizations.of(context)!.translate('top_coins')!;
      else if (index == 2)
        _lable = AppLocalizations.of(context)!.translate('portfolio')!;
      else if (index == 3)
        _lable = AppLocalizations.of(context)!.translate('trends')!;
      else if (index == 4)
        _lable = AppLocalizations.of(context)!.translate('privacy_policy')!;
      // else if (index == 5)
      //   _lable = AppLocalizations.of(context)!.translate('privacy_policy')!;
    });
  }

  void privacyPolicyBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            color: getColorFromHex("#343434"),
            child: new Wrap(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage()));
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        "assets/images/privacy_policy_icon.png",
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .translate('privacy_policy')!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('privacy_policy')!,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 13,
                              color: getColorFromHex("#D3D3D3"),
                              fontWeight: FontWeight.normal,
                            )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
