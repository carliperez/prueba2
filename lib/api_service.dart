import 'dart:async';
import 'dart:convert'; // xq vamos a hacer uso de las funciones de json
import 'package:http/http.dart' as http;
import 'info.dart';

class ApiService {
  final String url = 'https://api.publicapis.org/random';

  // Funcion Get
  Future<List<Info>> getInfo() async {  //future va a retornar un valor luego de otro proceso, va a esperar para devolver
    var response = await http.get(Uri.parse(url), headers: 
    {
      'Content-Type': 'aplication/json',
      'Accept': 'application/json',
    });

    if(response.statusCode == 200)
    {
      var jsonResponse = jsonDecode(response.body);
      print('EXITO: '+ jsonResponse['entries'][0]['API']); //entries es la lista, 0 el primer elemento de la lista, campo API
      return (jsonResponse['entries'] as List)
      .map((e) => Info.fromJSON(e))
      .toList();}
      //else
      throw Exception('Error al llamar al API');
    }
  }