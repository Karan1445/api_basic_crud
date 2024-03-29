import "dart:convert";

import "package:http/http.dart" as http;
class Apicalls{

  Future<List<dynamic>> getAll() async {
    var res=await http.get(Uri.parse("https://65ded69bff5e305f32a09845.mockapi.io/fakedata"));
    return jsonDecode(res.body);
  }
  Future<String> postData(Map map)async{
    var res= await http.post(Uri.parse("https://65ded69bff5e305f32a09845.mockapi.io/fakedata",),body: map);
    return res.body.toString();
  }
  Future<String> updateData(String id,Map map)async{
    var res=await http.put(Uri.parse("https://65ded69bff5e305f32a09845.mockapi.io/fakedata/$id",),body: map);
    return res.body.toString();
  }
  Future<String> onDelete(String id) async {
    var res=await http.delete(Uri.parse("https://65ded69bff5e305f32a09845.mockapi.io/fakedata/$id",));
    return res.body.toString();
  }
}