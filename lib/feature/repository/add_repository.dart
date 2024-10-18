import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/model/userModel.dart';

import '../../core/provide/firebase_provide.dart';
import '../../model/userModel.dart';

final AddRepositoryProvider = Provider(
  (ref) => AddRepository(firestore: ref.watch(firestoreprovider)),
);

class AddRepository {
  final FirebaseFirestore _firestore;
  AddRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  CollectionReference get _items => _firestore.collection("items");

  itemsAdd(UserModel details) {
    _items.add(details.toMap()).then(
          (value) => value.update(details.copyWith(id: value.id).toMap()),
        );
  }

  Stream<List<UserModel>> streamProduct() {
    return _items.where("delete", isEqualTo: false).snapshots().map(
          (event) => event.docs
              .map(
                (e) => UserModel.fromMap(e.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  deleteItems(UserModel detail) {
    _items.doc(detail.id).update({"delete": true});
  }

  updateItems(UserModel userModel) {
    _items.doc(userModel.id).update(userModel.toMap());
  }
}
