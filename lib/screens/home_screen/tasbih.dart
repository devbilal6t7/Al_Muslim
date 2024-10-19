import 'package:al_muslim/consts/muslim_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TasbihCounterPage extends StatefulWidget {
  const TasbihCounterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TasbihCounterPageState();
  }
}

class _TasbihCounterPageState extends State<TasbihCounterPage> {
  int _counter = 0;
  String _zikr = "Alhamdulillah"; // The Zikr text

  // Increment the counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    HapticFeedback.lightImpact(); // Provides a light vibration when counting
  }

  // Reset the counter
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  // Handle selection of Zikr
  void _selectZikr() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      backgroundColor: const Color(0xFFF8F4E9), // Use the background color of the app
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Select a Zikr",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFB58E60),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  "SubhanAllah",
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _zikr = "SubhanAllah";
                    _counter = 0;
                  });
                  Navigator.pop(context);
                },
                trailing: Image.asset(
                  MuslimAssets.tasbih,
                  height: 30,
                  width: 30,
                ),
              ),
              ListTile(
                title: Text(
                  "Alhamdulillah",
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _zikr = "Alhamdulillah";
                    _counter = 0;
                  });
                  Navigator.pop(context);
                },
                trailing: Image.asset(
                  MuslimAssets.tasbih,
                  height: 30,
                  width: 30,
                ),
              ),
              ListTile(
                title: Text(
                  "Allahu Akbar",
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _zikr = "Allahu Akbar";
                    _counter = 0;
                  });
                  Navigator.pop(context);
                },
                trailing: Image.asset(
                  MuslimAssets.tasbih,
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text(
          'Tasbih',
          style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: _selectZikr,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select a zikr',
                      style: GoogleFonts.lato(fontSize: 16, color: Colors.grey),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _zikr,
              style: GoogleFonts.scheherazadeNew(
                fontSize: 50,
                color: const Color(0xFFB58E60),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              '$_counter',
              style: GoogleFonts.lato(
                fontSize: 80,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _incrementCounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDC43B),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
              ),
              child: const Icon(
                Icons.add,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetCounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 32),
              ),
              child: const Text(
                'Reset',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
