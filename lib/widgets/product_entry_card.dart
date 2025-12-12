import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:football_shop/models/product_entry.dart';

class ProductEntryCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String _resolveThumbnail(String raw) {
      if (raw.isEmpty || raw.toLowerCase() == 'null') return '';
      Uri uri = Uri.tryParse(raw) ?? Uri();
      final bool useEmulatorHost = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
      const String emulatorHost = '10.0.2.2';
      if (uri.hasScheme) {
        if (useEmulatorHost &&
            (uri.host == 'localhost' || uri.host == '127.0.0.1')) {
          uri = uri.replace(host: emulatorHost);
        }
        return uri.toString();
      }
      final String base = useEmulatorHost ? 'http://$emulatorHost:8000' : 'http://localhost:8000';
      if (raw.startsWith('/')) return '$base$raw';
      return '$base/$raw';
    }

    final thumbUrl = _resolveThumbnail(product.thumbnail);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF12121A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    if (thumbUrl.isNotEmpty)
                      Image.network(
                        thumbUrl,
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 170,
                          color: Colors.grey[800],
                          child: const Center(child: Icon(Icons.broken_image, color: Colors.white70)),
                        ),
                      )
                    else
                      Container(
                        height: 170,
                        color: Colors.grey[800],
                        child: const Center(child: Icon(Icons.image_not_supported, color: Colors.white70)),
                      ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (product.isFeatured)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'FEATURED',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Price
                    Text(
                      'Rp${product.price}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Content preview
                    Text(
                      product.description.length > 100
                          ? '${product.description.substring(0, 100)}...'
                          : product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),

                    // Footer info
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber.shade400),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating}/5',
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.inventory_2, size: 16, color: Colors.white54),
                        const SizedBox(width: 4),
                        Text(
                          'Stock: ${product.stock}',
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
