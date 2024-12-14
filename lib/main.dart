import 'package:barber/addclient.dart';
import 'package:barber/queue_page.dart';
import 'package:barber/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'sqldb.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'ar']); // get last saved language
  await SqlDb().intialDb();


  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (create) => SqlDb()),
      ChangeNotifierProvider(create: (create) => ThemeProvider()),
    ],
     child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
        builder: (locale) => MaterialApp(
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          title: 'barber',

      debugShowCheckedModeBanner: false,
      home: const QueuePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,

      routes: {"addclient": (context) => const AddClient()},

    ));
  }
}

