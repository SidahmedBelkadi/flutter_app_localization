import 'package:bloc_course/core/constants/constants.dart';
import 'package:bloc_course/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ==== Localization ==== //
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        supportedLocales.map((locale) {
          if (deviceLocale != null && (deviceLocale.languageCode == locale.languageCode)) {
            return deviceLocale;
          } else {
            return supportedLocales.first;
          }
        });
      },
      // ==== Localization ==== //

      theme: appTheme,
      home: const HomePage(),
    );
  }
}
