import 'package:bloc/bloc.dart';
import 'package:bloc_course/core/helpers/lang_cache_helper.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocalState> {
  LocaleCubit() : super(ChangeLocalState(locale: const Locale('en')));

  Future<void> getSavedLanguage() async {
    final String getCahedLanguageCode = await LanguageCacheHelper.getCachedLanguageCode();

    emit(ChangeLocalState(locale: Locale(getCahedLanguageCode)));
  }

  Future<void> changeLocale({required String languageCode}) async {
    await LanguageCacheHelper.cacheLanguageCode(languageCode);

    emit(ChangeLocalState(locale: Locale(languageCode)));
  }
}
