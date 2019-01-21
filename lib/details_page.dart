import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopify_collection/view_model.dart';
import 'package:shopify_collection/product_card.dart';
import 'package:shopify_collection/data.dart';

class DetailsPage extends StatelessWidget{
  final int  index;
  DetailsPage(this.index);
  PageState state = PageState.loading;
  LoadContents(ViewModel model){
    switch(this.state){
      case PageState.loading:
        return LoadingPage(model);
      case PageState.undetermined:
        return UndeterminedPage();
      case PageState.valid:
        return _getProducts(model);
    }
  }
  List<Widget> UndeterminedPage(){
    return []..add(SizedBox(height: 40,))
            ..add(Text(
              'Sorry, we could not find your collections.',
              style: TextStyle(
                fontSize: 20
              ),
            ));
  } 
 List<Widget> LoadingPage(ViewModel model) {
    model.UpdateProducts(index).then((n){
      state = PageState.valid;
    });
    return <Widget>[]..add(LinearProgressIndicator()); 
  }
  List<Widget> _getProducts(ViewModel model){
    List<Widget> a = [];
    if (model.collections[index].products == null) {
      return a..add(SizedBox(height: 30,))
      ..add(Text(
        'No Products Available',
        style: TextStyle(
          fontSize: 20,
        ),
        ));
    }
    a.add(ProductCard(index));
    return a;
  }
  @override
    Widget build(BuildContext context) {
      return Scaffold( body: ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => RefreshIndicator( 
          onRefresh: () => model.UpdateProducts(index),
          child: CustomScrollView(    
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  model.collections[index].title,
                  style: TextStyle(
                    fontSize: 25,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 8.0,
                        color: Color.fromARGB(125, 0, 0, 255),
                      ),
                    ]
                  ),
                ),               
                background: Image.network(
                  model.collections[index].img.src,
                  width: double.parse(model.collections[index].img.width.toString()),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                LoadContents(model),
              ),
            )
          ],
        ),
      )));
    }
}