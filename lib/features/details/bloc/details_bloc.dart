import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:subspace/data/fav_data.dart';
import 'package:subspace/model/blog.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsFavButtonClickedEvent>(detailsFavButtonClickedEvent);
  }

  FutureOr<void> detailsFavButtonClickedEvent(
      DetailsFavButtonClickedEvent event, Emitter<DetailsState> emit) {
    favBlogs.add(event.blog);
    emit(DetailsFavButtonActionState());
  }
}
