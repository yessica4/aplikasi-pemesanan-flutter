import 'package:flutter/material.dart';
import 'order.dart';

class OrderService with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order newOrder) {
    final existingIndex = _orders.indexWhere(
      (order) => order.menu.name == newOrder.menu.name,
    );

    if (existingIndex >= 0) {
      _orders[existingIndex].quantity += newOrder.quantity;
    } else {
      _orders.add(newOrder);
    }
    notifyListeners(); // Memberitahu listener tentang perubahan
  }

  void updateOrder(int index, Order updatedOrder) {
    if (index >= 0 && index < _orders.length) {
      _orders[index] = updatedOrder;
      notifyListeners();
    }
  }

  void removeOrder(int index) {
    if (index >= 0 && index < _orders.length) {
      _orders.removeAt(index);
      notifyListeners();
    }
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }

  double get totalPrice {
    return _orders.fold(0, (sum, order) => sum + order.totalPrice);
  }

  int get totalItems {
    return _orders.fold(0, (sum, order) => sum + order.quantity);
  }
}