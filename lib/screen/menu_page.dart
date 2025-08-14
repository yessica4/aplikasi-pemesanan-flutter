import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_yessica_5simia1/provider/order_providers.dart';
import '../models/menu.dart';

class MenuScreen extends StatelessWidget {
  final List<Menu> menuItems = [
    Menu(
      imageUrl: 'assets/images/nasi.jpg',
      name: 'Nasi Goreng',
      price: 25000,
    ),
    Menu(
      imageUrl: 'assets/images/mie.jpg',
      name: 'Mie Goreng',
      price: 22000,
    ),
    Menu(
      imageUrl: 'assets/images/mie_ayam.png',
      name: 'Ayam Bakar',
      price: 32000,
    ),
    Menu(
      imageUrl: 'assets/images/pangsit.jpeg',
      name: 'Sate Ayam',
      price: 45000,
    ),
    Menu(
      imageUrl: 'assets/images/ayam.jpg',
      name: 'Ayam',
      price: 25000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Menu'),
        actions: [
          Consumer<OrderProvider>(
            builder: (context, orderProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, '/orders');
                    },
                  ),
                  if (orderProvider.totalItems > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          orderProvider.totalItems.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final menu = menuItems[index];
          return Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                Provider.of<OrderProvider>(
                  context,
                  listen: false,
                ).addOrder(menu);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${menu.name} ditambahkan ke keranjang'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(menu.imageUrl, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${menu.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
