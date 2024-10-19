import 'package:al_muslim/consts/muslim_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../consts/muslim_assets.dart';
import '../../../providers/favorites_provider.dart';

class FavoriteNames extends StatefulWidget {
  const FavoriteNames({super.key});

  @override
  State<FavoriteNames> createState() => _FavoriteNamesState();
}

class _FavoriteNamesState extends State<FavoriteNames> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorite Names',
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        backgroundColor: MuslimColors.mainColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: MuslimColors.mainColor,
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favorites = favoritesProvider.favorites;
          if (favorites.isEmpty) {
            return  const Center(
              child: Text(
                'No Favorite Names Yet',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favoriteNameTitle = favorites[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: MuslimColors.mainColor),
                      ),
                      height: 80,
                      child: Center(
                        child: ListTile(
                          title: Text(
                            favoriteNameTitle,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          trailing: IconButton(
                            icon: SvgPicture.asset(
                              MuslimAssets.fav,
                              color: Colors.red,
                              height: 25,
                              width: 25,
                              fit: BoxFit.scaleDown,
                            ),
                            onPressed: () {
                              favoritesProvider.removeFromFavoritesByTitle(favoriteNameTitle);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
