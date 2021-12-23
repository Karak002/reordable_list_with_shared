class ItemLista {
  String? titolo;
  int? valore;
  int? posizione;

  ItemLista({this.titolo, this.valore, this.posizione});

  ItemLista.fromJson(Map<String, dynamic> json) {
    titolo = json['titolo'];
    valore = json['valore'];
    posizione = json['posizione'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['titolo'] = titolo;
    data['valore'] = valore;
    data['posizione'] = posizione;
    return data;
  }

  static Map<String, dynamic> toMap(ItemLista itemlista) => {
        'titolo': itemlista.titolo,
        'valore': itemlista.valore,
        'posizione': itemlista.posizione
      };
}
