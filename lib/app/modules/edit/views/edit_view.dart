import 'dart:convert';
import 'dart:ui';

import 'package:firebase/app/modules/authenticate/controllers/authenticate_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  final data;

  EditView({this.data});
  @override
  Widget build(BuildContext context) {
    final EditController controller = Get.put(EditController());
    final AuthenticateController auth = Get.put(AuthenticateController());
    controller.nameController.text = data['Name'];
    controller.numberController.text = data['Mobile'];
    controller.jobController.text = data['job'];

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  NetworkImage('https://wallpaperaccess.com/full/1586538.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Edit your Profile'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
                child: ListView(
              children: [
                GetBuilder<AuthenticateController>(builder: (context) {
                  var image = auth.img == '' ? data['Image'] : auth.img;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      image == ''
                          ? Container(
                              child: Center(
                                child: Text(
                                  "No image",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  MemoryImage(Base64Decoder().convert(image)),
                              radius: 70,
                            ),
                      IconButton(
                          onPressed: () async {
                            auth.pickimage();
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 35,
                          ))
                    ],
                  );
                }),
                Container(
                    margin: EdgeInsets.only(top: 70),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 370,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.white.withOpacity(0.1))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: controller.nameController,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    prefixIcon: Icon(
                                      Icons.face,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: controller.numberController,
                                  decoration: InputDecoration(
                                    hintText: "Mobile No",
                                    prefixIcon: Icon(
                                      Icons.phone_android,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: controller.jobController,
                                  decoration: InputDecoration(
                                    hintText: "Occupation",
                                    prefixIcon: Icon(
                                      Icons.badge,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await controller.updateData(
                                          id: data['id'],
                                          name: controller.nameController.text,
                                          job: controller.jobController.text,
                                          mobile:
                                              controller.numberController.text,
                                          image: auth.img == ''
                                              ? data["Image"]
                                              : auth.img);
                                      auth.img = '';
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ))
              ],
            )),
          )),
    );
  }
}
