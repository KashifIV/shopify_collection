import 'package:flutter/material.dart';
import 'package:shopify_collection/collection_card.dart';
import 'package:shopify_collection/view_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopify_collection/data.dart';

class HomePage extends StatelessWidget{
  PageState state = PageState.loading;
  List<Widget> LoadContents(ViewModel model){
    switch(model.state){
      case PageState.loading:
        return LoadingPage(model);
      case PageState.undetermined:
        return UndeterminedPage();
      case PageState.valid:
        return GetListView(model);
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
  List<Widget> LoadingPage(ViewModel model){
    model.updateCollections();
    return []..add(LinearProgressIndicator());
  }
  List<Widget> GetListView(ViewModel model){
    List<Widget> a = [];
    if (model.collections == null) {
      return a..add(Center(child: new Text('No Collections at the Moment.'),));
    }
    for (int i = 0; i < model.collections.length; i++){
      a.add(CollectionCard(i));
    }
    return a;
  }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ScopedModelDescendant<ViewModel>(
          builder: (context, child, model) => RefreshIndicator(
            onRefresh: () => model.updateCollections(),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.green[900],
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'Custom Collections',
                      style: TextStyle(
                        fontSize: 35,
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
                    background: Container(                    
                      child:Column(
                        children: <Widget>[
                          SizedBox(height: 40,),
                          Image.asset(                     
                            'assets/shopifyLogo.png', 
                            height: 140,
                          ),
                          SizedBox(height: 20,)
                        ],
                      )
                    )),
                  ),
                  SliverList(delegate: SliverChildListDelegate(
                    LoadContents(model)
                ),)
              ]
            ),                
          ) ,
        ),
      );
    }
}