import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_124220137/model/api_model.dart';
import 'package:responsi_124220137/services/favorit_provider.dart';
import 'dart:convert';
import 'detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<Amiibo>> fetchAmiibo() async {
    final response = await http.get(Uri.parse('https://www.amiiboapi.com/api/amiibo'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['amiibo'] as List;
      return data.map((item) => Amiibo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Nitendo Amiibo')),
      body: FutureBuilder<List<Amiibo>>(
        future: fetchAmiibo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final amiiboList = snapshot.data!;
            return ListView.builder(
              itemCount: amiiboList.length,
              itemBuilder: (context, index) {
                final amiibo = amiiboList[index];
                final isFavorite = favoriteProvider.favorites.contains(amiibo.name);
                return ListTile(
                  leading: Image.network(amiibo.image, width: 50, height: 50),
                  title: Text(amiibo.name),
                  subtitle: Text(amiibo.gameSeries),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        favoriteProvider.removeFavorite(amiibo.name);
                      } else {
                        favoriteProvider.addFavorite(amiibo.name);
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(amiibo: amiibo),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
