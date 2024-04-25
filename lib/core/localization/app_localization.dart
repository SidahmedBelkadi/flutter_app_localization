import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A class for managing localized strings in the app.
class AppLocalizations {
  final Locale? locale;

  /// Constructor for AppLocalizations.
  ///
  /// [locale]: The locale for which localized strings will be loaded.
  AppLocalizations({
    this.locale,
  });

  /// Returns an instance of AppLocalizations using the [BuildContext] to look up
  /// the nearest instance of this class that encloses the given context.
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// Delegate for the AppLocalizations class.
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  /// Loads the JSON file containing the localized strings for the current locale.
  ///
  /// This method loads the JSON file from the assets directory and parses it to
  /// populate the [_localizedStrings] map.
  Future loadJsonLanguage() async {
    String jsonString = await rootBundle
        .loadString("assets/lang/${locale!.languageCode}/${locale!.languageCode}.json");

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  /// Translates the given [key] to the localized string.
  ///
  /// Returns the localized string corresponding to the provided [key]. If the
  /// key is not found in the localized strings, it returns an empty string.
  String translate(String key) => _localizedStrings[key] ?? "";
}

/// Delegate class for the AppLocalizations.
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Returns true if the provided locale's language code is either 'en' or 'ar'.
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Loads the AppLocalizations for the provided locale.
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.loadJsonLanguage();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}

/// Extension method to translate strings using the AppLocalizations instance.
extension TranslateX on String {
  /// Translates the current string using the nearest AppLocalizations instance.
  ///
  /// Returns the translated string corresponding to the current string key.
  String tr(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}
