// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:bitcoinfortressapp/util/color_util.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'core/utils/color_constant.dart';
import 'core/utils/image_constant.dart';
import 'core/utils/size_utils.dart';
import 'localization/app_localizations.dart';
import 'models/Bitcoin.dart';
import 'widgets/custom_image_view.dart';

class HomePageReal extends StatefulWidget {
  const HomePageReal({Key? key}) : super(key: key);

  @override
  _HomePageRealState createState() => _HomePageRealState();
}

class _HomePageRealState extends State<HomePageReal> {
  final Completer<WebViewController> _controllerForm =
      Completer<WebViewController>();
  ScrollController? _controllerList;
  bool isLoading = false;
  List<Bitcoin> bitcoinList = [];
  SharedPreferences? sharedPreferences;
  String? iFrameUrl;
  bool? disableIframe;
  late WebViewController controller;

  @override
  void initState() {
    _controllerList = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.1,
              // width: getHorizontalSize(310.00),
              decoration: BoxDecoration(color: getColorFromHex("#4A41F4")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: getPadding(all: 20),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome1")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(
                          20,
                        ),
                        fontFamily: 'Poppins',
                        // fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    child: Padding(
                      padding: getPadding(all: 20),
                      child: Text(
                        AppLocalizations.of(context)!.translate("newhome2")!,
                        // overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getFontSize(
                            40,
                          ),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(top: 50),
                    child: Container(
                      height: getVerticalSize(
                        400.00,
                      ),
                      width: getHorizontalSize(double.infinity),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/homeimage1.png"),
                          // fit: BoxFit.fill,
                        ),
                        // color: ColorConstant.deepPurpleA70065.withOpacity(0.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Shaperound.png"),
                    SizedBox(width: 12),
                    Image.asset("assets/images/Shaperound.png"),
                    SizedBox(width: 12),
                    Image.asset("assets/images/Shaperound.png"),
                  ],
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 50),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome3")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          38,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome4")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 50),
                  child: Container(
                    height: getVerticalSize(
                      50.00,
                    ),
                    width: getHorizontalSize(double.infinity),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Shape2.png"),
                        // fit: BoxFit.fill,
                      ),
                      // color: ColorConstant.deepPurpleA70065.withOpacity(0.2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  child: Text(
                    AppLocalizations.of(context)!.translate("newhome5")!,
                    // overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getColorFromHex("#020248"),
                      fontSize: getFontSize(
                        24,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome6")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 50),
                  child: Container(
                    height: getVerticalSize(
                      50.00,
                    ),
                    width: getHorizontalSize(double.infinity),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Shape2.png"),
                        // fit: BoxFit.fill,
                      ),
                      // color: ColorConstant.deepPurpleA70065.withOpacity(0.2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  child: Text(
                    AppLocalizations.of(context)!.translate("newhome7")!,
                    // overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getColorFromHex("#020248"),
                      fontSize: getFontSize(
                        24,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome8")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 50),
                  child: Container(
                    height: getVerticalSize(
                      50.00,
                    ),
                    width: getHorizontalSize(double.infinity),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Shape2.png"),
                        // fit: BoxFit.fill,
                      ),
                      // color: ColorConstant.deepPurpleA70065.withOpacity(0.2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  child: Text(
                    AppLocalizations.of(context)!.translate("newhome9")!,
                    // overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getColorFromHex("#020248"),
                      fontSize: getFontSize(
                        24,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome10")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 50),
                  child: Container(
                    height: getVerticalSize(
                      50.00,
                    ),
                    width: getHorizontalSize(double.infinity),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Shape2.png"),
                        // fit: BoxFit.fill,
                      ),
                      // color: ColorConstant.deepPurpleA70065.withOpacity(0.2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  child: Text(
                    AppLocalizations.of(context)!.translate("newhome11")!,
                    // overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getColorFromHex("#020248"),
                      fontSize: getFontSize(
                        24,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome12")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 50),
                  child: Container(
                    height: getVerticalSize(
                      50.00,
                    ),
                    width: getHorizontalSize(double.infinity),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Shape2.png"),
                        // fit: BoxFit.fill,
                      ),
                      // color: ColorConstant.deepPurpleA70065.withOpacity(0.2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  child: Text(
                    AppLocalizations.of(context)!.translate("newhome13")!,
                    // overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getColorFromHex("#020248"),
                      fontSize: getFontSize(
                        24,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome14")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 50),
                  child: Container(
                    height: getVerticalSize(
                      50.00,
                    ),
                    width: getHorizontalSize(double.infinity),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Shape2.png"),
                        // fit: BoxFit.fill,
                      ),
                      // color: ColorConstant.deepPurpleA70065.withOpacity(0.2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  child: Text(
                    AppLocalizations.of(context)!.translate("newhome15")!,
                    // overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getColorFromHex("#020248"),
                      fontSize: getFontSize(
                        24,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome16")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Shaperound.png"),
                    SizedBox(width: 12),
                    Image.asset("assets/images/Shaperound.png"),
                    SizedBox(width: 12),
                    Image.asset("assets/images/Shaperound.png"),
                  ],
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 50),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome17")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          30,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome18")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.translate('newhome19')!,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: getColorFromHex("#4A41F4"),
                            fontWeight: FontWeight.w500,
                            fontSize: 52)),
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 20),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome20")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.translate('newhome21')!,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: getColorFromHex("#4A41F4"),
                            fontWeight: FontWeight.w500,
                            fontSize: 52)),
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 20),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome22")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.translate('newhome23')!,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: getColorFromHex("#4A41F4"),
                            fontWeight: FontWeight.w500,
                            fontSize: 52)),
                    textAlign: TextAlign.start,
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 20),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome24")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Shaperound.png"),
                    SizedBox(width: 12),
                    Image.asset("assets/images/Shaperound.png"),
                    SizedBox(width: 12),
                    Image.asset("assets/images/Shaperound.png"),
                  ],
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 50),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome25")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          35,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 50),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome26")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          25,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 20),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome27")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 50),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome28")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          25,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 20),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome29")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 200),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome30")!,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          40,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Text(
                      "01",
                      // AppLocalizations.of(context)!.translate('newhome23')!,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: getColorFromHex("#4A41F4"),
                              fontWeight: FontWeight.w500,
                              fontSize: 35)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 20),
                    child: Text(
                      AppLocalizations.of(context)!.translate("newhome31")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          40,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      // "Registering is free of charge! To register, complete the brief form on this official Bitcoin Fortress page.",
                      AppLocalizations.of(context)!.translate("newhome32")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Text(
                      "02",
                      // AppLocalizations.of(context)!.translate('newhome23')!,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: getColorFromHex("#4A41F4"),
                              fontWeight: FontWeight.w500,
                              fontSize: 35)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 20),
                    child: Text(
                      // "Start studying",
                      AppLocalizations.of(context)!.translate("newhome33")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          40,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      AppLocalizations.of(context)!.translate('newhome34')!,
                      // "Following completion of the online form and approval, you can start using our top-notch bitcoin learning app at no expense right away.", // AppLocalizations.of(context)!.translate("newhome29")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Text(
                      "03",
                      // AppLocalizations.of(context)!.translate('newhome23')!,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: getColorFromHex("#4A41F4"),
                              fontWeight: FontWeight.w500,
                              fontSize: 35)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 20),
                    child: Text(
                      // "Begin making",
                      AppLocalizations.of(context)!.translate("newhome35")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          40,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(all: 30),
                    child: Text(
                      // "Now that you have created your account and gained knowledge about cryptocurrencies, you can join the real cryptocurrency market and start earning money.",
                      AppLocalizations.of(context)!.translate("newhome36")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/homecoma.png",
                  ),
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 20, right: 20, top: 10),
                    child: Text(
                      // "I now understand what it's like to pursue your dreams. I no longer feel left out as I observe everyone else enjoy themselves. Thanks to Bitcoin Fortress, I was able to benefit from the bitcoin market with ease.",
                      AppLocalizations.of(context)!.translate("newhome37")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          35,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  width: 400,
                  child: Image.asset(
                    "assets/images/Item.png",
                  ),
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Shaperound.png"),
                    SizedBox(width: 12),
                    Image.asset("assets/images/Shaperound.png"),
                    SizedBox(width: 12),
                    Image.asset("assets/images/Shaperound.png"),
                  ],
                ),
                Align(
                  child: Padding(
                    padding: getPadding(left: 50, right: 50, top: 50),
                    child: Text(
                      // "Frequently AskQuestion",
                      AppLocalizations.of(context)!.translate("newhome38")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: getColorFromHex("#020248"),
                        fontSize: getFontSize(
                          40,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          child: Text(
                            // "What is Bitcoin?",
                            AppLocalizations.of(context)!
                                .translate("newhome39")!,
                            // overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: getColorFromHex("#020248"),
                              fontSize: getFontSize(
                                28,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Align(
                          child: Text(
                            "-",
                            // AppLocalizations.of(context)!.translate("newhome25")!,
                            // overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: getColorFromHex("#020248"),
                              fontSize: getFontSize(
                                40,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 10),
                    child: Text(
                      // "The most well-known and widely-used altcoin is bitcoin. Even if technology isn't your thing, you've undoubtedly heard of the company.",
                      AppLocalizations.of(context)!.translate("newhome40")!,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: getFontSize(
                          19,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  endIndent: 30,
                  indent: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 1,
                    // width: 240,
                    // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: kElevationToShadow[0],
                      // border: Border.all(color: getColorFromHex("#8FD1FE")),
                      // borderRadius: BorderRadius.circular(10),
                      color: getColorFromHex("#2AEFB4"),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Align(
                        child: Text(
                          // "What is Bitcoin?",
                          AppLocalizations.of(context)!.translate("newhome45")!,
                          // overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getColorFromHex("#020248"),
                            fontSize: getFontSize(
                              32,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),

        // Container(
        //   width: size.width,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Container(
        // width: getHorizontalSize(
        //   310.00,
        // ),
        //         decoration: BoxDecoration(
        //             color: getColorFromHex("#4A41F4")),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             Align(
        //               alignment: Alignment.center,
        //               child: Padding(
        //                 padding: getPadding(all: 10),
        //                 child: Text(
        //                   AppLocalizations.of(context)!
        //                       .translate("bitup_homet")!,
        //                   // overflow: TextOverflow.ellipsis,
        //                   softWrap: true,
        //                   textAlign: TextAlign.left,
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: getFontSize(
        //                       12,
        //                     ),
        //                     fontFamily: 'Poppins',
        //                     fontWeight: FontWeight.w900,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             // Padding(
        //             //   padding: const EdgeInsets.all(8.0),
        //             //   child: Image.asset(
        //             //       "assets/images/bitcoin code horz logo.png"),
        //             // ),
        //             Align(
        //               alignment: Alignment.center,
        //               child: Padding(
        //                 padding: getPadding(all: 10),
        //                 child: Text(
        //                   AppLocalizations.of(context)!
        //                       .translate("bitup_home1")!,
        //                   // overflow: TextOverflow.ellipsis,
        //                   softWrap: true,
        //                   textAlign: TextAlign.left,
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: getFontSize(
        //                       28,
        //                     ),
        //                     fontFamily: 'Poppins',
        //                     fontWeight: FontWeight.w900,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               // width: getHorizontalSize(
        //               //   215.00,
        //               // ),
        //               margin: getMargin(
        //                 left: 10,
        //                 top: 4,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home2")!,
        //                 maxLines: null,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.gray700,
        //                   fontSize: getFontSize(
        //                     16,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             if (disableIframe == true)
        //               Container(
        //                 padding: const EdgeInsets.only(
        //                     left: 10, right: 10),
        //                 height: 520,
        //                 child:
        //                     WebViewWidget(controller: controller),
        //               ),
        //             Padding(
        //               padding: getPadding(top: 15),
        //               child: Container(
        //                 height: getVerticalSize(
        //                   175.00,
        //                 ),
        //                 width: getHorizontalSize(double.infinity),
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                       image: AssetImage(
        //                           "assets/images/bitup_home_image1.png"),
        //                       fit: BoxFit.fill),
        //                   // color: ColorConstant.deepPurpleA70065.withOpacity(0.2),
        //                 ),
        //               ),
        //             ),
        //             Row(
        //               children: [
        //                 Expanded(
        //                   flex: 1,
        //                   child: Container(
        //                     padding: getPadding(
        //                       left: 9,
        //                       top: 10,
        //                       right: 9,
        //                       bottom: 10,
        //                     ),
        //                     decoration: BoxDecoration(
        //                       color: ColorConstant.blueGray900,
        //                     ),
        //                     child: Column(
        //                       crossAxisAlignment:
        //                           CrossAxisAlignment.start,
        //                       mainAxisAlignment:
        //                           MainAxisAlignment.center,
        //                       children: [
        //                         Text(
        //                           AppLocalizations.of(context)!
        //                               .translate("bitup_home3")!
        //                               .toUpperCase(),
        //                           overflow: TextOverflow.ellipsis,
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                             color: ColorConstant.whiteA700,
        //                             fontSize: getFontSize(
        //                               18,
        //                             ),
        //                             fontFamily: 'Poppins',
        //                             fontWeight: FontWeight.w500,
        //                           ),
        //                         ),
        //                         Container(
        //                           width: getHorizontalSize(
        //                             131.00,
        //                           ),
        //                           margin: getMargin(
        //                             top: 10,
        //                             bottom: 1,
        //                           ),
        //                           child: Text(
        //                             AppLocalizations.of(context)!
        //                                 .translate("bitup_home4")!,
        //                             maxLines: null,
        //                             textAlign: TextAlign.left,
        //                             style: TextStyle(
        //                               color: ColorConstant.gray300,
        //                               fontSize: getFontSize(
        //                                 15,
        //                               ),
        //                               fontFamily: 'Poppins',
        //                               fontWeight: FontWeight.w400,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //                 Expanded(
        //                   flex: 1,
        //                   child: Container(
        //                     padding: getPadding(
        //                       left: 9,
        //                       top: 10,
        //                       right: 9,
        //                       bottom: 10,
        //                     ),
        //                     decoration: BoxDecoration(
        //                       color: ColorConstant.blue80001,
        //                     ),
        //                     child: Column(
        //                       crossAxisAlignment:
        //                           CrossAxisAlignment.start,
        //                       mainAxisAlignment:
        //                           MainAxisAlignment.center,
        //                       children: [
        //                         Text(
        //                           AppLocalizations.of(context)!
        //                               .translate("bitup_home5")!
        //                               .toUpperCase(),
        //                           overflow: TextOverflow.ellipsis,
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                             color: ColorConstant.whiteA700,
        //                             fontSize: getFontSize(
        //                               18,
        //                             ),
        //                             fontFamily: 'Poppins',
        //                             fontWeight: FontWeight.w500,
        //                           ),
        //                         ),
        //                         Container(
        //                           width: getHorizontalSize(
        //                             131.00,
        //                           ),
        //                           margin: getMargin(
        //                             top: 10,
        //                             bottom: 1,
        //                           ),
        //                           child: Text(
        //                             AppLocalizations.of(context)!
        //                                 .translate("bitup_home6")!,
        //                             maxLines: null,
        //                             textAlign: TextAlign.left,
        //                             style: TextStyle(
        //                               color: ColorConstant.gray300,
        //                               fontSize: getFontSize(
        //                                 15,
        //                               ),
        //                               fontFamily: 'Poppins',
        //                               fontWeight: FontWeight.w400,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         width: getHorizontalSize(
        //           310.00,
        //         ),
        //         padding: getPadding(
        //           left: 13,
        //           top: 17,
        //           right: 13,
        //           bottom: 17,
        //         ),
        //         decoration: BoxDecoration(
        //           color: ColorConstant.blueGray900,
        //         ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Padding(
        //               padding: getPadding(
        //                 top: 27,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home7")!,
        //                 overflow: TextOverflow.ellipsis,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.whiteA700,
        //                   fontSize: getFontSize(
        //                     32,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w900,
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 283.00,
        //               ),
        //               margin: getMargin(
        //                 top: 33,
        //               ),
        //               padding: getPadding(
        //                 left: 31,
        //                 top: 14,
        //                 right: 31,
        //                 bottom: 14,
        //               ),
        //               decoration: BoxDecoration(
        //                 color: ColorConstant.indigoA200,
        //               ),
        //               child: Column(
        //                 crossAxisAlignment:
        //                     CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Padding(
        //                     padding: getPadding(
        //                       top: 2,
        //                     ),
        //                     child: Text(
        //                       AppLocalizations.of(context)!
        //                           .translate("bitup_home8")!
        //                           .toUpperCase(),
        //                       overflow: TextOverflow.ellipsis,
        //                       textAlign: TextAlign.left,
        //                       style: TextStyle(
        //                         color: ColorConstant.whiteA700,
        //                         fontSize: getFontSize(
        //                           18,
        //                         ),
        //                         fontFamily: 'Poppins',
        //                         fontWeight: FontWeight.w500,
        //                       ),
        //                     ),
        //                   ),
        //                   Container(
        //                     width: getHorizontalSize(
        //                       215.00,
        //                     ),
        //                     margin: getMargin(
        //                       top: 10,
        //                     ),
        //                     child: Text(
        //                       AppLocalizations.of(context)!
        //                           .translate("bitup_home9")!,
        //                       maxLines: null,
        //                       textAlign: TextAlign.left,
        //                       style: TextStyle(
        //                         color: ColorConstant.blueGray100,
        //                         fontSize: getFontSize(
        //                           15,
        //                         ),
        //                         fontFamily: 'Poppins',
        //                         fontWeight: FontWeight.w400,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 283.00,
        //               ),
        //               margin: getMargin(
        //                 top: 16,
        //               ),
        //               padding: getPadding(
        //                 left: 31,
        //                 top: 14,
        //                 right: 31,
        //                 bottom: 14,
        //               ),
        //               decoration: BoxDecoration(
        //                 color: ColorConstant.indigoA200,
        //               ),
        //               child: Column(
        //                 crossAxisAlignment:
        //                     CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Padding(
        //                     padding: getPadding(
        //                       top: 2,
        //                     ),
        //                     child: Text(
        //                       AppLocalizations.of(context)!
        //                           .translate("bitup_home10")!
        //                           .toUpperCase(),
        //                       overflow: TextOverflow.ellipsis,
        //                       textAlign: TextAlign.left,
        //                       style: TextStyle(
        //                         color: ColorConstant.whiteA700,
        //                         fontSize: getFontSize(
        //                           18,
        //                         ),
        //                         fontFamily: 'Poppins',
        //                         fontWeight: FontWeight.w500,
        //                       ),
        //                     ),
        //                   ),
        //                   Container(
        //                     width: getHorizontalSize(
        //                       215.00,
        //                     ),
        //                     margin: getMargin(
        //                       top: 10,
        //                     ),
        //                     child: Text(
        //                       AppLocalizations.of(context)!
        //                           .translate("bitup_home11")!,
        //                       maxLines: null,
        //                       textAlign: TextAlign.left,
        //                       style: TextStyle(
        //                         color: ColorConstant.blueGray100,
        //                         fontSize: getFontSize(
        //                           15,
        //                         ),
        //                         fontFamily: 'Poppins',
        //                         fontWeight: FontWeight.w400,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 283.00,
        //               ),
        //               margin: getMargin(
        //                 top: 16,
        //               ),
        //               padding: getPadding(
        //                 left: 31,
        //                 top: 14,
        //                 right: 31,
        //                 bottom: 14,
        //               ),
        //               decoration: BoxDecoration(
        //                 color: ColorConstant.indigoA200,
        //               ),
        //               child: Column(
        //                 crossAxisAlignment:
        //                     CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Padding(
        //                     padding: getPadding(
        //                       top: 2,
        //                     ),
        //                     child: Text(
        //                       AppLocalizations.of(context)!
        //                           .translate("bitup_home12")!
        //                           .toUpperCase(),
        //                       overflow: TextOverflow.ellipsis,
        //                       textAlign: TextAlign.left,
        //                       style: TextStyle(
        //                         color: ColorConstant.whiteA700,
        //                         fontSize: getFontSize(
        //                           18,
        //                         ),
        //                         fontFamily: 'Poppins',
        //                         fontWeight: FontWeight.w500,
        //                       ),
        //                     ),
        //                   ),
        //                   Container(
        //                     width: getHorizontalSize(
        //                       215.00,
        //                     ),
        //                     margin: getMargin(
        //                       top: 10,
        //                     ),
        //                     child: Text(
        //                       AppLocalizations.of(context)!
        //                           .translate("bitup_home13")!,
        //                       maxLines: null,
        //                       textAlign: TextAlign.left,
        //                       style: TextStyle(
        //                         color: ColorConstant.blueGray100,
        //                         fontSize: getFontSize(
        //                           15,
        //                         ),
        //                         fontFamily: 'Poppins',
        //                         fontWeight: FontWeight.w400,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 283.00,
        //               ),
        //               margin: getMargin(
        //                 top: 16,
        //               ),
        //               padding: getPadding(
        //                 left: 31,
        //                 top: 14,
        //                 right: 31,
        //                 bottom: 14,
        //               ),
        //               decoration: BoxDecoration(
        //                 color: ColorConstant.indigoA200,
        //               ),
        //               child: Column(
        //                 crossAxisAlignment:
        //                     CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Padding(
        //                     padding: getPadding(
        //                       top: 2,
        //                     ),
        //                     child: Text(
        //                       AppLocalizations.of(context)!
        //                           .translate("bitup_home14")!
        //                           .toUpperCase(),
        //                       overflow: TextOverflow.ellipsis,
        //                       textAlign: TextAlign.left,
        //                       style: TextStyle(
        //                         color: ColorConstant.whiteA700,
        //                         fontSize: getFontSize(
        //                           18,
        //                         ),
        //                         fontFamily: 'Poppins',
        //                         fontWeight: FontWeight.w500,
        //                       ),
        //                     ),
        //                   ),
        //                   Container(
        //                     width: getHorizontalSize(
        //                       215.00,
        //                     ),
        //                     margin: getMargin(
        //                       top: 10,
        //                     ),
        //                     child: Text(
        //                       AppLocalizations.of(context)!
        //                           .translate("bitup_home15")!,
        //                       maxLines: null,
        //                       textAlign: TextAlign.left,
        //                       style: TextStyle(
        //                         color: ColorConstant.blueGray100,
        //                         fontSize: getFontSize(
        //                           15,
        //                         ),
        //                         fontFamily: 'Poppins',
        //                         fontWeight: FontWeight.w400,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         height: getVerticalSize(
        //           607.00,
        //         ),
        //         width: getHorizontalSize(
        //           310.00,
        //         ),
        //         child: Stack(
        //           alignment: Alignment.center,
        //           children: [
        //             CustomImageView(
        //               imagePath: ImageConstant.imgImage,
        //               height: getVerticalSize(
        //                 607.00,
        //               ),
        //               width: getHorizontalSize(
        //                 310.00,
        //               ),
        //               alignment: Alignment.center,
        //             ),
        //             Align(
        //               alignment: Alignment.center,
        //               child: Padding(
        //                 padding: getPadding(
        //                   left: 23,
        //                   right: 23,
        //                 ),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   crossAxisAlignment:
        //                       CrossAxisAlignment.start,
        //                   mainAxisAlignment:
        //                       MainAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                       width: getHorizontalSize(
        //                         212.00,
        //                       ),
        //                       child: Text(
        //                         AppLocalizations.of(context)!
        //                             .translate("bitup_home16")!,
        //                         maxLines: null,
        //                         textAlign: TextAlign.left,
        //                         style: TextStyle(
        //                           color: ColorConstant.whiteA700,
        //                           fontSize: getFontSize(
        //                             34,
        //                           ),
        //                           fontFamily: 'Poppins',
        //                           fontWeight: FontWeight.w900,
        //                         ),
        //                       ),
        //                     ),
        //                     Container(
        //                       width: getHorizontalSize(
        //                         256.00,
        //                       ),
        //                       margin: getMargin(
        //                         top: 13,
        //                       ),
        //                       child: Text(
        //                         AppLocalizations.of(context)!
        //                             .translate("bitup_home17")!,
        //                         maxLines: null,
        //                         textAlign: TextAlign.left,
        //                         style: TextStyle(
        //                           color: ColorConstant.whiteA700,
        //                           fontSize: getFontSize(
        //                             20,
        //                           ),
        //                           fontFamily: 'Poppins',
        //                           fontWeight: FontWeight.w400,
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         width: getHorizontalSize(
        //           310.00,
        //         ),
        //         padding: getPadding(
        //           left: 23,
        //           top: 24,
        //           right: 23,
        //           bottom: 24,
        //         ),
        //         decoration: BoxDecoration(
        //           color: ColorConstant.whiteA700,
        //         ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Container(
        //               width: getHorizontalSize(
        //                 235.00,
        //               ),
        //               margin: getMargin(
        //                 top: 17,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home18")!,
        //                 maxLines: null,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.gray900,
        //                   fontSize: getFontSize(
        //                     34,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w900,
        //                 ),
        //               ),
        //             ),
        //             Padding(
        //               padding: getPadding(
        //                 top: 73,
        //                 right: 9,
        //               ),
        //               child: Row(
        //                 mainAxisAlignment:
        //                     MainAxisAlignment.spaceBetween,
        //                 crossAxisAlignment:
        //                     CrossAxisAlignment.start,
        //                 children: [
        //                   CustomImageView(
        //                     svgPath: ImageConstant.imgOrnament,
        //                     height: getVerticalSize(
        //                       332.00,
        //                     ),
        //                     width: getHorizontalSize(
        //                       21.00,
        //                     ),
        //                     margin: getMargin(
        //                       top: 1,
        //                       bottom: 23,
        //                     ),
        //                   ),
        //                   Column(
        //                     crossAxisAlignment:
        //                         CrossAxisAlignment.start,
        //                     mainAxisAlignment:
        //                         MainAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         AppLocalizations.of(context)!
        //                             .translate("bitup_home19")!
        //                             .toUpperCase(),
        //                         overflow: TextOverflow.ellipsis,
        //                         textAlign: TextAlign.left,
        //                         style: TextStyle(
        //                           color: ColorConstant.indigoA700,
        //                           fontSize: getFontSize(
        //                             22,
        //                           ),
        //                           fontFamily: 'Poppins',
        //                           fontWeight: FontWeight.w900,
        //                         ),
        //                       ),
        //                       Container(
        //                         width: getHorizontalSize(
        //                           212.00,
        //                         ),
        //                         margin: getMargin(
        //                           top: 12,
        //                         ),
        //                         child: Text(
        //                           AppLocalizations.of(context)!
        //                               .translate("bitup_home20")!,
        //                           maxLines: null,
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                             color:
        //                                 ColorConstant.blueGray400,
        //                             fontSize: getFontSize(
        //                               18,
        //                             ),
        //                             fontFamily: 'Poppins',
        //                             fontWeight: FontWeight.w400,
        //                           ),
        //                         ),
        //                       ),
        //                       Padding(
        //                         padding: getPadding(
        //                           top: 16,
        //                         ),
        //                         child: Text(
        //                           AppLocalizations.of(context)!
        //                               .translate("bitup_home21")!
        //                               .toUpperCase(),
        //                           overflow: TextOverflow.ellipsis,
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                             color: ColorConstant.indigoA700,
        //                             fontSize: getFontSize(
        //                               22,
        //                             ),
        //                             fontFamily: 'Poppins',
        //                             fontWeight: FontWeight.w900,
        //                           ),
        //                         ),
        //                       ),
        //                       Container(
        //                         width: getHorizontalSize(
        //                           212.00,
        //                         ),
        //                         margin: getMargin(
        //                           top: 12,
        //                         ),
        //                         child: Text(
        //                           AppLocalizations.of(context)!
        //                               .translate("bitup_home22")!,
        //                           maxLines: null,
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                             color:
        //                                 ColorConstant.blueGray400,
        //                             fontSize: getFontSize(
        //                               16,
        //                             ),
        //                             fontFamily: 'Poppins',
        //                             fontWeight: FontWeight.w400,
        //                           ),
        //                         ),
        //                       ),
        //                       Padding(
        //                         padding: getPadding(
        //                           top: 13,
        //                         ),
        //                         child: Text(
        //                           AppLocalizations.of(context)!
        //                               .translate("bitup_home23")!
        //                               .toUpperCase(),
        //                           overflow: TextOverflow.ellipsis,
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                             color: ColorConstant.indigoA700,
        //                             fontSize: getFontSize(
        //                               22,
        //                             ),
        //                             fontFamily: 'Poppins',
        //                             fontWeight: FontWeight.w900,
        //                           ),
        //                         ),
        //                       ),
        //                       Container(
        //                         width: getHorizontalSize(
        //                           212.00,
        //                         ),
        //                         margin: getMargin(
        //                           top: 12,
        //                         ),
        //                         child: Text(
        //                           AppLocalizations.of(context)!
        //                               .translate("bitup_home24")!,
        //                           maxLines: null,
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                             color:
        //                                 ColorConstant.blueGray400,
        //                             fontSize: getFontSize(
        //                               16,
        //                             ),
        //                             fontFamily: 'Poppins',
        //                             fontWeight: FontWeight.w400,
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         width: getHorizontalSize(
        //           310.00,
        //         ),
        //         padding: getPadding(
        //           left: 23,
        //           top: 43,
        //           right: 23,
        //           bottom: 43,
        //         ),
        //         decoration: BoxDecoration(
        //           color: ColorConstant.gray50,
        //         ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               height: getVerticalSize(
        //                 330.85,
        //               ),
        //               width: getHorizontalSize(
        //                 263.85,
        //               ),
        //               decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                     image: AssetImage(
        //                         "assets/images/bitup_home_image2.png"),
        //                     fit: BoxFit.fill),
        //               ),
        //             ),
        //             Padding(
        //               padding: getPadding(
        //                 top: 27,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home25")!,
        //                 // overflow: TextOverflow.ellipsis,
        //                 softWrap: true,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.gray900,
        //                   fontSize: getFontSize(
        //                     32,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w900,
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 213.00,
        //               ),
        //               margin: getMargin(
        //                 top: 14,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home26")!,
        //                 maxLines: null,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.gray900,
        //                   fontSize: getFontSize(
        //                     20,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //             ),
        //             Padding(
        //               padding: getPadding(
        //                 top: 6,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home27")!,
        //                 overflow: TextOverflow.ellipsis,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.indigoA700,
        //                   fontSize: getFontSize(
        //                     15,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w900,
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 213.00,
        //               ),
        //               margin: getMargin(
        //                 top: 14,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home28")!,
        //                 maxLines: null,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.gray900,
        //                   fontSize: getFontSize(
        //                     20,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //             ),
        //             Padding(
        //               padding: getPadding(
        //                 top: 6,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home29")!,
        //                 overflow: TextOverflow.ellipsis,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.indigoA700,
        //                   fontSize: getFontSize(
        //                     15,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w900,
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 213.00,
        //               ),
        //               margin: getMargin(
        //                 top: 14,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home30")!,
        //                 maxLines: null,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.gray900,
        //                   fontSize: getFontSize(
        //                     20,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //             ),
        //             Padding(
        //               padding: getPadding(
        //                 top: 6,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home31")!,
        //                 overflow: TextOverflow.ellipsis,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.indigoA700,
        //                   fontSize: getFontSize(
        //                     15,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w900,
        //                 ),
        //               ),
        //             ),
        //             // Container(
        //             //   height: getVerticalSize(
        //             //     3.00,
        //             //   ),
        //             //   margin: getMargin(
        //             //     top: 23,
        //             //     bottom: 3,
        //             //   ),
        //             //   child: SmoothIndicator(
        //             //     offset: 0,
        //             //     count: 6,
        //             //     axisDirection: Axis.horizontal,
        //             //     effect: ScrollingDotsEffect(
        //             //       spacing: 3.300003,
        //             //       activeDotColor: ColorConstant.indigoA700,
        //             //       dotColor: ColorConstant.gray9004c,
        //             //       dotHeight: getVerticalSize(
        //             //         3.00,
        //             //       ),
        //             //       dotWidth: getHorizontalSize(
        //             //         41.00,
        //             //       ),
        //             //     ),
        //             //   ),
        //             // ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         width: getHorizontalSize(
        //           310.00,
        //         ),
        //         padding: getPadding(
        //           top: 22,
        //           bottom: 22,
        //         ),
        //         decoration: BoxDecoration(
        //           color: ColorConstant.blueGray900,
        //         ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Align(
        //               alignment: Alignment.centerRight,
        //               child: Padding(
        //                 padding: getPadding(
        //                     top: 24, right: 40, left: 20),
        //                 child: Text(
        //                   AppLocalizations.of(context)!
        //                       .translate("bitup_home32")!,
        //                   // overflow: TextOverflow.ellipsis,
        //                   softWrap: true,
        //                   textAlign: TextAlign.left,
        //                   style: TextStyle(
        //                     color: ColorConstant.whiteA700,
        //                     fontSize: getFontSize(
        //                       29.776594161987305,
        //                     ),
        //                     fontFamily: 'Poppins',
        //                     fontWeight: FontWeight.w900,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.center,
        //               child: Container(
        //                 height: getVerticalSize(
        //                   248.00,
        //                 ),
        //                 width: getHorizontalSize(
        //                   263.00,
        //                 ),
        //                 margin: getMargin(
        //                   top: 40,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                       image: AssetImage(
        //                           "assets/images/bitup_home_image3.png"),
        //                       fit: BoxFit.fill),
        //                   // color: ColorConstant.gray400,
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 242.00,
        //               ),
        //               margin: getMargin(
        //                 left: 23,
        //                 top: 25,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home33")!,
        //                 maxLines: null,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.whiteA700,
        //                   fontSize: getFontSize(
        //                     28,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w900,
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               width: getHorizontalSize(
        //                 237.00,
        //               ),
        //               margin: getMargin(
        //                 left: 23,
        //                 top: 6,
        //               ),
        //               child: Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("bitup_home34")!,
        //                 maxLines: null,
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                   color: ColorConstant.gray30001,
        //                   fontSize: getFontSize(
        //                     18,
        //                   ),
        //                   fontFamily: 'Poppins',
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.centerRight,
        //               child: SingleChildScrollView(
        //                 scrollDirection: Axis.horizontal,
        //                 padding: getPadding(
        //                   left: 23,
        //                   top: 66,
        //                 ),
        //                 child: IntrinsicWidth(
        //                   child: Row(
        //                     mainAxisAlignment:
        //                         MainAxisAlignment.center,
        //                     children: [
        //                       Container(
        //                         height: getVerticalSize(
        //                           200.00,
        //                         ),
        //                         width: getHorizontalSize(
        //                           100.00,
        //                         ),
        //                         decoration: BoxDecoration(
        //                           image: DecorationImage(
        //                               image: AssetImage(
        //                                   "assets/images/bitup_home_image4.png"),
        //                               fit: BoxFit.fill),
        //                           // color: ColorConstant.blueGray10001,
        //                         ),
        //                       ),
        //                       Padding(
        //                         padding: getPadding(
        //                           left: 16,
        //                           right: 16,
        //                           top: 26,
        //                           bottom: 35,
        //                         ),
        //                         child: Column(
        //                           crossAxisAlignment:
        //                               CrossAxisAlignment.start,
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.start,
        //                           children: [
        //                             Text(
        //                               AppLocalizations.of(context)!
        //                                   .translate(
        //                                       "bitup_home35")!,
        //                               overflow:
        //                                   TextOverflow.ellipsis,
        //                               textAlign: TextAlign.left,
        //                               style: TextStyle(
        //                                 color:
        //                                     ColorConstant.whiteA700,
        //                                 fontSize: getFontSize(
        //                                   18,
        //                                 ),
        //                                 fontFamily: 'Poppins',
        //                                 fontWeight: FontWeight.w900,
        //                               ),
        //                             ),
        //                             Container(
        //                               width: getHorizontalSize(
        //                                 130.00,
        //                               ),
        //                               margin: getMargin(
        //                                 top: 8,
        //                               ),
        //                               child: Text(
        //                                 AppLocalizations.of(
        //                                         context)!
        //                                     .translate(
        //                                         "bitup_home36")!,
        //                                 maxLines: null,
        //                                 textAlign: TextAlign.left,
        //                                 style: TextStyle(
        //                                   color: ColorConstant
        //                                       .gray30001,
        //                                   fontSize: getFontSize(
        //                                     15,
        //                                   ),
        //                                   fontFamily: 'Poppins',
        //                                   fontWeight:
        //                                       FontWeight.w400,
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       Container(
        //                         height: getVerticalSize(
        //                           200.00,
        //                         ),
        //                         width: getHorizontalSize(
        //                           100.00,
        //                         ),
        //                         decoration: BoxDecoration(
        //                           image: DecorationImage(
        //                               image: AssetImage(
        //                                   "assets/images/bitup_home_image5.png"),
        //                               fit: BoxFit.fill),
        //                           // color: ColorConstant.blueGray10001,
        //                         ),
        //                       ),
        //                       // CustomImageView(
        //                       //   imagePath: ImageConstant.imgImage116x66,
        //                       //   height: getVerticalSize(
        //                       //     200.00,
        //                       //   ),
        //                       //   width: getHorizontalSize(
        //                       //     100.00,
        //                       //   ),
        //                       //   margin: getMargin(
        //                       //     left: 25,
        //                       //   ),
        //                       // ),
        //                       // Padding(
        //                       //   padding: getPadding(
        //                       //     left: 16,
        //                       //   ),
        //                       //   child: Column(
        //                       //     mainAxisAlignment:
        //                       //     MainAxisAlignment.start,
        //                       //     children: [
        //                       //       Container(
        //                       //         width: getHorizontalSize(
        //                       //           134.00,
        //                       //         ),
        //                       //         child: Text(
        //                       //           "Use the Bitcoin Up app right now.",
        //                       //           maxLines: null,
        //                       //           textAlign: TextAlign.left,
        //                       //           style: TextStyle(
        //                       //             color: ColorConstant.whiteA700,
        //                       //             fontSize: getFontSize(
        //                       //               18,
        //                       //             ),
        //                       //             fontFamily: 'Poppins',
        //                       //             fontWeight: FontWeight.w900,
        //                       //           ),
        //                       //         ),
        //                       //       ),
        //                       //       Container(
        //                       //         width: getHorizontalSize(
        //                       //           134.00,
        //                       //         ),
        //                       //         margin: getMargin(
        //                       //           top: 9,
        //                       //         ),
        //                       //         child: Text(
        //                       //           "Researchers at DEF Genetics have made significant progress in the use of gene editing to treat [disease]. Using the CRISPR-Cas9 system, the team was able to make targeted changes to the genome of cells affected by the disease, resulting in a reduction of symptoms and an improvement in patient outcomes. While the research is still in its early stages, the results are promising and suggest that gene editing may one day be a viable treatment option for [disease]. The team is now working to refine the technique and conduct further studies to confirm the effectiveness of this approach",
        //                       //           maxLines: null,
        //                       //           textAlign: TextAlign.left,
        //                       //           style: TextStyle(
        //                       //             color: ColorConstant.gray30001,
        //                       //             fontSize: getFontSize(
        //                       //               15,
        //                       //             ),
        //                       //             fontFamily: 'Poppins',
        //                       //             fontWeight: FontWeight.w400,
        //                       //           ),
        //                       //         ),
        //                       //       ),
        //                       //     ],
        //                       //   ),
        //                       // ),
        //                       // CustomImageView(
        //                       //   imagePath: ImageConstant.imgImage1,
        //                       //   height: getVerticalSize(
        //                       //     116.00,
        //                       //   ),
        //                       //   width: getHorizontalSize(
        //                       //     66.00,
        //                       //   ),
        //                       //   margin: getMargin(
        //                       //     left: 19,
        //                       //   ),
        //                       // ),
        //                       // Padding(
        //                       //   padding: getPadding(
        //                       //     left: 16,
        //                       //     top: 8,
        //                       //     bottom: 8,
        //                       //   ),
        //                       //   child: Column(
        //                       //     mainAxisAlignment:
        //                       //     MainAxisAlignment.start,
        //                       //     children: [
        //                       //       Container(
        //                       //         width: getHorizontalSize(
        //                       //           135.00,
        //                       //         ),
        //                       //         child: Text(
        //                       //           "Artificial intelligence helps predict risk of disease",
        //                       //           maxLines: null,
        //                       //           textAlign: TextAlign.left,
        //                       //           style: TextStyle(
        //                       //             color: ColorConstant.whiteA700,
        //                       //             fontSize: getFontSize(
        //                       //               11.579787254333496,
        //                       //             ),
        //                       //             fontFamily: 'Poppins',
        //                       //             fontWeight: FontWeight.w900,
        //                       //           ),
        //                       //         ),
        //                       //       ),
        //                       //       Container(
        //                       //         width: getHorizontalSize(
        //                       //           135.00,
        //                       //         ),
        //                       //         margin: getMargin(
        //                       //           top: 9,
        //                       //         ),
        //                       //         child: Text(
        //                       //           "Researchers at GHI Artificial Intelligence have developed a machine learning algorithm that can accurately predict an individual's risk of developing [disease]. The algorithm, which utilizes data from electronic health records, genetic information, and lifestyle factors, can identify patterns and risk factors that may be missed by traditional methods. The team hopes that this technology will allow healthcare providers to identify individuals at high risk for [disease] and intervene early to prevent the onset of the disease. The algorithm has shown promising results in early tests and the team is now working to bring it to market and make it widely available to healthcare providers.",
        //                       //           maxLines: null,
        //                       //           textAlign: TextAlign.left,
        //                       //           style: TextStyle(
        //                       //             color: ColorConstant.gray30001,
        //                       //             fontSize: getFontSize(
        //                       //               9.925531387329102,
        //                       //             ),
        //                       //             fontFamily: 'Poppins',
        //                       //             fontWeight: FontWeight.w400,
        //                       //           ),
        //                       //         ),
        //                       //       ),
        //                       //     ],
        //                       //   ),
        //                       // ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         height: getVerticalSize(
        //           479.00,
        //         ),
        //         width: size.width,
        //         decoration: BoxDecoration(
        //           color: ColorConstant.gray90001,
        //         ),
        //         child: Stack(
        //           alignment: Alignment.centerLeft,
        //           children: [
        //             CustomImageView(
        //               imagePath: ImageConstant.imgImagebackground,
        //               height: getVerticalSize(
        //                 500,
        //               ),
        //               width: getHorizontalSize(
        //                 311.00,
        //               ),
        //               alignment: Alignment.center,
        //             ),
        //             Align(
        //               alignment: Alignment.centerLeft,
        //               child: Padding(
        //                 padding: getPadding(
        //                   left: 10,
        //                 ),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   mainAxisAlignment:
        //                       MainAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                       child: Text(
        //                         AppLocalizations.of(context)!
        //                             .translate("bitup_home37")!,
        //                         maxLines: null,
        //                         textAlign: TextAlign.center,
        //                         style: TextStyle(
        //                           color: ColorConstant.whiteA700,
        //                           fontSize: getFontSize(
        //                             33.085105895996094,
        //                           ),
        //                           fontFamily: 'Poppins',
        //                           fontWeight: FontWeight.w900,
        //                         ),
        //                       ),
        //                     ),
        //                     // CustomButton(
        //                     //   height: 57,
        //                     //   width: 229,
        //                     //   text: "Join",
        //                     //   margin: getMargin(
        //                     //     top: 44,
        //                     //   ),
        //                     // ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       // CustomBottomBar(
        //       //   onChanged: (BottomBarEnum type) {},
        //       // )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
