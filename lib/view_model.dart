import 'package:scoped_model/scoped_model.dart';
import 'package:shopify_collection/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter/material.dart';
class ViewModel extends Model{
  List<Collection> collections;
  PageState state = PageState.loading;
  static ViewModel of(BuildContext context) =>
      ScopedModel.of<ViewModel>(context);
  Future<List<Collection>> GetCollections() async {
    String str;
    List<Collection> a = [];
    http.Response response = await http.get('https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6');
    str = response.body;
    dynamic json = JSON.jsonDecode(str)['custom_collections'];
    int count = 0; 
    while(true){
      try{
        a.add(Collection.fromJson(json[count]));
      }catch(e){
        break;
      }
      count++;
    } 
    return a;
  }
  Future<List<Product>> GetProducts(int id) async {
    http.Response response = await http.get('https://shopicruit.myshopify.com/admin/collects.json?collection_id=68424466488&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6');
    List whiteList = JSON.jsonDecode(response.body)['collects'];
    response = await http.get('https://shopicruit.myshopify.com/admin/products.json?ids=2759137027,2759143811&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6');
    List json = JSON.jsonDecode(response.body)['products'];
    List<Product> a = [];
    whiteList.forEach((obj){
      if (obj['collection_id'] == id){
        try{
          a.add(Product.fromJson(json.firstWhere((test) => test['id'] == obj['product_id'])));
        } catch(e){
          //print(obj['product_id']);
        }
      }
    });
    state = PageState.valid;
    return a;
  }
  Future<void> UpdateProducts(int index) async {
    collections[index].products = await GetProducts(collections[index].id);
    notifyListeners();
  }
  Future<void> updateCollections()async{
    state = PageState.loading;
    collections = await GetCollections();
    state = PageState.valid;
    notifyListeners();
  }
}
enum PageState{
  valid, undetermined, loading
}