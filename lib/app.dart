import 'package:bloc_course/core/constants/constants.dart';
import 'package:bloc_course/core/theme/app_theme.dart';
import 'package:bloc_course/cubit/cubit/locale_cubit.dart';
import 'package:bloc_course/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit()..getSavedLanguage(),
      child: BlocBuilder<LocaleCubit, ChangeLocalState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            // ==== Localization ==== //
            locale: state.locale,
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
              return null;
            },
            // ==== Localization ==== //

            theme: appTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
