import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final Map<String, dynamic> productData;

  ProductDetailScreen({
    required this.productId,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: productData['imageUrl'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: productData['imageUrl'],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                    ),
            ),
            
            SizedBox(height: 20),
            
            // Product Name and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    productData['name'] ?? 'No Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Text(
                  '\$${productData['price']?.toStringAsFixed(2) ?? '0.00'}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Category and Quantity
            Row(
              children: [
                Chip(
                  label: Text(
                    productData['category'] ?? 'Uncategorized',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue[800],
                ),
                SizedBox(width: 12),
                Chip(
                  label: Text(
                    'Qty: ${productData['quantity'] ?? 0}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: (productData['quantity'] ?? 0) > 0
                      ? Colors.green
                      : Colors.red,
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Description
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      productData['description'] ?? 'No description available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Stock Status
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (productData['quantity'] ?? 0) > 0
                    ? Colors.green[50]
                    : Colors.red[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: (productData['quantity'] ?? 0) > 0
                      ? const Color.fromARGB(255, 120, 223, 123)
                      : const Color.fromARGB(255, 214, 163, 163),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    (productData['quantity'] ?? 0) > 0
                        ? Icons.check_circle
                        : Icons.error,
                    color: (productData['quantity'] ?? 0) > 0
                        ? Colors.green
                        : Colors.red,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      (productData['quantity'] ?? 0) > 0
                          ? 'In Stock (${productData['quantity']} available)'
                          : 'Out of Stock',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: (productData['quantity'] ?? 0) > 0
                            ? Colors.green[800]
                            : Colors.red[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}