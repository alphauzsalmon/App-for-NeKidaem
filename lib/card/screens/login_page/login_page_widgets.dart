import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ne_kidaem/card/constants/size_config.dart';
import 'package:ne_kidaem/card/constants/hive.dart';
import 'package:ne_kidaem/card/screens/lists_page/bloc_builder.dart';
import 'package:ne_kidaem/card/screens/lists_page/lists_page.dart';
import 'package:ne_kidaem/card/screens/login_page/login_page.dart';
import 'package:ne_kidaem/card/constants/colors.dart';
import 'package:ne_kidaem/language/app_localization.dart';
import 'package:ne_kidaem/language/bloc/language_bloc.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  AppBarWidget({Key? key})
      : preferredSize = Size.fromHeight(getHeight(50.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Kanban",
        style: TextStyle(fontSize: getFont(20.0), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.grey,
    );
  }

  @override
  final Size preferredSize;
}

class UserNameTextField extends StatelessWidget {
  const UserNameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: LogInPage.username,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getFont(30.0),
          ),
        ),
        hintText: AppLocalizations.of(context)!.translate('usernameField'),
      ),
      validator: (inputText) {
        if (inputText!.length < 4) {
          return AppLocalizations.of(context)!.translate('usernameValidator');
        }
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: LogInPage.password,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getFont(30.0),
          ),
        ),
        hintText: AppLocalizations.of(context)!.translate('passwordField'),
      ),
      obscureText: true,
      validator: (inputText) {
        if (inputText!.length < 8) {
          return AppLocalizations.of(context)!.translate('passwordValidator');
        }
      },
    );
  }
}

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (LogInPage.formKey.currentState!.validate()) {
          onPressed(context);
        }
      },
      child: Text(
        AppLocalizations.of(context)!.translate('login')!,
        style: TextStyle(
          color: Colors.black,
          fontSize: getFont(20.0),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getFont(30.0),
          ),
        ),
        primary: cyanAccent,
        fixedSize: Size(
          getWidth(400.0),
          getHeight(60.0),
        ),
      ),
    );
  }

  onPressed(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BlocBuilderWidget(),
        ),
      );
    } else {
      if (cardBox!.isNotEmpty) {
        String userName = await boxUser!.get('userName');
        String password = await boxUser!.get('password');
        if (userName == LogInPage.username.text &&
            password == LogInPage.password.text) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListsPage(data: cardBox!.values.toList()),
            ),
          );
        } else {
          showDialog(
              context: (context),
              builder: (context) {
                return AlertDialogWidget(
                    text: AppLocalizations.of(context)!.translate('invalidAuth')!);
              });
        }
      }
    }
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key, required this.language, required this.index}) : super(key: key);
  final String language;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(child: Text(language, style: const TextStyle(color: Colors.black),),
    onPressed: () {
      BlocProvider.of<LanguageBloc>(context).add(
        ToggleLanguageEvent(
          index,
      ),);
    },
      style: ElevatedButton.styleFrom(
        primary: cyanAccent,
      ),
    );
  }
}

