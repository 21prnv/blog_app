part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class DetailsInitialEvent extends DetailsEvent {}

class DetailsFavButtonClickedEvent extends DetailsEvent {
  final Blog blog;

  DetailsFavButtonClickedEvent({required this.blog});
}
