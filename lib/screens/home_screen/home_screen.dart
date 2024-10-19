import 'package:al_muslim/consts/muslim_assets.dart';
import 'package:al_muslim/consts/muslim_colors.dart';
import 'package:al_muslim/screens/home_screen/six_kalma.dart';
import 'package:al_muslim/screens/home_screen/tasbih.dart';
import 'package:al_muslim/screens/names/widgets/girl_names.dart';
import 'package:al_muslim/screens/side_drawer/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../names/boy_names.dart';
import '../names/names.dart';
import '../names/names2.dart';
import '../names/widgets/fav_names.dart';
import 'dua_screen.dart';
import 'hadith_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fajrTime = "";
  String dhuhrTime = "";
  String asrTime = "";
  String maghribTime = "";
  String ishaTime = "";
  PrayerTimes? prayerTimes;
  DateTime? currentTime = DateTime.now();
  Prayer? nextPrayer;

  @override
  void initState() {
    super.initState();
    _checkLocationPermissionAndGetPrayerTimes();
  }

  Future<void> _checkLocationPermissionAndGetPrayerTimes() async {
    var status = await Permission.locationWhenInUse.status;

    if (status.isDenied) {
      if (await Permission.locationWhenInUse.request().isGranted) {
        _getPrayerTimes();
      } else {
        print('Location permission denied');
      }
    } else if (status.isGranted) {
      _getPrayerTimes();
    }
  }

  Future<void> _getPrayerTimes() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final myCoordinates = Coordinates(position.latitude, position.longitude);

      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.hanafi;

      final date = DateComponents.from(DateTime.now());
      prayerTimes = PrayerTimes(myCoordinates, date, params);

      setState(() {
        fajrTime = _formatTime(prayerTimes!.fajr);
        dhuhrTime = _formatTime(prayerTimes!.dhuhr);
        asrTime = _formatTime(prayerTimes!.asr);
        maghribTime = _formatTime(prayerTimes!.maghrib);
        ishaTime = _formatTime(prayerTimes!.isha);

        currentTime = DateTime.now();
        nextPrayer = prayerTimes!.nextPrayer(); // Get the next prayer time
      });
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  bool _isCurrentPrayer(Prayer prayer) {
    return nextPrayer == prayer;
  }

  @override
  Widget build(BuildContext context) {
    HijriCalendar today = HijriCalendar.now();
    String hijriDate =
        "${today.hDay}   ${today.longMonthName}   ${today.hYear} ";

    return Scaffold(
      backgroundColor: MuslimColors.mainColor,
      drawer: const SideDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: MuslimColors.mainColor,
        leading: Builder(
          // Use Builder to get the correct context
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                MuslimAssets.menu,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Al Muslim',
          style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date:',
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    hijriDate,
                    style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Next Prayer Time',
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_isCurrentPrayer(Prayer.fajr))
              _buildPrayerTimeTile(
                'Fajr',
                '$fajrTime AM',
              ),
            if (_isCurrentPrayer(Prayer.dhuhr))
              _buildPrayerTimeTile(
                'Dhuhr',
                '$dhuhrTime PM',
              ),
            if (_isCurrentPrayer(Prayer.asr))
              _buildPrayerTimeTile(
                'Asr',
                '$asrTime PM',
              ),
            if (_isCurrentPrayer(Prayer.maghrib))
              _buildPrayerTimeTile(
                'Maghrib',
                '$maghribTime PM',
              ),
            if (_isCurrentPrayer(Prayer.isha))
              _buildPrayerTimeTile(
                'Isha',
                '$ishaTime PM',
              ),
            if (_isCurrentPrayer(Prayer.none))
              const Text(
                'No Next Namaz Time Yet',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),

            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 350,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const Names(),
                            ),
                          );
                        },
                        child: buildIconGridItem("Allah", MuslimAssets.allah),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const Names2(),
                            ),
                          );
                        },
                        child: buildIconGridItem(
                            "Muhammad", MuslimAssets.muhammad),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const HadithScreen(),
                            ),
                          );
                        },
                        child:
                            buildIconGridItem('Al Hadith', MuslimAssets.hadith),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const FavoriteNames(),
                            ),
                          );
                        },
                        child: buildIconGridItem(
                            'Favorites', MuslimAssets.favIcon),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const TasbihCounterPage(),
                            ),
                          );
                        },
                        child: buildIconGridItem('Tasbih', MuslimAssets.tasbih),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const BoyNames(),
                            ),
                          );
                        },
                        child: buildIconGridItem('Boy Names', MuslimAssets.boy),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const GirlNames(),
                            ),
                          );
                        },
                        child:
                            buildIconGridItem('Girl Names', MuslimAssets.girl),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const DuaScreen(),
                            ),
                          );
                        },
                        child: buildIconGridItem('Dua', MuslimAssets.dua),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const KalmaListPage(),
                            ),
                          );
                        },
                        child: buildIconGridItem('Kalma', MuslimAssets.kalma),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCountdownTimerBlock(String time, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Text(
            time,
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIconGridItem(String label, String icon) {
    return Container(
      decoration: BoxDecoration(
        color: MuslimColors.mainColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(fontSize: 14, color: MuslimColors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeTile(
    String prayerName,
    String prayerTime,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        tileColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              prayerName,
              style: GoogleFonts.lato(
                fontSize: 20,
                color: MuslimColors.mainColor,
              ),
            ),
            Text(
              prayerTime,
              style: GoogleFonts.lato(
                fontSize: 20,
                color: MuslimColors.mainColor,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
