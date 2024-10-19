import 'package:al_muslim/consts/kalma_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../consts/muslim_colors.dart';

class KalmaListPage extends StatelessWidget {
  const KalmaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuslimColors.white,
      appBar: AppBar(
        title: Text(
          '6 Kalmas of Islam',
          style: GoogleFonts.rubik(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.white,
        backgroundColor: MuslimColors.secondaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: Kalma().kalmas.length,
          itemBuilder: (context, index) {
            final kalma = Kalma().kalmas[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: MuslimColors.secondaryColor,
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  kalma['title']!,
                  style: GoogleFonts.rubik(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: MuslimColors.white,
                  ),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: MuslimColors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KalmaDetailPage(kalma: kalma),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


class KalmaDetailPage extends StatelessWidget {
  final Map<String, String> kalma;

  const KalmaDetailPage({super.key, required this.kalma});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kalma['title']!,
          style: GoogleFonts.rubik(fontWeight: FontWeight.w700),
        ),
        backgroundColor: MuslimColors.secondaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Arabic Section
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: MuslimColors.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Arabic : ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      kalma['arabic']!,
                      textAlign: TextAlign.center,
                      style:  GoogleFonts.amiri(
                        fontSize: 25,
                        height: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Transliteration Section
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: MuslimColors.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Transliteration :',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      kalma['transliteration']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Translation Section
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: MuslimColors.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Translation :',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      kalma['translation']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

