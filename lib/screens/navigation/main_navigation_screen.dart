import 'package:al_muslim/consts/muslim_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';
import '../qibla/qibla_finder.dart';
import '../quran/quran_home.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
 State<StatefulWidget> createState() {
    return _MainNavigationScreenState();
  }
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _bottomNavIndex = 1;

  final List<Widget> _screens = [
    const QuranPage(),
    const HomeScreen(),
    const QiblaScreen(),
  ];

  final iconAssets = [
    Icons.menu_book_outlined,
    Icons.home,
    Icons.explore,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _bottomNavIndex,
              children: _screens,
            ),
          ),
        ],
      ),


      bottomNavigationBar: CurvedNavigationBar(
        index: _bottomNavIndex,
        height: 70.0,
        items: <Widget>[
          Center(child: _buildNavItem(0)),
          Center(child: _buildNavItem(1)),
          Center(child: _buildNavItem(2)),
        ],
        color: MuslimColors.mainColor,
        buttonBackgroundColor: MuslimColors.mainColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),

    );
  }

  Widget _buildNavItem(int index) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        _bottomNavIndex == index ? Colors.white : Colors.white,
        BlendMode.srcIn,
      ),
      child: Icon(
        iconAssets[index] as IconData?,

      ),
    );
  }
}

// Home Screen Widget


// Courses Screen Widget



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
