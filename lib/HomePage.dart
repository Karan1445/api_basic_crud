
import 'package:api_learn_1/AddUpdateDel.dart';
import 'package:api_learn_1/api_calls.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> UserList=[];
    return Scaffold(
      floatingActionButton: FloatingActionButton(foregroundColor: Colors.deepPurple,backgroundColor: Colors.deepPurple.shade100,child: const Icon(Icons.add),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MoreFetures(),)).then((value) {
          setState(() {

          });
        });
      }),
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,automaticallyImplyLeading: false,),
      body: FutureBuilder(
        future: Apicalls().getAll(),
        builder: (context, snapshot) {
         if(snapshot.hasData && snapshot.data!=null){
           UserList.clear();
           UserList.addAll(snapshot.data!);
           if(UserList!=null){
              return ListView.builder(itemCount: UserList.length,itemBuilder: (context, index) {
                return Container(margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                  child: ListTile(contentPadding: EdgeInsets.all(5),shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),borderRadius: BorderRadius.circular(15)),
                    title: Text(UserList[index]["email"]),
                    leading:
                        Text(UserList[index]["name"]+" | ",style: TextStyle(color: Colors.deepPurple,fontWeight:  FontWeight.w500,fontSize: 20,wordSpacing: 10),),
                    titleTextStyle: TextStyle(color: Colors.purple,fontSize: 15),
                    trailing: GestureDetector(onLongPress: (){
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(title: Text("Are you sure?"),
                        actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Noo")),
                          TextButton(onPressed: (){
                            Apicalls().onDelete(UserList[index]["id"]).then((value) {
                              setState(() {

                              });
                              Navigator.pop(context);
                            },);

                        }, child: Text("Yess"))
                        ],
                        );
                      },);
                    },onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                                return MoreFetures(userList: UserList[index]);})).then((value) {

                                setState(() {

                                });
                              });
                    }
                    ,child: Icon(Icons.edit)),

                  ),
                );
              },);
           }else{
             return Center(child: CircularProgressIndicator(color: Colors.red,strokeAlign: 0.05,semanticsLabel:"Loading"),);
           }
         }else{
           return Center(child: CircularProgressIndicator(color: Colors.red,strokeAlign: 0.05,semanticsLabel:"Loading"),);
         }
        },
      ),
    );
  }
}
