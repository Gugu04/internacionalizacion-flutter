import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Se guarda el idioma seleccionado con el paquete SharedPreferences
Future<Locale> setLocale(String languageCode, String countryCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setStringList('language', [languageCode, countryCode]);
  return Locale(languageCode, countryCode);
}

/*Se valida si existe un dato guardado de
lo contrario mostrará un idioma por default
*/
Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  List<String> listLocal = _prefs.getStringList('language');
  if (listLocal == null) {
    return Locale('es', 'MX');
  }
  Locale local = Locale(listLocal[0], listLocal[1]);

  return local;
}
