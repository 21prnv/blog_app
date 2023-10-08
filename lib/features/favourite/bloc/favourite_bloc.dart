import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:subspace/data/fav_data.dart';
import 'package:subspace/model/blog.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<FavouriteInitialEvent>(favouriteInitialEvent);
    on<FavouriteRemoveFavEvent>(favouriteRemoveFavEvent);
  }

  FutureOr<void> favouriteInitialEvent(
      FavouriteInitialEvent event, Emitter<FavouriteState> emit) {
    emit(FavouriteInitialState(favItems: favBlogs));
  }

  FutureOr<void> favouriteRemoveFavEvent(
      FavouriteRemoveFavEvent event, Emitter<FavouriteState> emit) {
    favBlogs.remove(event.removeFav);
    emit(FavouriteInitialState(favItems: favBlogs));
  }
}
