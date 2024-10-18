import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interview_task/feature/screen/addpage.dart';
import 'package:interview_task/model/userModel.dart';

import '../../core/provide/storage_repository_provide.dart';
import '../../main.dart';
import '../controller/add_controller.dart';

class Create_Page extends ConsumerStatefulWidget {
  const Create_Page({super.key});

  @override
  ConsumerState<Create_Page> createState() => _Create_PageState();
}

var imgurl;

class _Create_PageState extends ConsumerState<Create_Page> {
  File? file;
  pickimage(ImageSource source) async {
    var PickedFile =
        await ImagePicker.platform.getImageFromSource(source: source);
    file = File(PickedFile!.path);
    if (mounted) {
      file = File(PickedFile.path);
    }

    // String imgurl=  await ref.read(storageRepositoryProvider).storeFile(
    //       path: "items/",
    //       id: DateTime.now().toString(),
    //       file: file);

    var A = await FirebaseStorage.instance
        .ref('upload')
        .child(DateTime.now().toString())
        .putFile(file!, SettableMetadata(contentType: 'image/jpg'));
    imgurl = await A.ref.getDownloadURL();
    print(imgurl);
  }

  String? coverImage;

  Additems() async {
    ref.watch(AddControllerProvider).itemsAddController(UserModel(
        image: imgurl!,
        id: "",
        delete: false,
        price: double.parse(pricecontroller.text),
        name: namecontroller.text));
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      file == null
                          ? CircleAvatar(
                              radius: w * 0.2,
                              backgroundColor: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoActionSheet(
                                        actions: [
                                          CupertinoActionSheetAction(
                                              onPressed: () async {
                                                await pickimage(
                                                    ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Photo Gallery",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                          CupertinoActionSheetAction(
                                              onPressed: () {
                                                pickimage(ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Camera",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: w * 0.18,
                                    child: Icon(CupertinoIcons.camera)),
                              ),
                            )
                          : CircleAvatar(
                              radius: w * 0.2,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                // backgroundColor: Colorconst.whiteConst,
                                radius: w * 0.18,
                                backgroundImage: FileImage(file!),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              Container(
                height: h * 0.3,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: h * 0.055,
                      width: w * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(w * 0.03)),
                      child: TextFormField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(w * 0.03)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(w * 0.03)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(w * 0.03)),
                            labelText: "Name",
                            labelStyle: TextStyle(
                                color: Colors.grey, fontSize: w * 0.04)),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.grey,
                      ),
                    ),
                    Container(
                      height: h * 0.055,
                      width: w * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(w * 0.03)),
                      child: TextFormField(
                        controller: pricecontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(w * 0.03)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(w * 0.03)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(w * 0.03)),
                            labelText: "price",
                            labelStyle: TextStyle(
                                color: Colors.grey, fontSize: w * 0.04)),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Additems();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Add_Page(),
                      ));
                },
                child: Container(
                  height: h * 0.06,
                  width: w * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(w * 0.1),
                  ),
                  child: Center(
                      child: Text(
                    "Add",
                    style: TextStyle(
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
