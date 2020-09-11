import 'package:first_app_balcoder/ui/home/model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_beautiful_popup/main.dart';

class DetailPage extends StatefulWidget {
  DetailPage({this.personModel});
  PersonModel personModel;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _cPersonName = TextEditingController();
  final _cPersonPhone = TextEditingController();
  final personCollection =
      FirebaseFirestore.instance.collection('personCollection');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.personModel.key != null) {
      _cPersonName.text = widget.personModel.name;
      _cPersonPhone.text = widget.personModel.phone;
    } else {
      _cPersonName.text = "";
      _cPersonPhone.text = "";
    }
    print(widget.personModel.key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail_page"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                final popup =
                    BeautifulPopup(context: context, template: TemplateFail);
                popup.show(
                    title: "esta seguro",
                    content:
                        'Esta acción eliminará el registro para siempre, no lograremos encontrar nuevamente esta información esta seguro?',
                    actions: [
                      popup.button(
                        label:'Eliminar',
                        onPressed: () async {
                        widget.personModel.isDeleted = true;
                        widget.personModel.deletedDate = DateTime.now();

                        await personCollection
                                .doc(widget.personModel.key)
                                .update(widget.personModel.toJson())
                                .then((value)  {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            })
                            .catchError((err) => print(err));
                      })
                    ]);
              },
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: new Container(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cPersonName,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      decoration: InputDecoration(
                        labelText: 'name',
                        icon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Obligatory';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _cPersonPhone,
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        icon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Obligatory';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RaisedButton(
                      onPressed: (() {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          widget.personModel.name =
                              _cPersonName.text.toString();
                          widget.personModel.phone =
                              _cPersonPhone.text.toString();

                          widget.personModel.isDeleted = false;
                          widget.personModel.createdDate = DateTime.now();

                          if (widget.personModel.key != null) {
                            personCollection
                                .doc(widget.personModel.key)
                                .update(widget.personModel.toJson())
                                .then((value) {
                              print('melo actualizo');
                              Navigator.of(context).pop();
                            });
                          } else {
                            personCollection
                                .add(widget.personModel.toJson())
                                .then((value) {
                              print('melo grabo');
                              Navigator.of(context).pop();
                            });
                          }
                        }
                      }),
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Text(
                        widget.personModel.key != null
                            ? 'Actualizar'
                            : 'Agregar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  ],
                )),
          )
        ]),
      ),
    );
  }
}
