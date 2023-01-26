import 'package:chat_app/common/utils.dart';
import 'package:chat_app/features/call/controller/call_controller.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository extends ConsumerWidget {
  final FirebaseFirestore firestore;

  const SelectContactRepository({
    Key? key,
    required this.firestore,
  }) : super(key: key);

  void makeCall(WidgetRef ref, BuildContext context, String receiverName,
      String receiverUid, String receiverProfilePic) {
    ref
        .read(callControllerProvider)
        .makeCall(context, receiverName, receiverUid, receiverProfilePic);
  }

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum = selectedContact.phones[0].number.replaceAll(
          ' ',
          '',
        );
        if (userData.phoneNumber.contains(selectedPhoneNum) ||
            selectedPhoneNum.contains(userData.phoneNumber)) {
          isFound = true;
          makeCall(
            ref,
            context,
            userData.name,
            userData.uid,
            userData.profilePic,
          );
        }
      }

      if (!isFound) {
        showSnackBar(
          context: context,
          content: 'This number does not exist on this app.',
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    throw UnimplementedError();
  }
}
