import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ne_kidaem/card/models/card.dart';
import 'package:ne_kidaem/card/constants/hive.dart';
import 'package:ne_kidaem/card/screens/login_page/login_page.dart';
import 'package:ne_kidaem/cards_repository.dart';
part 'cart_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardsEvent, CardsState> {
  final CardsRepository cardsRepository;
  CardBloc(this.cardsRepository,) : super(const CardsLoading()) {
    on<CardsStarted>(getCards);
  }

  getCards(CardsStarted event, Emitter<CardsState> emit) async {
    emit(const CardsLoading());
    try {
      final response = (await cardsRepository.getCardsFromApi()).map((e) => OurCard.fromJson(e)).toList();
      await cardBox!.clear();
      await boxUser!.clear();
      boxUser!.put('userName', LogInPage.username.text);
      boxUser!.put('password', LogInPage.password.text);
      LogInPage.username.clear();
      LogInPage.password.clear();
      emit(CardsCompleted(response));
    } on DioError catch (e) {
      if (e.type == DioErrorType.response && e.response!.statusCode == 401) {
        emit(CardsUnAuthorized(e.response!.data['detail']));
      }
      else {
        emit(CardsError(message: e.error));
      }
    }
  }
}