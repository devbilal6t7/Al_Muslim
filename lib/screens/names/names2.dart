import 'package:al_muslim/consts/muslim_assets.dart';
import 'package:al_muslim/consts/muslim_colors.dart';
import 'package:al_muslim/screens/names/widgets/names_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../providers/names_provider.dart';
import '../../providers/favorites_provider.dart';

class Names2 extends StatefulWidget {
  const Names2({super.key});

  @override
  State<Names2> createState() => _Names2State();
}

class _Names2State extends State<Names2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NameProvider>(context, listen: false).fetchNames('Muhammad');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuslimColors.mainColor,
      body: SafeArea(
        child: Container(
          color: MuslimColors.mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                MuslimAssets.name2,
                color: Colors.white,
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<NameProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MuslimColors.mainColor,
                          ),
                        );
                      } else if (provider.names.isEmpty) {
                        return const Center(child: Text('No names found'));
                      } else {
                        return GridView.builder(
                          itemCount: provider.names.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // You can adjust this to 2 or 3
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.1, // Adjust height/width ratio
                          ),
                          itemBuilder: (context, index) {
                            final name = provider.names[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_)=>  NamesDetail(name: name)),);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 5)
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: MuslimColors.mainColor,
                                  ),
                                ),

                                child: Column(

                                  children: [
                                    // Index and Favorite Row
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${index + 1}', // Index starts from 1
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          Consumer<FavoritesProvider>(
                                            builder: (context, favoritesProvider, child) {
                                              final isFavorite = favoritesProvider.isFavorite(name);
                                              return IconButton(
                                                icon: SvgPicture.asset(
                                                  MuslimAssets.fav,
                                                  color: isFavorite ? Colors.red : Colors.grey.shade600,
                                                  height: 25,
                                                  width: 25,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                onPressed: () {
                                                  if (isFavorite) {
                                                    favoritesProvider.removeFromFavorites(name);
                                                  } else {
                                                    favoritesProvider.addToFavorites(name);
                                                  }
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            name.nameTitle,
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: MuslimColors.mainColor
                                                  .withOpacity(0.82),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
