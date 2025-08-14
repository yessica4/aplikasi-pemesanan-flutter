import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_yessica_5simia1/provider/order_providers.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Anda'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (context, index) {
                    final order = orderProvider.orders[index];
                    return Dismissible(
                      key: Key(order.menu.name),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        orderProvider.removeOrder(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pesanan dihapus')),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    order.menu.imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.menu.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Rp ${order.menu.price.toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          orderProvider.decreaseQuantity(index);
                                        },
                                      ),
                                      Text(order.quantity.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          orderProvider.increaseQuantity(index);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Total: Rp ${order.totalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Item:'),
                          Text(orderProvider.totalItems.toString()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Harga:'),
                          Text(
                            'Rp ${orderProvider.totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    if (orderProvider.orders.isNotEmpty) {
                      // Proses penyimpanan pesanan
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Pesanan berhasil disimpan!')),
                      );
                      orderProvider.clearOrders();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Keranjang kosong!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Simpan Pesanan'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}