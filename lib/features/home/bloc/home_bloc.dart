import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:subspace/model/blog.dart';
import 'package:http/http.dart' as http;

import '../database/database_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late BlogDatabase blogDatabase;

  HomeBloc() : super(HomeInitial()) {
    blogDatabase = BlogDatabase();

    on<HomeBlogDetailsNavigateEvent>(homeBlogDetailsNavigateEvent);
    on<HomeFavouriteButtonNavigateEvent>(homeFavouriteButtonNavigateEvent);
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
  }

  FutureOr<void> homeFavouriteButtonNavigateEvent(
      HomeFavouriteButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFavouriteScreen());
  }

  FutureOr<void> homeBlogDetailsNavigateEvent(
      HomeBlogDetailsNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToDetailsScreen());
  }

  Future<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    var connectivityResult = await Connectivity().checkConnectivity();
    print(connectivityResult);
    bool isOnline = connectivityResult != ConnectivityResult.none;
    Future<List<Blog>> fetchBlogsFromNetwork() async {
      print('Fetching blogs from network...');

      final response = await http.get(
        Uri.parse('https://intent-kit-16.hasura.app/api/rest/blogs'),
        headers: {
          'x-hasura-admin-secret':
              '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['blogs'];
        // print(data);

        return data.map((item) => Blog.fromJson(item)).take(20).toList();
      } else {
        throw Exception('Failed to load data');
      }
    }

    try {
      List<Blog> blogs;
      if (isOnline) {
        blogs = await fetchBlogsFromNetwork();
        print('fetched databse $blogs');

        // // Store the blogs in the database
        // for (final blog in blogs) {
        //   print('hi ${blog.imageUrl}');
        //   await blogDatabase.open();

        //   await blogDatabase.insertBlog(blog);
        // }

        // Emit the loaded blogs state
        emit(HomeFetchSuccessState(blogss: blogs));
      }

      //   if (isOnline) {
      //     // Fetch blogs from the network

      //   // } else {
      //   //   // Get the blogs from the local database
      //   //   blogs = await blogDatabase.getBlogs();
      //   //   print('local databse $blogs');

      //   //   // Emit the loaded blogs state
      //   //   emit(HomeFetchSuccessState(blogss: blogs));
      //   // }

      //   print('net databse $blogs');
    } catch (error) {
      // Handle error, e.g., show an error state
      emit(HomeErrorState(err: error.toString()));
    }
  }
}
