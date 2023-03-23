import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './models/movie.dart';
import 'package:http/http.dart' as http;

class Mymovie extends StatefulWidget {
  const Mymovie({Key? key}) : super(key: key);

  @override
  State<Mymovie> createState() => _MymovieState();
}

class _MymovieState extends State<Mymovie> {
  List<Movie> _movies = [];

  Future<List<Movie>> _fetchMovies() async {
    final response = await http
        .get(Uri.parse('https://www.episodate.com/api/most-popular?page=3'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result['tv_shows'];
      return list.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('failed');
    }
  }

  void poforMovie() async {
    final myMovie = await _fetchMovies();
    // setState(() {});
    _movies.addAll(myMovie);
    // print(_movies[1].title);
  }

  @override
  void initState() {
    poforMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: _CustomClipper(),
            child: Container(
              padding: EdgeInsets.only(top: 50),
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF000B49),
              child: Text(
                'Firdaus',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 130.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineSmall,
                    children: [
                      TextSpan(
                          text: 'Favorite',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold)),
                      const TextSpan(text: 'Movies'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                for (final movie in _movies)
                  MovieListItem(
                      imageUrl: '${movie.image}',
                      title: '${movie.title}',
                      country: '${movie.country}')
              ],
            ),
          ),
        ));
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double widht = size.width;

    var path = Path();

    path.lineTo(0, height - 50);
    path.quadraticBezierTo(widht / 2, height, widht, height - 50);
    path.lineTo(widht, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MovieListItem extends StatelessWidget {
  final dynamic imageUrl;
  final dynamic title;
  final dynamic country;

  final GlobalKey backgroundImageKey = GlobalKey();

  MovieListItem(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: [
              Flow(
                delegate: _ParallaxFlowDelegate(
                    scrollable: Scrollable.of(context),
                    listItemContext: context,
                    backgroundImageKey: backgroundImageKey),
                children: [
                  Image.network(
                    imageUrl,
                    width: double.infinity,
                    key: backgroundImageKey,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Positioned.fill(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.6, 0.95]))),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      country,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  _ParallaxFlowDelegate(
      {required this.scrollable,
      required this.listItemContext,
      required this.backgroundImageKey})
      : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstrainsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;

    final listItemSize = context.size;
    final childReact =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childReact.top)).transform,
    );
  }

  @override
  bool shouldRepaint(covariant _ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
