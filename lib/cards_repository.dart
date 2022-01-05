import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:ne_kidaem/card/screens/login_page/login_page.dart';

abstract class CardsRepository {
  Future<List> getCardsFromApi();
}

class SampleCardsRepository extends CardsRepository {
  @override
  Future<List> getCardsFromApi() async {
    var auth = 'Basic ' + base64Encode(utf8.encode('${LogInPage.username.text}:${LogInPage.password.text}'));
      var response = await Dio().get(
        'https://trello.backend.tests.nekidaem.ru/api/v1/cards',
        options: Options(headers: <String, String>{'authorization': auth}),);
      return response.data;
  }
}
