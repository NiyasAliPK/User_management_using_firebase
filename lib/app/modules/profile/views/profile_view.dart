import 'dart:convert';
import 'dart:ui';
import 'package:firebase/app/modules/edit/views/edit_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final data;

  ProfileView({this.data});

  @override
  Widget build(BuildContext context) {
    String image = data['Image'];
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  NetworkImage('https://wallpaperaccess.com/full/1586538.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: [
              user!.uid == data['id']
                  ? IconButton(
                      onPressed: () {
                        Get.to(() => EditView(
                              data: data,
                            ));
                      },
                      icon: Icon(Icons.edit))
                  : Container()
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Profile'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                image.isEmpty
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'))),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            MemoryImage(Base64Decoder().convert(image)),
                        radius: 70,
                      ),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                width: 1,
                                color: Colors.white.withOpacity(0.1))),
                        child: SizedBox(
                          height: 70,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Name  : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                  Text(data["Name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Job  :  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                  Text(data["job"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Mobile  : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                  Text(data['Mobile'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Email  :  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                  Text(data["Email"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                ],
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
          )),
    );
  }
}
