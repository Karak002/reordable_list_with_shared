import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lista_riordinabile/main.dart';

class FormModifica extends StatefulWidget {
  final int index;
  const FormModifica({Key? key, required this.index}) : super(key: key);

  @override
  _FormModificaState createState() => _FormModificaState();
}

class _FormModificaState extends State<FormModifica> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerTitolo = TextEditingController();
    final TextEditingController _controllerValore = TextEditingController();
    const snackBarErroreRange =
        SnackBar(content: Text('il range deve essere compreso tra 0 e 10'));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Form modifica'),
        leading: InkWell(
            onTap: () {
              if (_controllerTitolo.text.isNotEmpty) {
                risultato[widget.index].titolo = _controllerTitolo.text;
              }
              if (_controllerValore.text.isNotEmpty &&
                  int.parse(_controllerValore.text) >= 0 &&
                  int.parse(_controllerValore.text) <= 10) {
                risultato[widget.index].valore =
                    int.parse(_controllerValore.text);
              } else {
                if (_controllerValore.text.isNotEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBarErroreRange);
                }
              }

              preferences?.setString("json", json.encode(risultato));
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
                'Titolo attuale: ${risultato[widget.index].titolo.toString()}'),
            const SizedBox(height: 10),
            Text(
                'Valore attuale: ${risultato[widget.index].valore.toString()}'),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    child: TextFormField(
                      controller: _controllerTitolo,
                      decoration:
                          const InputDecoration(label: Text('Nuovo titolo')),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerValore,
                      decoration: const InputDecoration(
                        label: Text('Nuovo valore'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
