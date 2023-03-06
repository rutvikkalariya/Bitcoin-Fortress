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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ExpansionTile(
                        title: Text(
                          AppLocalizations.of(context)!.translate("newhome39")!,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: getColorFromHex("#020248"),
                            fontSize: getFontSize(
                              28,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        children: [
                          Container(
                            // color: Colors.black12,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Text(
                              // "The most well-known and widely-used altcoin is bitcoin. Even if technology isn't your thing, you've undoubtedly heard of the company.",
                              AppLocalizations.of(context)!
                                  .translate("newhome40")!,
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
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      ExpansionTile(
                        title: Text(
                          AppLocalizations.of(context)!.translate("newhome41")!,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: getColorFromHex("#020248"),
                            fontSize: getFontSize(
                              28,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        children: [
                          Container(
                            // color: Colors.black12,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Text(
                              // "The most well-known and widely-used altcoin is bitcoin. Even if technology isn't your thing, you've undoubtedly heard of the company.",
                              AppLocalizations.of(context)!
                                  .translate("newhome411")!,
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
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      ExpansionTile(
                        title: Text(
                          AppLocalizations.of(context)!.translate("newhome42")!,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: getColorFromHex("#020248"),
                            fontSize: getFontSize(
                              28,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        children: [
                          Container(
                            // color: Colors.black12,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Text(
                              // "The most well-known and widely-used altcoin is bitcoin. Even if technology isn't your thing, you've undoubtedly heard of the company.",
                              AppLocalizations.of(context)!
                                  .translate("newhome422")!,
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
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      ExpansionTile(
                        title: Text(
                          // "What is Bitcoin?",
                          AppLocalizations.of(context)!.translate("newhome43")!,
                          // overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: getColorFromHex("#020248"),
                            fontSize: getFontSize(
                              28,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        children: [
                          Container(
                            // color: Colors.black12,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Text(
                              // "The most well-known and widely-used altcoin is bitcoin. Even if technology isn't your thing, you've undoubtedly heard of the company.",
                              AppLocalizations.of(context)!
                                  .translate("newhome433")!,
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
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      ExpansionTile(
                        title: Text(
                          // "What is Bitcoin?",
                          AppLocalizations.of(context)!.translate("newhome44")!,
                          // overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: getColorFromHex("#020248"),
                            fontSize: getFontSize(
                              28,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        children: [
                          Container(
                            // color: Colors.black12,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Text(
                              // "The most well-known and widely-used altcoin is bitcoin. Even if technology isn't your thing, you've undoubtedly heard of the company.",
                              AppLocalizations.of(context)!
                                  .translate("newhome444")!,
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
