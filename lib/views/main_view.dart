import 'package:flutter/material.dart';
import 'favorites_view.dart';
import 'sliding_card_view.dart';

class MainViewWrapper extends StatefulWidget {
  @override
  _MainViewWrapperState createState() => _MainViewWrapperState();
}

class _MainViewWrapperState extends State<MainViewWrapper> {
  final List<String> favorites = [];

  @override
  Widget build(BuildContext context) {
    return MainView(
      favorites: favorites,
      onFavoriteUpdated: (updatedFavorites) {
        setState(() {
          favorites.clear();
          favorites.addAll(updatedFavorites);
        });
      },
    );
  }
}

class MainView extends StatelessWidget {
  final List<String> favorites;
  final Function(List<String>) onFavoriteUpdated;

  MainView({required this.favorites, required this.onFavoriteUpdated});

final List<String> cardTitles = [
  "Couple Questions",
  "For Soulmates",
  "Better Together",
  "For Long-Distance",
  "Hot Ones",
];

final List<String> cardEmojis = [
  "❤️",
  "💑",
  "👫",
  "📞",
  "🔥",
];

final List<String> cardSubtitles = [
  "Fun for couples",
  "Deep and romantic",
  "Playful and sweet",
  "Stay connected",
  "Spicy and bold",
];

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Card App"),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritesView(favorites, onFavoriteUpdated),
              ),
            );
          },
        ),
      ],
    ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/orange.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: cardTitles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SlidingCardView(
                      cardTitles[index],
                      favorites,
                      onFavoriteUpdated,
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.orange[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cardEmojis[index],
                      style: TextStyle(fontSize: 32),
                    ),
                    SizedBox(height: 8),
                    Text(
                      cardTitles[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      cardSubtitles[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
}