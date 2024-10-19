import 'package:al_muslim/screens/names/widgets/boys_and_girls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../consts/muslim_assets.dart';
import '../../../consts/muslim_colors.dart';
import '../../../providers/favorites_provider.dart';
import '../../../providers/names_provider.dart';

class GirlNames extends StatefulWidget {
  const GirlNames({super.key});

  @override
  State<GirlNames> createState() => _GirlNamesState();
}

class _GirlNamesState extends State<GirlNames> {
  bool _isSearching = false;
  bool _isAlphabetical = false;
  final TextEditingController _searchController = TextEditingController();
  String _selectedAlphabet = 'A';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NameProvider>(context, listen: false).fetchNames('Girls');
    });
  }



  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(color: MuslimColors.mainColor, width: 2)),
            child: Center(
              child: Text(
                'Filter By',
                style: TextStyle(color: MuslimColors.mainColor, fontSize: 25),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(

                title: Text(
                  'Search',
                  style: TextStyle(color: MuslimColors.mainColor, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _isSearching = true;
                    _isAlphabetical = false;
                  });
                },
              ),
              ListTile(
                title: Text(
                  'Alphabetically',
                  style: TextStyle(color: MuslimColors.mainColor, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _isAlphabetical = true;
                    _isSearching = false;
                  });
                },
              ),

            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      cursorColor: MuslimColors.mainColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Search',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onChanged: (query) {
        Provider.of<NameProvider>(context, listen: false).searchNames(query);
      },
    );
  }

  Widget _buildAlphabetDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: MuslimColors.mainColor,
          width: 2,
        ),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedAlphabet,
            items: List.generate(26, (index) {
              String letter = String.fromCharCode(65 + index); // A-Z
              return DropdownMenuItem<String>(
                value: letter,
                child: Text(letter, style: TextStyle(color: MuslimColors.mainColor)),
              );
            }),
            onChanged: (newValue) {
              setState(() {
                _selectedAlphabet = newValue!;
                Provider.of<NameProvider>(context, listen: false)
                    .filterNamesByAlphabet(newValue);
              });
            },
            iconEnabledColor: MuslimColors.mainColor, // Change icon color
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuslimColors.mainColor,
      appBar: AppBar(
        foregroundColor: MuslimColors.white,
        backgroundColor: const Color(0xFF024328),
        title: _isSearching
            ? _buildSearchBar()
            : _isAlphabetical
            ? _buildAlphabetDropdown()
            : const Text(''),

        actions: [
          InkWell(
            onTap: _showFilterDialog,
            child: Padding(
              padding: const EdgeInsets.only(right: 12,left: 12),
              child: Image.asset(
                MuslimAssets.filter,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: MuslimColors.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              MuslimAssets.girlsImage,
              // color: Colors.white,
              height: 200,
              width: 200,
              // fit: BoxFit.cover,
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
                          crossAxisCount: 1, // You can adjust this to 2 or 3
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.5, // Adjust height/width ratio
                        ),
                        itemBuilder: (context, index) {
                          final name = provider.names[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_)=>  BoysGirlsDetail(name: name)),);
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
    );
  }
}
