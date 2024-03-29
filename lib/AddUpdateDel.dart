import 'package:api_learn_1/api_calls.dart';
import 'package:flutter/material.dart';

class MoreFetures extends StatefulWidget {
  Map? userList;
  MoreFetures({super.key,this.userList});

  @override
  State<MoreFetures> createState() => _MoreFeturesState();
}

class _MoreFeturesState extends State<MoreFetures> {
  GlobalKey<FormState> _key=GlobalKey();
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController gender=TextEditingController();
  TextEditingController job=TextEditingController();
  bool FlagOfData=true;

  @override
  Widget build(BuildContext context) {
    if(widget.userList!=null){
      FlagOfData=false;
    }
    name.text=widget.userList?["name"]??"";
    email.text=widget.userList?["email"]??"";
    gender.text=widget.userList?["gender"]??"";
    job.text=widget.userList?["job"]??"";
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,automaticallyImplyLeading: false,),
      body: Form(key: _key,
        child: Container(margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              TextFormField(validator: (value) {
                if(value==""){
                  return "enter valuue";
                }
              },controller: name,decoration: InputDecoration(hintText: "Name",border:OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple),borderRadius: BorderRadius.circular(15))),),
              SizedBox(height: 10,),
              TextFormField(validator: (value) {
                if( RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!)){

                }else{
                  return "Enter Valide Email";
                }
              },controller:email,decoration: InputDecoration(hintText: "Email",border:OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple),borderRadius: BorderRadius.circular(15)))),
              SizedBox(height: 10,),
              TextFormField(validator: (value) {
                if(value?.toLowerCase()=="male" || value?.toLowerCase()=="female"){

                }else{
                  return "Enter Valid Genders";
                }
              },controller: gender,decoration: InputDecoration(hintText: "Gender",border:OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple),borderRadius: BorderRadius.circular(15)))),
              SizedBox(height: 10,),
              TextFormField(controller: job,decoration: InputDecoration(hintText: "job",border:OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple),borderRadius: BorderRadius.circular(15)))),

              SizedBox(height: 40,),
              ElevatedButton(onPressed: (){
                if(_key.currentState!.validate()){
                  if(FlagOfData){
                    Apicalls().postData({"name":name.text,"email":email.text,
                      "gender":gender.text,"job":job.text}).then((value) {
                      if(value!=""){
                        Navigator.pop(context);
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    });
                  }else{
                    Apicalls().updateData(widget.userList!["id"], {"name":name.text,"email":email.text,
                      "gender":gender.text,"job":job.text}).then((value){
                       Navigator.pop(context);
                    });
                  }
                }

              }, child: Text(FlagOfData?"add":"update")),

            ],
          ),
        ),
      ),
    );
  }
}
