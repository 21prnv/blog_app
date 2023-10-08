part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {}

class LoadingEvent extends HomeEvent {}

class HomeFavouriteButtonNavigateEvent extends HomeEvent {}

class HomeBlogDetailsNavigateEvent extends HomeEvent {}
