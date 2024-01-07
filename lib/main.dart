import 'package:flutter/material.dart';
import 'package:assignment_1/functions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PageController _pageController;
  final List<String> items = List.generate(3, (index) => "Item $index");

  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController = PageController(
      initialPage: items.length * 1000,
      viewportFraction: 1.0, // Disables swipe
    );
    _pageController.addListener(() {
      setState(() {
        _currentPage = (_pageController.page ?? 0).round() % items.length;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(221, 6, 1, 56),
                Color.fromARGB(255, 8, 0, 27),
              ],
            ),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                height: 250,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://via.placeholder.com/400'), // Image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(items.length, (index) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                width: _currentPage == index
                                    ? 16.0
                                    : 10.0, // Adjusted width of dots
                                height: _currentPage == index
                                    ? 16.0
                                    : 10.0, // Adjusted height of dots
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == index
                                      ? Colors.green
                                      : Colors.white,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Space between PageView and next content
              Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    child: generateHorizontalList(
                      [
                        'https://via.placeholder.com/150', // Image URL
                        'https://via.placeholder.com/150', // Image URL
                        'https://via.placeholder.com/150', // Image URL
                      ],
                      'Trending Breathwork',
                    ),
                  ),
                  SizedBox(height: 10), // Space between lists
                  Container(
                    color: Colors.transparent,
                    child: generateHorizontalList(
                      [
                        'https://via.placeholder.com/150', // Image URL
                        'https://via.placeholder.com/150', // Image URL
                        'https://via.placeholder.com/150', // Image URL
                      ],
                      'Your Breathwork',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          12.0), // Apply rounded corners to image
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.network(
                          'https://via.placeholder.com/600',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 5, 0, 22),
                width: 5.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(235, 33, 36, 54),
            selectedItemColor: Color.fromARGB(255, 28, 149, 33),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
