import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../consts/hadith_text.dart';
import '../../consts/muslim_colors.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HadithScreenState();
  }
}

class _HadithScreenState extends State<HadithScreen> {
  String _hadithText = 'Fetching Hadith...';



  @override
  void initState() {
    super.initState();
    _fetchHadith();
  }

  Future<void> _fetchHadith() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      HadithText().fetchedHadiths.shuffle();

      String fetchedHadith =
      HadithText().fetchedHadiths[Random().nextInt(HadithText().fetchedHadiths.length)];

      setState(
        () {
          _hadithText = fetchedHadith;
        },
      );
    } catch (e) {
      setState(
        () {
          _hadithText = 'Failed to load Hadith';
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hadith of the Day',
          style: GoogleFonts.rubik(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: MuslimColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _hadithText,
            style: TextStyle(
              fontSize: 18,
              color: MuslimColors.mainColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
