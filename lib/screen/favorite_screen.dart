import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi_124220137/services/favorit_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favorites = favoriteProvider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet!'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text(favorite),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      favoriteProvider.removeFavorite(favorite);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$favorite removed from favorites')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
