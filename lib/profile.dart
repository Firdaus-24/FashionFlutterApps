import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './models/movie.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // List<Movie> _movies = [];

  // Future<List<Movie>> _fetchMovies() async {
  //   final response = await http
  //       .get(Uri.parse('https://www.episodate.com/api/most-popular?page=2'));

  //   if (response.statusCode == 200) {
  //     final result = jsonDecode(response.body);
  //     Iterable list = result['tv_shows'];
  //     return list.map((e) => Movie.fromJson(e)).toList();
  //   } else {
  //     throw Exception('failed');
  //   }
  // }

  // void poforMovie() async {
  //   final myMovie = await _fetchMovies();
  //   // setState(() {});
  //   _movies.addAll(myMovie);
  //   // print(_movies[1].title);
  // }

  // @override
  // void initState() {
  //   poforMovie();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1)
              ],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 38),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Icon(AntDesing),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'My Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Fasthand'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: height * 0.4,
                    child: LayoutBuilder(
                      builder: (context, contstraints) {
                        double innerHeight = contstraints.maxHeight;
                        double innerWidth = contstraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: innerHeight * 0.65,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: Column(children: [
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Text(
                                    'Muhamad Pirdaus',
                                    style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Orders',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 21),
                                          ),
                                          Text(
                                            '20',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontSize: 21),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 8),
                                        child: Container(
                                          height: 40,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Pending',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 21),
                                          ),
                                          Text(
                                            '1',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontSize: 21),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ]),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  // width: innerWidth * 0.3,
                                  child: Image.asset(
                                    'image/gambar2.jpeg',
                                    width: innerWidth * 0.35,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'My Orders',
                            style: TextStyle(
                                color: Color.fromRGBO(39, 105, 171, 1),
                                fontSize: 25,
                                fontFamily: 'Roboto'),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          // for (final movie in _movies)
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://static.episodate.com/images/tv-show/thumbnail/56202.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://static.episodate.com/images/tv-show/thumbnail/59001.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
