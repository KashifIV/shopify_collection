import 'package:flutter/material.dart';
import 'package:shopify_collection/data.dart';
import 'package:shopify_collection/details_page.dart';
import 'package:shopify_collection/view_model.dart';
import 'package:scoped_model/scoped_model.dart';
class CollectionCard extends StatelessWidget{
  final int index;
  bool fetched = false;
  CollectionCard(this.index);
  @override
    Widget build(BuildContext context) {
      return ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => Card(
        child: GestureDetector(
          onTap: ()  {       
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(index,)));
          },
          child: Container(
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(model.collections[index].img.src),
              alignment: Alignment.centerRight
            )
          ),
          child: new Column(
            children: <Widget>[
              new SizedBox(height: 20,),
              new Text(
                model.collections[index].title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              new Container(
                width: 300,
                child: Text(
                  model.collections[index].body,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        )
      ));
    }
}