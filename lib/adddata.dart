import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customTextField.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();


  addData(String title , String desc)async{
    if(title=='' && desc==''){
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter require files"),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }else{
FirebaseFirestore.instance.collection("Arnab").doc(title).set({
  "Title":title,
  "Description":desc,
}).then((value){
  print("Data inserted");
});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Data"),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(

              controller: titleController,
              hintText: 'Enter title',
              suffixIcon: Icons.browse_gallery_rounded,
          ),
          SizedBox(height: 15,),
          CustomTextField(controller: descController, hintText: "Enter Description"),
          SizedBox(height: 15,),
          ElevatedButton(onPressed: (){
            addData(titleController.text.toString(), descController.text.toString());
          }, child: Text("Save Data"))
        ],
      ),
    );
  }
}
