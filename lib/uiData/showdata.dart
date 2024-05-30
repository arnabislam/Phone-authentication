import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Showdata extends StatefulWidget {
  const Showdata({super.key});

  @override
  State<Showdata> createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("show data"),
      centerTitle: true,),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('User').snapshots(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.active){
          if(snapshot.hasData){
                    return ListView.builder(
                        itemCount:snapshot.data?.docs.length ,

                        itemBuilder: (context,index){

                      return ListTile(
                        leading: CircleAvatar(child: Text("${index+1}"),),
                        title: Text(snapshot.data!.docs[index]['name']),
                        subtitle:Text(snapshot.data!.docs[index]['email']),

                      );

                    });
          }else if(snapshot.hasError){
            return Center(child: Text("${snapshot.hasError.toString()}"),);
          }else{
            return Center(child: Text("No Data Found"),);
          }

        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}
