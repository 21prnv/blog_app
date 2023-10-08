import 'package:flutter/material.dart';
import 'package:subspace/features/favourite/bloc/favourite_bloc.dart';
import 'package:subspace/model/blog.dart';

class FavTile extends StatefulWidget {
  const FavTile({super.key, required this.blog, required this.favouriteBloc});
  final Blog blog;
  final FavouriteBloc favouriteBloc;

  @override
  State<FavTile> createState() => _FavTileState();
}

class _FavTileState extends State<FavTile> {
  bool isClicked = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(9))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.blog.imageUrl))),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.blog.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ],
          )
        ],
      ),
    );
  }
}
