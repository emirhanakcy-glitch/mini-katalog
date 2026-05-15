import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'detail_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];
  List<Product> _filtered = [];
  List<Product> _cart = [];
  bool _loading = true;
  final TextEditingController _search = TextEditingController();

  // Simülasyon verisi (API yerine)
  final List<Map<String, dynamic>> _mockData = [
    {'id': 1, 'title': 'iPhone 15 Pro', 'description': 'Apple iPhone 15 Pro - 256GB, Titanium Black', 'price': 999.99, 'category': 'electronics', 'image': 'https://fakestoreapi.com/img/81fAn1SBklL._AC_UL640_FMwebp_QL65_.jpg'},
    {'id': 2, 'title': 'MacBook Air M2', 'description': 'Apple MacBook Air 13 inç M2 çip, 8GB RAM, 256GB SSD', 'price': 1299.00, 'category': 'electronics', 'image': 'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg'},
    {'id': 3, 'title': 'AirPods Pro', 'description': 'Apple AirPods Pro 2. Nesil - Aktif Gürültü Engelleme', 'price': 249.00, 'category': 'electronics', 'image': 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg'},
    {'id': 4, 'title': 'Samsung Galaxy S24', 'description': 'Samsung Galaxy S24 Ultra - 512GB, Phantom Black', 'price': 849.99, 'category': 'electronics', 'image': 'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_FMwebp_QL65_.jpg'},
    {'id': 5, 'title': 'Slim Fit Gömlek', 'description': 'Erkek Slim Fit Oxford Gömlek - Pamuklu, Beyaz', 'price': 49.90, 'category': 'clothing', 'image': 'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg'},
    {'id': 6, 'title': 'Spor Ayakkabı', 'description': 'Unisex Koşu Ayakkabısı - Hafif ve Nefes Alabilir', 'price': 89.90, 'category': 'clothing', 'image': 'https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg'},
    {'id': 7, 'title': 'Altın Küpe', 'description': '18 Ayar Altın Küpe - El İşçiliği', 'price': 550.00, 'category': 'jewelery', 'image': 'https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_FMwebp_QL65_.jpg'},
    {'id': 8, 'title': 'Gümüş Kolye', 'description': '925 Ayar Gümüş Kolye - Kalp Motifli', 'price': 299.00, 'category': 'jewelery', 'image': 'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_FMwebp_QL65_.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _search.addListener(_onSearch);
  }

  void _loadProducts() {
    final products = _mockData.map((e) => Product.fromJson(e)).toList();
    setState(() {
      _products = products;
      _filtered = products;
      _loading = false;
    });
  }

  void _onSearch() {
    final q = _search.text.toLowerCase();
    setState(() {
      _filtered = _products
          .where((p) => p.name.toLowerCase().contains(q) || p.category.toLowerCase().contains(q))
          .toList();
    });
  }

  void _addToCart(Product p) {
    setState(() => _cart.add(p));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${p.name} sepete eklendi!'), duration: const Duration(seconds: 1)),
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        foregroundColor: Colors.white,
        title: const Text('Mini Katalog', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartPage(cart: _cart)),
                ),
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 6, top: 6,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text('${_cart.length}', style: const TextStyle(fontSize: 11, color: Colors.white)),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _search,
              decoration: InputDecoration(
                hintText: 'Ürün ara...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF27AE60)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF27AE60)))
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) => ProductCard(
                      product: _filtered[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(product: _filtered[i], onAddToCart: _addToCart),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
