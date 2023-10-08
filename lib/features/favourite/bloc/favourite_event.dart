part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class FavouriteInitialEvent extends FavouriteEvent {}

class FavouriteRemoveFavEvent extends FavouriteEvent {
  final Blog removeFav;

  FavouriteRemoveFavEvent({required this.removeFav});
}
