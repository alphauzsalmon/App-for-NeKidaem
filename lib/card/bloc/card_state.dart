part of 'card_bloc.dart';

abstract class CardsState {
  const CardsState();
}

class CardsLoading extends CardsState {
  const CardsLoading() : super();
}

class CardsCompleted extends CardsState {
  final List<OurCard> response;
  const CardsCompleted(this.response);
}

class CardsUnAuthorized extends CardsState {
  final message;
  const CardsUnAuthorized(this.message);
}

class CardsError extends CardsState {
  final message;
  const CardsError({required this.message});
}