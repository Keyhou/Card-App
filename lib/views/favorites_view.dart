import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class FavoritesView extends StatelessWidget {
  final List<String> favorites;
  final Function(List<String>) onFavoriteUpdated;

  FavoritesView(this.favorites, this.onFavoriteUpdated);

  void _unfavorite(String card) {
    // Create a copy of the favorites list and remove the card
    List<String> updatedFavorites = List.from(favorites);
    updatedFavorites.remove(card);

    // Notify the parent widget to update the state
    onFavoriteUpdated(updatedFavorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/orange.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: favorites.isEmpty
            ? Center(
                child: Text(
                  "No favorites added yet.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: favorites.length,
itemBuilder: (context, index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Card(
      elevation: 4, // Shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      color: Colors.transparent, // Transparent for gradient
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: 180, // Adjust card width
        height: 250, // Adjust card height
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space content evenly
          children: [
            // Title
            Text(
              favorites[index],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            // Content or placeholder
            Text(
              "This is one of your favorite cards.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            // Subtitle
            Text(
              "🔥 Card App",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Unfavorite button
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => _unfavorite(favorites[index]),
                ),
                // Share button
                IconButton(
                  icon: Icon(Icons.share, color: Colors.white),
                  onPressed: () => Share.share(favorites[index]),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
                ),
              ),
      ),
    );
  }
}