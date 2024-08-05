import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InFoPage extends StatelessWidget {
  const InFoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
                curve: Curves.bounceOut,
                tween: Tween<double>(begin: 0, end: 400),
                duration: Duration(seconds: 2),
                builder: (context, double val, _) {
                  return Container(
                    alignment: Alignment.center,
                    height: val,
                    width: val,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/solarsyatem.gif"))),
                  );
                }),
            const SizedBox(
              height: 150,
            ),
            Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.6),
                    Colors.purple.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(1, 1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool("introscreenvisit", true);

                      Navigator.of(context).pushReplacementNamed("/");
                    },
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.getFont(
                        "Mulish",
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
