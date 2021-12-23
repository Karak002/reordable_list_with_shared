import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lista_riordinabile/main.dart';
import 'package:lista_riordinabile/model/item_models.dart';

class FormAggiungi extends StatefulWidget {
  const FormAggiungi({Key? key}) : super(key: key);

  @override
  _FormAggiungiState createState() => _FormAggiungiState();
}

class _FormAggiungiState extends State<FormAggiungi> {
  TextEditingController titolo = TextEditingController();
  TextEditingController valore = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const snackBarErroreRange =
        SnackBar(content: Text('il range deve essere compreso tra 0 e 10'));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi un elemento'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: titolo,
            decoration: const InputDecoration(labelText: 'Titolo'),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: valore,
            decoration: const InputDecoration(labelText: 'valore'),
          ),
          RaisedButton(onPressed: () {
            if (int.parse(valore.text) <= 10 && int.parse(valore.text) >= 0) {
              preferences?.setString("json", json.encode(risultato));
              if (risultato.isEmpty) {
                risultato.add(ItemLista(
                    posizione: 0,
                    titolo: titolo.text,
                    valore: int.parse(valore.text)));
              } else {
                risultato.add(ItemLista(
                    posizione: risultato.first.posizione! + 1,
                    titolo: titolo.text,
                    valore: int.parse(valore.text)));
              }
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(snackBarErroreRange);
            }
          })
        ],
      ),
    );
  }
}
