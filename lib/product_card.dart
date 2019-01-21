import 'package:flutter/material.dart';
import 'package:shopify_collection/data.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopify_collection/view_model.dart';
class ProductCard extends StatefulWidget{
  final int colIndex;
  ProductCard(this.colIndex);
  _ProductExpanded createState() => _ProductExpanded();
}
class _ProductExpanded extends State<ProductCard>{
  List<Widget> CreateVariants(List<Variant> variants){
    List<Widget> a = [];

    variants.forEach((item){
      a.add(Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget> [
            Text('Stock: ' + item.inventory.toString()),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(r"$" + item.price)
            ]
        ),
      ));
    });
    return a;
  }
  @override
    Widget build(BuildContext context) {
      return ScopedModelDescendant<ViewModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => new Card(
        child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded){
                    setState(() {
                      model.collections[widget.colIndex].products[index].isExpanded = !model.collections[widget.colIndex].products[index].isExpanded;    
                    });
                  },
                  children: model.collections[widget.colIndex].products.map((item){
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) => ListTile(
                        title: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),
                      isExpanded: item.isExpanded,
                      body: Container(
                          child:SizedBox(
                            height: 200,
                            child:GridView.count(
                              crossAxisCount: 3,
                              children: CreateVariants(item.variances))
                      )
                      /*
                      Expanded(
                        child:
                        SizedBox(
                          height: 200,
                          child:ListView(children: CreateVariants(item.variances)),
                        )),
                        */
                    ));
                  }).toList(),
                )        
            )
        );
    }
}