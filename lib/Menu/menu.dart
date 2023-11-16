import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cash_flow/about/about.dart';
import 'package:cash_flow/reset/clear_all.dart';
import 'package:cash_flow/statistics/statistics.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            // curve: Curves.easeOut,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 17, 163, 176),
            ),
            child: Text(
              'Cash Flow',
              style: GoogleFonts.acme(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.auto_graph_sharp,
                color: Colors.black,
              ),
            ),
            title: const Text('Insights'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const Statics()));
            },
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.info_outline,
                color: Colors.pink,
              ),
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.feedback_outlined,
                color: Colors.green,
              ),
            ),
            title: const Text('Feedback'),
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.share,
                color: Colors.blue,
              ),
            ),
            title: const Text('Share'),
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.white, Colors.grey]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.clear,
                color: Colors.red,
              ),
            ),
            title: const Text('Clear all'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      icon: const Icon(Icons.dangerous),
                      title: const Text('Clear all data'),
                      content: const Text(
                        "Are you Sure to Clear all data?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            resetAllData(context);
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Clear",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
          Container(
            height: 50,
            width: 50,
            color: Color.fromARGB(255, 17, 163, 176),
            child: Image.asset(
              'lib/assets/images/image icon.png',
            ),
          )
        ],
      ),
    );
  }
}
