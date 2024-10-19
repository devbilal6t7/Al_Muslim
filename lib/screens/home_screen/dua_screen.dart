import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../consts/muslim_colors.dart';

class DuaScreen extends StatelessWidget {
  const DuaScreen({super.key});

  Future<List<dynamic>> _loadDuas(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/files/dua.json');
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuslimColors.mainColor,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(
          'Islamic Duas',
          style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
        ),
        backgroundColor: MuslimColors.mainColor,
      ),
      body: FutureBuilder(
        future: _loadDuas(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading duas'),
            );
          } else {
            List<dynamic> duas = snapshot.data ?? [];
            return ListView.builder(
              itemCount: duas.length,
              itemBuilder: (context, index) {
                var dua = duas[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MuslimColors.mainColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dua['title'],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dua['arabic'],
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dua['translation'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
