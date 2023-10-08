part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteState {}

abstract class FavouriteActionState extends FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteInitialState extends FavouriteState {
  final List<Blog> favItems;
  FavouriteInitialState({required this.favItems});
}
