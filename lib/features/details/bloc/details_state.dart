part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsActionState extends DetailsState {}

class DetailsFavButtonActionState extends DetailsActionState {}
