import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/menu.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  int get totalItems => _orders.fold(0, (sum, order) => sum + order.quantity);

  double get totalPrice => _orders.fold(0, (sum, order) => sum + order.totalPrice);

  void addOrder(Menu menu) {
    final existingIndex = _orders.indexWhere((o) => o.menu.name == menu.name);
    
    if (existingIndex >= 0) {
      _orders[existingIndex].quantity++;
    } else {
      _orders.add(Order(menu: menu));
    }
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _orders[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_orders[index].quantity > 1) {
      _orders[index].quantity--;
    } else {
      _orders.removeAt(index);
    }
    notifyListeners();
  }

  void removeOrder(int index) {
    _orders.removeAt(index);
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}