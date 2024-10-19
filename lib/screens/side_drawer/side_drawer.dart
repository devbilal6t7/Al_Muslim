import 'package:al_muslim/screens/side_drawer/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/muslim_colors.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: MuslimColors.mainColor,
            ),
            child: Center(
              child: Text(
                'Al Muslim',
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
          ),

          ExpansionTile(
            shape: const RoundedRectangleBorder(
              side: BorderSide.none
            ),
            title: const Text('About'),
            leading: const Icon(
              Icons.info,
              color: Colors.black,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  tileColor: MuslimColors.mainColor,
                  title: const Center(
                    child: Text(
                      'App Version: 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined,color: Colors.black,),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=> const PrivacyPolicyScreen())
              );
            },
          ),
        ],
      ),
    );
  }
}
