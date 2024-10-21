import 'package:flutter/material.dart';
import 'panier_screen.dart'; // Importez la page du panier ici

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application de Panier',
      theme: ThemeData(
        primarySwatch: Colors.red, // Changez la couleur principale en rouge
      ),
      home: HomeScreen(), // Page d'accueil de l'application
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Text('Bienvenue sur la page d\'accueil'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PanierScreen()),
          );
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.red, // Couleur du bouton du panier
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Positionne le bouton en bas à droite
    );
  }
}
