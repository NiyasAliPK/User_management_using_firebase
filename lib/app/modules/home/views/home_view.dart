import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/modules/profile/views/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  NetworkImage('https://wallpaperaccess.com/full/1586538.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("${_user!.email}"),
            actions: [
              IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.logout_outlined))
            ],
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print("Error loading the data from fireStore");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final List usersList = [];
                    snapshot.data!.docs.map((documentSnapshot) {
                      Map temp =
                          documentSnapshot.data() as Map<String, dynamic>;
                      usersList.add(temp);
                    }).toList();
                    return ListView.separated(
                      itemCount: usersList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 15,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final data = usersList;
                        return InkWell(
                          onTap: () {
                            Get.to(() => ProfileView(
                                  data: data[index],
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.white.withOpacity(0.1))),
                                child: SizedBox(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            data[index]['Image'] == ""
                                                ? Container(
                                                    child: Text(
                                                      "No image",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 27,
                                                    backgroundImage:
                                                        MemoryImage(
                                                            Base64Decoder()
                                                                .convert(data[
                                                                        index]
                                                                    ['Image'])),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0, top: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              data[index]["Name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          )),
    );
  }
}
