import 'package:flutter/material.dart';
import 'package:subspace/model/blog.dart';

class BlogItem extends StatelessWidget {
  final Blog blog;
  final void Function(Blog blog) selectedBlog;

  const BlogItem({Key? key, required this.blog, required this.selectedBlog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          selectedBlog(blog);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
              child: Image.network(
                blog.imageUrl
                    .toString(), // Assuming imageUrl is a field in your Blog model
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150.0, // Set the desired height for the image
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                blog.title, // Assuming title is a field in your Blog model
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
