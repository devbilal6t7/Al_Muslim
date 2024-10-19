import 'dart:async';
import 'dart:math';
import 'package:al_muslim/consts/muslim_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_compass/flutter_compass.dart';
import '../../consts/muslim_colors.dart';
import '../side_drawer/side_drawer.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QiblaScreenState();
  }
}

class _QiblaScreenState extends State<QiblaScreen> {
  double? qiblaDirection;
  double? compassHeading;

  @override
  void initState() {
    super.initState();
    _calculateQiblaDirection();
    // _getCompassHeading();
  }

  // Calculate Qibla Direction based on the user's location
  Future<void> _calculateQiblaDirection() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get user's location
    double userLat = position.latitude;
    double userLon = position.longitude;

    // Kaaba location (Makkah)
    double kaabaLat = 21.4225;
    double kaabaLon = 39.8262;

    // Calculate Qibla Direction
    double deltaLon = (kaabaLon - userLon).toRad();
    double userLatRad = userLat.toRad();
    double kaabaLatRad = kaabaLat.toRad();

    double x = cos(kaabaLatRad) * sin(deltaLon);
    double y = cos(userLatRad) * sin(kaabaLatRad) -
        sin(userLatRad) * cos(kaabaLatRad) * cos(deltaLon);

    double qiblaDirectionInRadians = atan2(x, y);
    double qiblaDirectionInDegrees =
        (qiblaDirectionInRadians.toDegrees() + 360) % 360;

    setState(() {
      qiblaDirection = qiblaDirectionInDegrees;
    });
  }

  // Get real-time compass heading from flutter_compass
  // void _getCompassHeading() {
  //   FlutterCompass.events?.listen((event) {
  //     setState(() {
  //       compassHeading = event.heading;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuslimColors.mainColor,
      drawer: const SideDrawer(),
      appBar: AppBar(
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
        foregroundColor: Colors.white,
        backgroundColor: MuslimColors.mainColor,
        centerTitle: true,
        title: Text(
          'Qiblah Finder',
          style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: qiblaDirection == null || compassHeading == null
            ? Text(
            'Location Permission Denied'
            '\nPlease Allow Location to Find Qibla',
             textAlign: TextAlign.center,
             style: GoogleFonts.rubik(fontWeight: FontWeight.w700,color: Colors.white))
        // const CircularProgressIndicator(
        //   color: Colors.white,
        // )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Qibla Direction: ${qiblaDirection!.toStringAsFixed(2)}°',
              style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Transform.rotate(
              // Rotate the image based on the difference between Qibla and compass heading
              angle: ((qiblaDirection! - compassHeading!) * pi / 180),
              child: Image.asset(
                MuslimAssets.qibla, // Use your asset path here
                height: 300,
                width: 300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Find Out',
              style: GoogleFonts.rubik(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'The Qiblah Direction',
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

extension DoubleExtensions on double {
  double toRad() => this * pi / 180;
  double toDegrees() => this * 180 / pi;
}
