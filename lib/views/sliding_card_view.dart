import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SlidingCardView extends StatefulWidget {
  final String category;
  final List<String> favorites;
  final Function(List<String>) onFavoriteUpdated;

  SlidingCardView(this.category, this.favorites, this.onFavoriteUpdated);

  @override
  _SlidingCardViewState createState() => _SlidingCardViewState();
}

class _SlidingCardViewState extends State<SlidingCardView> {
  List<String> cardItems = [
    "Card 1",
    "Card 2",
    "Card 3",
    "Card 4",
    "Card 5",
  ];

  void _toggleFavorite(String card) {
    final action = widget.favorites.contains(card) ? 'removed from' : 'added to';

    List<String> updatedFavorites = List.from(widget.favorites);

    setState(() {
      if (widget.favorites.contains(card)) {
        updatedFavorites.remove(card);
      } else {
        updatedFavorites.add(card);
      }
    });

    widget.onFavoriteUpdated(updatedFavorites);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$card was $action favorites')),
    );
  }

  void _shareContent(String content) {
    Share.share(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Center( // Center the PageView vertically
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 350, // Limit the height to your desired value
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.8), // Center cards and add padding
              itemCount: cardItems.length,
              itemBuilder: (context, index) {
                bool isFavorite = widget.favorites.contains(cardItems[index]);

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
                            cardItems[index],
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
                              // Heart button
                              IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.white,
                                ),
                                onPressed: () => _toggleFavorite(cardItems[index]),
                              ),
                              // Share button
                              IconButton(
                                icon: Icon(Icons.share, color: Colors.white),
                                onPressed: () => _shareContent(cardItems[index]),
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