import 'package:flutter/material.dart';
import 'formulaire_commande_screen.dart'; // Assurez-vous d'importer le nouvel écran ici

class PanierScreen extends StatefulWidget {
  @override
  _PanierScreenState createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  List<Map<String, dynamic>> _panierItems = [
    {"nom": "Pizza Margherita", "quantite": 2, "prix": 12.50},
    {"nom": "Burger Classique", "quantite": 1, "prix": 8.99},
    {"nom": "Salade César", "quantite": 1, "prix": 7.50},
  ];

  String? _codePromo;
  double _remise = 0.0;

  void _supprimerArticle(int index) {
    setState(() {
      _panierItems.removeAt(index);
    });
  }

  void _augmenterQuantite(int index) {
    setState(() {
      _panierItems[index]['quantite']++;
    });
  }

  void _diminuerQuantite(int index) {
    setState(() {
      if (_panierItems[index]['quantite'] > 1) {
        _panierItems[index]['quantite']--;
      }
    });
  }

  double _calculerTotal() {
    return _panierItems.fold(0, (sum, item) => sum + (item['prix'] * item['quantite']));
  }

  void _appliquerCodePromo(String code) {
    setState(() {
      double total = _calculerTotal();
      if (code == 'PROMO10') {
        _remise = total * 0.10;
      } else {
        _remise = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = _calculerTotal();
    double totalAvecRemise = total - _remise;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Panier"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _panierItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        _panierItems[index]['nom'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Quantité: ${_panierItems[index]['quantite']}", style: TextStyle(color: Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, color: Colors.red),
                            onPressed: () => _diminuerQuantite(index),
                          ),
                          Text("${_panierItems[index]['quantite']}"),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.green),
                            onPressed: () => _augmenterQuantite(index),
                          ),
                          SizedBox(width: 10),
                          Text("${_panierItems[index]['prix']} TND"),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _supprimerArticle(index),
                          ),
                        ],
                      ),
                      leading: Icon(Icons.fastfood, size: 40, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            _buildTotalRow("Total", total),
            _buildPromoCodeField(),
            _buildTotalRow("Remise", -_remise),
            _buildTotalRow("Total après remise", totalAvecRemise),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormulaireCommandeScreen()),
                );
              },
              child: Text("Passer la commande", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("${amount.toStringAsFixed(2)} TND", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPromoCodeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Code Promo",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _codePromo = value;
              },
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (_codePromo != null && _codePromo!.isNotEmpty) {
                _appliquerCodePromo(_codePromo!);
              }
            },
            child: Text("Appliquer"),
          ),
        ],
      ),
    );
  }
}
