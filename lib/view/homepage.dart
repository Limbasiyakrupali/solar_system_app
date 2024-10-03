import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> jsondata;
  loaddata() {
    jsondata = rootBundle.loadString("assets/alldata.json");
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  List<Map<String, dynamic>> favoritePlanets = [
    {
      'image':
          'http://space-facts.com/wp-content/uploads/mercury-transparent.png',
      'name': 'Mercury',
      'position': '1',
    },
    {
      'image':
          'http://space-facts.com/wp-content/uploads/venus-transparent.png',
      'name': 'Venus',
      'position': '2',
    },
    {
      'image':
          'http://space-facts.com/wp-content/uploads/earth-transparent.png',
      'name': 'Earth',
      'position': '3',
    },
    {
      'image': 'http://space-facts.com/wp-content/uploads/mars-transparent.png',
      'name': 'Mars',
      'position': '4',
    },
    {
      'image':
          'http://space-facts.com/wp-content/uploads/jupiter-transparent.png',
      'name': 'Jupiter',
      'position': '5',
    },
    {
      'image':
          'http://space-facts.com/wp-content/uploads/saturn-transparent.png',
      'name': 'Saturn',
      'position': '6',
    },
    {
      'image':
          'http://space-facts.com/wp-content/uploads/uranus-transparent.png',
      'name': 'Uranus',
      'position': '7',
    },
    {
      'image':
          'http://space-facts.com/wp-content/uploads/neptune-transparent.png',
      'name': 'Neptune',
      'position': '8',
    },
    {
      'image': 'http://pngimg.com/uploads/sun/sun_PNG13424.png',
      'name': 'Sun',
      'position': '9',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(color: Colors.black),
                height: 150,
                width: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/564x/3d/91/09/3d910919cf4d41c1114457504dc29201.jpg"),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Change Theme'),
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .ChangeTheme();
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                Navigator.of(context)
                    .pushNamed("favourite_page", arguments: favoritePlanets);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Planetary Explorer",
          style: GoogleFonts.getFont(
            "Mulish",
            textStyle: TextStyle(fontSize: 22),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: jsondata,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              String? data = snapshot.data;
              List allpalnets = (data == null) ? [] : jsonDecode(data);
              return (data == null)
                  ? Center(
                      child: Text("No data found"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("detail_page",
                                arguments: allpalnets[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${allpalnets[index]['image']}"),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    "${allpalnets[index]['name']}",
                                    style: GoogleFonts.getFont(
                                      "Mulish",
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: allpalnets.length,
                    );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
