import 'package:uts_yessica_5simia1/models/menu.dart';

class Order {
  final Menu menu;
  int quantity;

  Order({
    required this.menu,
    this.quantity = 1,
  });

  double get totalPrice => menu.price * quantity;
}