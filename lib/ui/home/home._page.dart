import 'package:first_app_balcoder/ui/home/model/person_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PersonModel> listPerson = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("Home page")),
      body: Center(
         child: ListView.builder(
           scrollDirection: Axis.vertical,
           itemCount: listPerson.length,
           itemBuilder: (context, i){
             return ListTile(
               title: Text(listPerson[i].name),
               subtitle: Text(listPerson[i].phone),
               leading: CircleAvatar(child: Image.network("src")),
               trailing: Container(
                 width: 60,
                 child: Row(
                   children: [
                     GestureDetector(
                       child: Icon(
                         Icons.receipt,
                       ),
                        onTap: (){
                          print("hola");
                        },
                     ),
                     Spacer(),
                     Icon(Icons.add_a_photo),
                   ],
                 ),)
               );
           }
         ),
        ),






      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PersonModel newPerson = new PersonModel();
            newPerson.name = "jose";
            newPerson.phone = "123";

            setState(() {
              listPerson.add(newPerson);
            });
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
