import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cash_flow/screens/home/screen_home.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenHome()),
            );
          },
          icon: Container(
            decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [Colors.white, Colors.grey]),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'About',
          style: GoogleFonts.acme(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Container(
                  height: 60,
                  width: 60,
                  color: const Color.fromARGB(255, 33, 108, 115),
                  child: Image.asset(
                    'lib/assets/images/image icon.png',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Designed and Developed by \n Abubakar Siddique PA',
            style: GoogleFonts.acme(fontSize: 12.5, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'version 1.0',
            style: GoogleFonts.acme(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
