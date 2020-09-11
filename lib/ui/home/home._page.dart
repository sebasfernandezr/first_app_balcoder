import 'package:first_app_balcoder/ui/home/detail_page.dart';
import 'package:first_app_balcoder/ui/home/model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final personCollection =
      FirebaseFirestore.instance.collection('personCollection');

  List<PersonModel> listPerson = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    personCollection.get().then((QuerySnapshot value) {
      value.docs.forEach((element) {
        print(element.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("Home page")),
      body: Center(
        child: StreamBuilder(
            stream: personCollection
            .where("isDeleted", isEqualTo:false)
            .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              listPerson = [];
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Center(child: CircularProgressIndicator());

                  break;

                default:
                  snapshot.data.documents.forEach((element) {
                    listPerson.add(new PersonModel.fromSnapshot(element));
                  });

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listPerson.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DetailPage(
                                              personModel: listPerson[i])));
                            },
                            title: Text(listPerson[i].name),
                            subtitle: Text(listPerson[i].phone != null
                                ? listPerson[i].phone
                                : "no hay"),
                            leading: CircleAvatar(child: Image.network("src")),
                            trailing: Container(
                              width: 60,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Icon(
                                      Icons.receipt,
                                    ),
                                    onTap: () {
                                      print("hola");
                                    },
                                  ),
                                  Spacer(),
                                  Icon(Icons.add_a_photo),
                                ],
                              ),
                            ));
                      });
              }

              // return ListTile(
              //     title: Text(listPerson[i].name),
              //     subtitle: Text(listPerson[i].phone),
              //     leading: CircleAvatar(child: Image.network("src")),
              //     trailing: Container(
              //       width: 60,
              //       child: Row(
              //         children: [
              //           GestureDetector(
              //             child: Icon(
              //               Icons.receipt,
              //             ),
              //             onTap: () {
              //               print("hola");
              //             },
              //           ),
              //           Spacer(),
              //           Icon(Icons.add_a_photo),
              //         ],
              //       ),
              //     ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // PersonModel newPerson = new PersonModel();
          //   newPerson.name = "jose";
          //   newPerson.phone = "123";

          //   setState(() {
          //     listPerson.add(newPerson);
          //   });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailPage(personModel: new PersonModel())));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
