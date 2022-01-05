import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ne_kidaem/card/models/card.dart';
import 'package:ne_kidaem/card/constants/hive.dart';
import 'package:ne_kidaem/card/screens/lists_page/bloc_builder.dart';
import 'package:ne_kidaem/language/bloc/language_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'card/screens/login_page/login_page.dart';
import 'language/app_localization.dart';
import 'language/models/language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();

  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(OurCardAdapter());

  await openHiveBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageBloc(),
      child: BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
        if (state is LanguageLoaded) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Test app for NeKidaem',
            theme: ThemeData(
              brightness: Brightness.dark,
            ),
            supportedLocales:
                Languages.languages.map((e) => Locale(e.code)).toList(),
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: const LogInPage(),
          );
        }
        return const CircularScaffoldWidget();
      }),
    );
  }
}
