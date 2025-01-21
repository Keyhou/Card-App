import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class FavoritesView extends StatefulWidget {
  final List<String> favorites;
  final Function(List<String>) onFavoriteUpdated;

  FavoritesView(this.favorites, this.onFavoriteUpdated);

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  void _unfavorite(String card) {
    setState(() {
      widget.favorites.remove(card); // Remove the tapped card only
    });
    widget.onFavoriteUpdated(List.from(widget.favorites)); // Notify the parent of the updated list
  }

  void _shareContent(String content) {
    Share.share(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: widget.favorites.isEmpty
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/orange.png'), // Background image
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  "No favorites added yet.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Center( // Center the PageView vertically in Favorites View
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 350, // Limit the height to your desired value
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8), // Center cards and add padding
                    itemCount: widget.favorites.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            width: 300, // Original width
                            height: 250, // Original height (smaller than before)
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space content evenly
                              children: [
                                // Title
                                Text(
                                  widget.favorites[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                // Content
                                Text(
                                  "What photo of us means the most to you?",
                                  style: TextStyle(
                                    fontSize: 16,
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
                                      onPressed: () => _unfavorite(widget.favorites[index]),
                                    ),
                                    // Share button
                                    IconButton(
                                      icon: Icon(Icons.share, color: Colors.white),
                                      onPressed: () => _shareContent(widget.favorites[index]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}