// // ignore_for_file: deprecated_member_use

// import 'package:flutter/widgets.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'dart:ui' as ui;

// import 'package:hooks_riverpod/hooks_riverpod.dart';

// /// provider used to access the AppLocalizations object for the current locale
// final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
//   // set the initial locale
//   ref.state = lookupAppLocalizations(ui.window.locale);
//   // update afterwards
//   final observer = _LocaleObserver((locales) {
//     ref.state = lookupAppLocalizations(ui.window.locale);
//   });
//   final binding = WidgetsBinding.instance;
//   binding.addObserver(observer);
//   ref.onDispose(() => binding.removeObserver(observer));
//   return ref.state;
// });

// /// observed used to notify the caller when the locale changes
// class _LocaleObserver extends WidgetsBindingObserver {
//   _LocaleObserver(this._didChangeLocales);
//   final void Function(List<Locale>? locales) _didChangeLocales;
//   @override
//   void didChangeLocales(List<Locale>? locales) {
//     _didChangeLocales(locales);
//   }
// }
