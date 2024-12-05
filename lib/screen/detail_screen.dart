import 'package:flutter/material.dart';
import 'package:responsi_124220137/model/api_model.dart';

class DetailScreen extends StatelessWidget {
  final Amiibo amiibo;

  const DetailScreen({super.key, required this.amiibo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(amiibo.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(amiibo.image),
          const SizedBox(height: 16),
          Text(amiibo.name, style: const TextStyle(fontSize: 24)),
          Text('Game Series: ${amiibo.gameSeries}', style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
