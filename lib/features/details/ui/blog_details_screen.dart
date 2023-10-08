import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/model/blog.dart';

import '../bloc/details_bloc.dart';

class BlogsDetailsScreen extends StatefulWidget {
  const BlogsDetailsScreen({super.key, required this.blog});
  final Blog blog;
  @override
  State<BlogsDetailsScreen> createState() => _BlogsDetailsScreenState();
}

class _BlogsDetailsScreenState extends State<BlogsDetailsScreen> {
  DetailsBloc detailsBloc = DetailsBloc();
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsBloc, DetailsState>(
      bloc: detailsBloc,
      listenWhen: (previous, current) => current is DetailsActionState,
      buildWhen: (previous, current) => current is! DetailsActionState,
      listener: (context, state) {
        if (state is DetailsFavButtonActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item Added to favourite')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border))
            ],
          ),
          backgroundColor: Colors.purpleAccent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                  child: Image.network(
                    widget.blog.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150.0,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            widget.blog.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              detailsBloc.add(DetailsFavButtonClickedEvent(
                                  blog: widget.blog));
                              setState(() {
                                isClicked = true;
                              });
                            },
                            icon: isClicked
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ))
                      ],
                    )),
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'some description',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
