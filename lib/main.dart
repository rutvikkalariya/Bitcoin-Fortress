import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'localization/AppLanguage.dart';
import 'localization/app_localizations.dart';
import 'trends_pages_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage? appLanguage;
  MyApp({this.appLanguage});

  // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage!,
      child: Consumer<AppLanguage>(
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // navigatorObservers: [
            //   // FirebaseAnalyticsObserver(analytics: analytics)
            // ],
            title: 'Bitcoin Fortress',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.openSansTextTheme(),
            ),
            locale: model.appLocal,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('ar', ''),
              const Locale('de', ''),
              const Locale('es', ''),
              const Locale('fi', ''),
              const Locale('fr', ''),
              const Locale('it', ''),
              const Locale('nl', ''),
              const Locale('nb', ''),
              const Locale('pt', ''),
              const Locale('ru', ''),
              const Locale('sv', '')
            ],
            routes: <String, WidgetBuilder>{
              '/myHomePage': (BuildContext context) => new MyHomePage(),
              '/homePage': (BuildContext context) => new HomePage(),
            },
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/Splash.jpg',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
            ),
            Image.asset(
              'assets/images/bitcoin code logo.png',
              width: MediaQuery.of(context).size.width * .3,
            )
          ],
        ));
  }

  @override
  void initState() {
    homePage();
    super.initState();
  }

  Future<void> homePage() async {
    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      Navigator.of(context).pushReplacementNamed('/homePage');
    });
  }
}
