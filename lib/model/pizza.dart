import 'dart:ffi';

class Pizza {
  int? id;
  String? pizzaName;
  String? description;
  double? price;
  String? imageUrl;

  Pizza.fromJson(Map<String, dynamic> item) {
    id = item['id'];
    pizzaName = item['pizzaName'];
    description = item['description'];
    price = item['price'];
    imageUrl = item['imageUrl'];
  }

  toJson() {
    Map<String, dynamic> pizzas = {};
    pizzas['id'] = id;
    pizzas['pizzaName'] = pizzaName;
    pizzas['description'] = description;
    pizzas['price'] = price;
    pizzas['imageUrl'] = imageUrl;

    return pizzas;
  }

  Pizza({this.id = 0, this.pizzaName = '', this.description = '', this.price = 0.0, this.imageUrl = ''});
}