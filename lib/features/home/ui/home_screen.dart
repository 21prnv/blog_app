import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/features/favourite/ui/favourite_screen.dart';
import 'package:subspace/features/home/bloc/home_bloc.dart';

import '../../details/ui/blog_details_screen.dart';
import '../../../widget/blog_item.dart';

// Make sure to import the Blog model

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToFavouriteScreen) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavouritrScreen(),
              ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case HomeFetchSuccessState:
            final successState = state as HomeFetchSuccessState;

            return Scaffold(
                backgroundColor: Colors.purpleAccent,
                appBar: AppBar(
                  title: const Text(
                    'Blogs',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.purple,
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeFavouriteButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_border))
                  ],
                ),
                body: ListView.builder(
                  itemCount: successState.blogss.length,
                  itemBuilder: (context, index) {
                    final blog = successState.blogss[index];

                    print('Image URL: ${successState.blogss[0].title}');
                    return BlogItem(
                      blog: blog,
                      selectedBlog: (blog) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlogsDetailsScreen(blog: blog),
                            ));
                      },
                    );
                  },
                ));
          default:
            return const SizedBox();
        }
      },
    );
  }
}
