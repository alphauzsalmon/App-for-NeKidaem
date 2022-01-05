import 'package:flutter/material.dart';
import 'package:ne_kidaem/card/constants/size_config.dart';
import 'package:ne_kidaem/card/screens/login_page/login_page_widgets.dart';
import 'package:ne_kidaem/language/models/language.dart';


class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);
  static TextEditingController username = TextEditingController();
  static TextEditingController password = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        appBar: AppBarWidget(),
        body: Padding(padding: EdgeInsets.symmetric(
          horizontal: getWidth(30.0),
          vertical: getHeight(50.0),
        ),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LanguageButton(language: Languages.languages.first.value, index: 0),
                    LanguageButton(language: Languages.languages.last.value, index: 1),
                  ],
                ),
                const UserNameTextField(),
                const PasswordTextField(),
                const ElevatedButtonWidget(),
              ],
            ),
          ),),
      );
  }
}
