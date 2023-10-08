part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFetchSuccessState extends HomeState {
  final List<Blog> blogss;
  HomeFetchSuccessState({required this.blogss});
}

class HomeErrorState extends HomeState {
  final String err;
  HomeErrorState({required this.err});
}

class HomeNavigateToFavouriteScreen extends HomeActionState {}

class HomeNavigateToDetailsScreen extends HomeActionState {}
