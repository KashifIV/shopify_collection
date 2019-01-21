class Collection{
  String title, handle, body, sortOrder, publishedScope;
  Img img;
  int id;
  List<Product> products;
  Collection({this.id, this.title, this.handle, this.body,this.publishedScope, this.sortOrder,this.img, this.products});
  factory Collection.fromJson(dynamic json){
    //print(json['title']);
    return Collection(
      id: json['id'],
      title: json['title'],
      handle: json['handle'],
      body: json['body_html'],
      img: Img.fromJson(json['image']),
      sortOrder: json['sort_order'],
      publishedScope: json['published_scope'],
    );
  }
}
class Img{
  int width, height;
  String src;
  Img({this.width, this.height, this.src});
  factory Img.fromJson(dynamic json){
    return Img(
      width: json['width'],
      height: json['height'],
      src: json['src'],
    );
  }
}
class Product{
  String name;
  bool isExpanded = false;
  int numInventory;
  List<Variant> variances;
  Product({this.name, this.numInventory, this.variances});
  factory Product.fromJson(Map<String, dynamic> json){
    List variants = json['variants'];
    List<Variant> v = [];
    //variants.forEach((test) => v.add(Variant(test['title'], test['price'])));
    print(v.runtimeType);
    return Product(
      name: json['title'],
      numInventory: variants.fold(0, (value, element) => value + element['inventory_quantity']),
      variances: variants.map((value) => Variant.fromJson(value)).toList()
    );  
  }
}
class Variant{
  final String title;
  final String price;
  final int inventory;
  Variant(this.title, this.price, this.inventory);
  factory Variant.fromJson(dynamic json){
    print(json['title']);
    return Variant(json['title'], json['price'], json['inventory_quantity']);
  }
}