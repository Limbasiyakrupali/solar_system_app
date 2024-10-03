import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();

    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String position = data['position'];
    final String image = data['image'];
    final String name = data['name'];
    final String velocity = data['velocity'];
    final String distance = data['distance'];
    final String description = data['description'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: GoogleFonts.getFont(
            "Mulish",
            textStyle: TextStyle(fontSize: 25),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                size: 27,
                color: Provider.of<FavoriteProvider>(context).isFavorite(data)
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: () {
                Provider.of<FavoriteProvider>(context, listen: false)
                    .toggleFavorite(data);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                builder: (context, _) {
                  return Transform.rotate(
                    angle: rotationAnimation.value * 2.0 * pi,
                    child: Hero(
                      tag: image, // Ensure the tag matches the one in HomePage
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                animation: rotationAnimation,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              position,
                              style: GoogleFonts.getFont(
                                'Mulish',
                                textStyle: TextStyle(
                                  fontSize: 110,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Velocity ~",
                          style: GoogleFonts.getFont(
                            "Mulish",
                            textStyle: TextStyle(
                              fontSize: 21,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "$velocity km/s",
                          style: GoogleFonts.getFont(
                            "Mulish",
                            textStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Distance ~",
                          style: GoogleFonts.getFont(
                            "Mulish",
                            textStyle: TextStyle(
                              fontSize: 21,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "$distance million km",
                          style: GoogleFonts.getFont(
                            "Mulish",
                            textStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Description ~",
                          style: GoogleFonts.getFont(
                            "Mulish",
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          description,
                          style: GoogleFonts.getFont(
                            "Mulish",
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
