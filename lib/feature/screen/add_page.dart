import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/feature/controller/add_controller.dart';
import 'package:interview_task/feature/screen/edit_page.dart';
import 'package:interview_task/model/userModel.dart';

import '../../main.dart';
import 'create_page.dart';

class Add_Page extends ConsumerStatefulWidget {
  const Add_Page({super.key});

  @override
  ConsumerState<Add_Page> createState() => _Add_PageState();
}

class _Add_PageState extends ConsumerState<Add_Page> {
  deleteProduct(UserModel userModel) {
    ref.watch(AddControllerProvider).deleteItems(userModel);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Create_Page(),
                  ));
            },
            child: Icon(Icons.add,size: w*0.07,),
            backgroundColor: Colors.grey.shade400,
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: ref.watch(Streamcollection).when(
                data: (data) => SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.8,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: h * 0.12,
                                    width: w * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(w * 0.03),
                                      color: Colors.grey.shade400,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          radius: w * 0.09,
                                          backgroundImage:
                                              NetworkImage(data[index].image),
                                          backgroundColor: Colors.blue,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data[index].name,
                                              style: TextStyle(
                                                  fontSize: w * 0.05,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              "₹ ${data[index].price.toString()}",
                                              style:
                                                  TextStyle(fontSize: w * 0.04),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: w * 0.04,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  showCupertinoModalPopup(
                                                    context: context,
                                                    builder: (context) {
                                                      return CupertinoActionSheet(
                                                        title: Text(
                                                            "Confirm Delete"),
                                                        actions: [
                                                          CupertinoActionSheetAction(
                                                              onPressed: () {
                                                                deleteProduct(
                                                                    data[
                                                                        index]);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "Yes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              )),
                                                          CupertinoActionSheetAction(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "No",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ))
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Icon(Icons.delete)),
                                            SizedBox(
                                              width: w * 0.02,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Edit_Page(
                                                          usr: data[index],
                                                        ),
                                                      ));
                                                },
                                                child: Icon(Icons.edit)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: h * 0.05,
                              );
                            },
                            itemCount: data.length),
                      ),
                    ],
                  ),
                ),
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => CircularProgressIndicator(),
              )),
    );
  }
}
