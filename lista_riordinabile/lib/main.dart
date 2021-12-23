import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_riordinabile/model/item_models.dart';
import 'package:lista_riordinabile/widget/form_aggiungi.dart';
import 'package:lista_riordinabile/widget/form_modifica.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Lista riordinabile';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

List<ItemLista> risultato = [];
SharedPreferences? preferences;

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

List oggetti = [
  ItemLista(titolo: 'prova', valore: 10, posizione: 0),
  ItemLista(titolo: 'prova2', posizione: 1, valore: 2)
];

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String jsonList = jsonEncode(oggetti);
  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {
        List decodedJson;
        jsonList = preferences?.getString("json") as String;
        print(json.decode(jsonList));
        decodedJson = json.decode(jsonList) as List;
        decodedJson.forEach((element) {
          setState(() {
            risultato.add(ItemLista(
                posizione: element['posizione'],
                titolo: element['titolo'],
                valore: element['valore']));
          });
        });
      });
    });
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  decodeJson() {}

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    refresh() {
      setState(() {});
    }

    return Column(
      children: [
        Expanded(
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            children: <Widget>[
              for (int index = 0; index < risultato.length; index++)
                InkWell(
                  key: UniqueKey(),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => FormModifica(
                                  index: index,
                                )))
                        .then((value) => refresh());
                  },
                  child: ListTile(
                    key: Key('$index'),
                    tileColor: risultato[index].posizione!.isOdd
                        ? oddItemColor
                        : evenItemColor,
                    title: Text(
                        'Titolo: ${risultato[index].titolo}\n Valore: ${risultato[index].valore}'),
                  ),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = risultato.removeAt(oldIndex);
                risultato.insert(newIndex, item);
                preferences?.setString("json", json.encode(risultato));
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 270, bottom: 10),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => const FormAggiungi()))
                  .then((value) => refresh());
            },
            onLongPress: () {
              setState(() {
                preferences?.clear();
                risultato.clear();
              });
            },
            child: const FloatingActionButton(
                child: Icon(Icons.add), onPressed: null),
          ),
        )
      ],
    );
  }
}
