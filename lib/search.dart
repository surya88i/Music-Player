import 'package:flutter/material.dart';
import 'package:sun/User.dart';

class DataSearch extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
      return <Widget>[
        query.isEmpty?IconButton(icon: Icon(Icons.mic,color: Colors.green), onPressed: (){}):
        IconButton(icon: Icon(Icons.close,color: Colors.green), onPressed: (){
          query='';
        }),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
       progress: transitionAnimation),
       color: Colors.green,
       onPressed: (){
         close(context, null);
       });
    }
  
    @override
    Widget buildResults(BuildContext context) {
      final sugegestionList=query.isEmpty?getUsers():getUsers().where((u) => u.title.toString().startsWith(query)).toList();

    return sugegestionList.isEmpty?Center(child: Text("No Data Found '$query'")):ListView.builder(
      itemCount: sugegestionList.length,
      itemBuilder: (context,index){
        return Card(
          color: Colors.amber,
            child: ListTile(
            leading: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              color: Colors.white,
              child: Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Image.asset(sugegestionList[index].imgPath,width: 20,height: 20,)),
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: sugegestionList[index].title.substring(0,query.length),
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: sugegestionList[index].title.substring(query.length),
                    style: TextStyle(color: Colors.grey),
                  ),
                ]
              ),
              
            ),
            subtitle: Text("Delicious Food"),
            onTap: (){
              showResults(context);
            },
          ),
        );
      });
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    final sugegestionList=query.isEmpty?getUsers():getUsers().where((u) => u.title.toString().startsWith(query)).toList();

    return sugegestionList.isEmpty?Center(child: Text("No Data Found '$query'")):ListView.builder(
      itemCount: sugegestionList.length,
      itemBuilder: (context,index){
        return ListTile(
        leading: CircleAvatar(
          
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(sugegestionList[index].imgPath)),
        title: RichText(
          text: TextSpan(
            text: sugegestionList[index].title.substring(0,query.length),
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: sugegestionList[index].title.substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ]
          ),
          
        ),
        onTap: (){
          showResults(context);
        },
    );
      });
  }

}