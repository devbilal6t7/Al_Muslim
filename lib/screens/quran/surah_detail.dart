import 'package:al_muslim/consts/muslim_colors.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

class SurahDetailPage extends StatelessWidget {
  final int surahNumber;

  const SurahDetailPage({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "    ${quran.getSurahName(surahNumber)}",
              style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8,),
            Text(
              "(${quran.getSurahNameArabic(surahNumber)})",
              style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: MuslimColors.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        // Customize as needed
      ),
      body: ListView.builder(
        itemCount: quran.getVerseCount(surahNumber),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: MuslimColors.mainColor,
                  width: 2
                )
              ),
              child: ListTile(
                title: Text(
                  quran.getVerse(surahNumber, index + 1),
                  textAlign: TextAlign.right,
                  style: GoogleFonts.amiri(fontSize: 22,height: 2.5),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
