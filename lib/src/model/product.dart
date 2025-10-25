import 'image_sizes.dart';
import 'store.dart';

class Product {
  final int id;
  final String slug;
  final String name;
  final String sku;
  final String description;
  final String content;
  final int? quantity;
  final bool isOutOfStock;
  final String stockStatusLabel;
  final String stockStatusHtml;
  final double price;
  final String priceFormatted;
  final double? originalPrice;
  final String originalPriceFormatted;
  final double? reviewsAvg;
  final int reviewsCount;
  final ImageSizes imageWithSizes;
  final int? weight;
  final int? height;
  final int? wide;
  final int? length;
  final String imageUrl;
  final List<dynamic> productOptions;
  final Store? store;

  Product({
    required this.id,
    required this.slug,
    required this.name,
    required this.sku,
    required this.description,
    required this.content,
    this.quantity,
    required this.isOutOfStock,
    required this.stockStatusLabel,
    required this.stockStatusHtml,
    required this.price,
    required this.priceFormatted,
    this.originalPrice,
    required this.originalPriceFormatted,
    this.reviewsAvg,
    required this.reviewsCount,
    required this.imageWithSizes,
    this.weight,
    this.height,
    this.wide,
    this.length,
    required this.imageUrl,
    required this.productOptions,
    this.store,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final dynamic imageWithSizesJson = json['image_with_sizes'];
    // Fallbacks for images if image_with_sizes is missing
    final List<String> originImages = List<String>.from(
      (json['images'] as List?)?.cast<String>() ??
          (json['origin'] as List?)?.cast<String>() ??
          (json['image_url'] != null ? [json['image_url']] : []),
    );

    final ImageSizes imageSizes = imageWithSizesJson is Map<String, dynamic>
        ? ImageSizes.fromJson(imageWithSizesJson)
        : ImageSizes(
            origin: originImages,
            thumb: originImages,
            medium: originImages,
            small: originImages,
          );

    double? _toDouble(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }

    int? _toInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      return int.tryParse(v.toString());
    }

    return Product(
      id: _toInt(json['id']) ?? 0,
      slug: (json['slug'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      sku: (json['sku'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      quantity: _toInt(json['quantity']),
      isOutOfStock: (json['is_out_of_stock'] as bool?) ?? false,
      stockStatusLabel: (json['stock_status_label'] ?? '').toString(),
      stockStatusHtml: (json['stock_status_html'] ?? '').toString(),
      price: _toDouble(json['price']) ?? 0,
      priceFormatted: (json['price_formatted'] ?? '').toString(),
      originalPrice: _toDouble(json['original_price']),
      originalPriceFormatted:
          (json['original_price_formatted'] ?? '').toString(),
      reviewsAvg: _toDouble(json['reviews_avg']),
      reviewsCount: _toInt(json['reviews_count']) ?? 0,
      imageWithSizes: imageSizes,
      weight: _toInt(json['weight']),
      height: _toInt(json['height']),
      wide: _toInt(json['wide']),
      length: _toInt(json['length']),
      imageUrl: (json['image_url'] ??
              (originImages.isNotEmpty ? originImages.first : ''))
          .toString(),
      productOptions:
          (json['product_options'] as List?)?.cast<dynamic>() ?? const [],
      store: json['store'] is Map<String, dynamic>
          ? ((json['store'] as Map<String, dynamic>)['name'] != null
              ? Store.fromJson(json['store'] as Map<String, dynamic>)
              : null)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'sku': sku,
      'description': description,
      'content': content,
      'quantity': quantity,
      'is_out_of_stock': isOutOfStock,
      'stock_status_label': stockStatusLabel,
      'stock_status_html': stockStatusHtml,
      'price': price,
      'price_formatted': priceFormatted,
      'original_price': originalPrice,
      'original_price_formatted': originalPriceFormatted,
      'reviews_avg': reviewsAvg,
      'reviews_count': reviewsCount,
      'image_with_sizes': imageWithSizes.toJson(),
      'weight': weight,
      'height': height,
      'wide': wide,
      'length': length,
      'image_url': imageUrl,
      'product_options': productOptions,
      'store': store?.toJson(),
    };
  }
}
