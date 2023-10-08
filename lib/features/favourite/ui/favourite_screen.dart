import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/features/favourite/bloc/favourite_bloc.dart';
import 'package:subspace/features/favourite/ui/fav_tile.dart';

class FavouritrScreen extends StatefulWidget {
  const FavouritrScreen({super.key});

  @override
  State<FavouritrScreen> createState() => _FavouritrScreenState();
}

class _FavouritrScreenState extends State<FavouritrScreen> {
  FavouriteBloc favouriteBloc = FavouriteBloc();
  @override
  void initState() {
    favouriteBloc.add(FavouriteInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteBloc, FavouriteState>(
      bloc: favouriteBloc,
      listenWhen: (previous, current) => current is FavouriteActionState,
      buildWhen: (previous, current) => current is! FavouriteActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case FavouriteInitialState:
            final succesState = state as FavouriteInitialState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple,
              ),
              backgroundColor: Colors.purpleAccent,
              body: ListView.builder(
                itemCount: succesState.favItems.length,
                itemBuilder: (context, index) {
                  return FavTile(
                      blog: succesState.favItems[index],
                      favouriteBloc: favouriteBloc);
                },
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
