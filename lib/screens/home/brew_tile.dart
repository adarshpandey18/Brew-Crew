import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20,6,20,0),
        child: ListTile(
          leading: CircleAvatar(backgroundColor: Colors.brown[brew.strength],radius: 25,),
          title: Text(brew.name),
          subtitle: Text("Sugar : ${brew.sugar}"),
        ),
      ),
    )  ;
  }
}