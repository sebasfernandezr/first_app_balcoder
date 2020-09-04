import 'package:cloud_firestore/cloud_firestore.dart';

class PersonModel {
  PersonModel({
    this.key,
    this.name,
    this.phone,
    this.isDeleted,
    this.deletedDate,
    this.createdDate,
  });

  String key;
  String name;
  String phone;
  bool isDeleted;
  Timestamp deletedDate;
  Timestamp createdDate;

  factory PersonModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PersonModel(
      key: snapshot.id,
      name: snapshot.data()["name"],
      phone: snapshot.data()["phone"],
      isDeleted: snapshot.data()["isDeleted"],
      deletedDate: snapshot.data()["deleteDate"],
      createdDate: snapshot.data()["createdDate"],
    );
  }

  toJson() {
    return {
      "key": key,
      "name": name,
      "phone": phone,
      "isDeleted": isDeleted,
      "deleteDate": deletedDate,
      "createDate": createdDate,
    };
  }

  factory PersonModel.fromJson(parsedJson) {
    return PersonModel(
      key: parsedJson.id,
      name: parsedJson.data()["name"],
      phone: parsedJson.data()["phone"],
      isDeleted: parsedJson.data()["isDeleted"],
      deletedDate: parsedJson.data()["deleteDate"],
      createdDate: parsedJson.data()["createdDate"],
    );
  }
}
