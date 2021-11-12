import 'package:api_test/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const Inicio(title: 'Flutter Demo Home Page'),
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  //estaba algo de un contador
  TextEditingController apiNameController = TextEditingController();   //TextEditingController se utiliza pa los campos donde se vaya a mostrar la informacion
  TextEditingController descripNameController = TextEditingController();  // va a ser el controlador q maneje el dato de la descripcion
  TextEditingController linkNameController = TextEditingController();
  TextEditingController categNameController = TextEditingController();

  ApiService apiService = ApiService();
  SharedPreferences? sharedPreferences;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Carla API', 
            style: TextStyle(color: Colors.white,
            ),
          ),
       // Aquí tomamos el valor del objeto MyHomePage que fue creado por
        // el método App.build, y utilícelo para establecer el título de nuestra barra de aplicaciones.
      ),
      body: Container(
        color: Colors.white,
        child: ListView(   //pa q se pueda hacer scroll
          padding: EdgeInsets.symmetric(horizontal: 10.0),//padding: distanciamiento entre el margen hacia adentro
          children: [
            Column(
              children: [
                SizedBox(height: 30.0),  // sizedbox es un widget invisible q se utiliza pal distanciamiento de distintos objetos
                TextField(
                  controller: apiNameController,  // controlador para el nombre del api
                  decoration: InputDecoration(    // todo esto es solo por decoracion
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    hintText: "Nombre API",
                    fillColor: Colors.white,
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),  
                    ),
                  ),   
                ),
                SizedBox(height: 30),
                TextField(
                  controller: descripNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    hintText: "Descripcion",
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: linkNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    hintText: "Link",
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: categNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    hintText: "Categoria",
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  width: 200.0,
                  child: ElevatedButton(
                    onPressed: () async{ // asincrono xq el boton traera informacion externa
                      List<Info> data = await apiService.getInfo(); // xq es async, xq necesitamos q espere pa recien pasarselo a data
                      getData(data, apiNameController, descripNameController, linkNameController, categNameController);
                      },
                      child: Text('Obtener info'),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
  //una funcion para actualizar los valores q se muestran en pantalla
  getData(List<Info> data,  //accedemos a la lista, es la q nos devuelve el api
   TextEditingController name, 
   TextEditingController descrip, 
   TextEditingController link, 
   TextEditingController categ)
  {
 name.text = data.first.api.toString();//accedemos al primer(first) elemento, de ese tomamos el campo api y lo convertimos a otro tipo de string
 descrip.text = data.first.description.toString();
 link.text = data.first.link.toString();
 categ.text = data.first.categoria.toString();
  } 
}
