import 'package:flutter/material.dart';

void main() => runApp(const TabBarApp());

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('APIs de imágenes'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.person), text: 'Imagen Random'),
              Tab(icon: Icon(Icons.apple), text: '2da Imagen Random'),
              Tab(icon: Icon(Icons.pets), text: '3era Imagen Random'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            ImageScreen(
                apiUrl: 'https://picsum.photos/seed/billmurray/600/400'),
            ImageScreen(apiUrl: 'https://picsum.photos/600/400'),
            ImageScreen(apiUrl: 'https://picsum.photos/seed/kittens/600/400'),
          ],
        ),
      ),
    );
  }
}

class ImageScreen extends StatefulWidget {
  final String apiUrl;

  const ImageScreen({super.key, required this.apiUrl});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.apiUrl;
  }

  void _changeImage() {
    setState(() {
      // Change the image URL to get a new image from the API
      imageUrl =
          'https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/600/400';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _changeImage,
        onHorizontalDragEnd: (details) {
          _changeImage();
        },
        child: Image.network(imageUrl),
      ),
    );
  }
}
