import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
class FormulaireCommandeScreen extends StatefulWidget {
  @override
  _FormulaireCommandeScreenState createState() => _FormulaireCommandeScreenState();
}

class _FormulaireCommandeScreenState extends State<FormulaireCommandeScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _nom;
  String? _prenom;
  String? _telephone;
  String? _adresse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulaire de Commande"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nom"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre nom";
                  }
                  return null;
                },
                onChanged: (value) {
                  _nom = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Prénom"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre prénom";
                  }
                  return null;
                },
                onChanged: (value) {
                  _prenom = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Numéro de téléphone"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre numéro de téléphone";
                  }
                  return null;
                },
                onChanged: (value) {
                  _telephone = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Adresse"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre adresse";
                  }
                  return null;
                },
                onChanged: (value) {
                  _adresse = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Traiter les données du formulaire
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Commande passée avec succès!')),
                    );
                    // Retourner à la page d'accueil
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Text("Confirmer la commande"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
