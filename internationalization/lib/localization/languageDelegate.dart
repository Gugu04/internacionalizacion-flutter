import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageDelegate {
  LanguageDelegate(this.locale);

  final Locale locale;
  static LanguageDelegate of(BuildContext context) =>
      Localizations.of<LanguageDelegate>(context, LanguageDelegate);

  Map<String, String> _localizedValues;

//Busca el JSON del idioma seleccionado y lo carga
  Future<void> load() async {
    String jsonStringValues = await rootBundle
        .loadString('lib/localization/lang/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

//Busca las claves del JSON
  String translate(String key) => _localizedValues[key];

  /*Método estático para tener acceso simple al delegado desde la Material App
    de la clases main
  */
  static const LocalizationsDelegate<LanguageDelegate> delegate =
      _LocalizationsDelegate();
}

//clase abstract
class _LocalizationsDelegate
    extends LocalizationsDelegate<LanguageDelegate> {
  const _LocalizationsDelegate();

//Método para validar los idomas soportados
  @override
  bool isSupported(Locale locale) =>
      ['es', 'en', 'pt', 'fr', 'hi'].contains(locale.languageCode);

  @override
  Future<LanguageDelegate> load(Locale locale) async {
    LanguageDelegate localization = new LanguageDelegate(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LanguageDelegate> old) => false;
}
