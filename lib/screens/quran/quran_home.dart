import 'package:al_muslim/screens/quran/surah_detail.dart';
import 'package:al_muslim/screens/side_drawer/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

import '../../consts/muslim_assets.dart';
import '../../consts/muslim_colors.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuslimColors.mainColor,
      drawer: const SideDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: MuslimColors.mainColor,
        leading: Builder(  // Use Builder to get the correct context
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                MuslimAssets.menu,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();  // Correct context for opening the drawer
              },
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Al-Quran',
          style: GoogleFonts.rubik(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Asslam-O-Alikum',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Read And Learn Quran',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 170,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                MuslimAssets.quran,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8),
          //   child: Center(
          //     child: Text(
          //       "<------  Quranic Surah's  ------>",
          //       style: GoogleFonts.rubik(
          //         color: Colors.white,
          //         fontSize: 20,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: 114,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          leading: Text(
                            '${index + 1}',
                            style: GoogleFonts.amiri(
                              color: MuslimColors.mainColor,
                              fontSize: 18,
                            ),
                          ),
                          title: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  quran.getSurahName(index + 1),
                                  style: GoogleFonts.amiri(
                                    color: MuslimColors.mainColor,
                                    fontSize: 21,
                                  ),
                                ),
                                Text(
                                  quran.getSurahNameArabic(index + 1),
                                  style: GoogleFonts.amiri(
                                    color: MuslimColors.mainColor,
                                    fontSize: 21,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SurahDetailPage(surahNumber: index + 1),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
