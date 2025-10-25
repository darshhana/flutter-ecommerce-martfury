import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:martfury/core/app_config.dart';
import 'package:martfury/src/service/token_service.dart';

class WebsiteSyncService {
  // Reuse the same base URL configured for the app (from .env)
  static String get _baseUrl {
    final url = AppConfig.apiBaseUrl;
    // Normalize: drop trailing slash for safe path concatenation
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  static Future<Map<String, String>> _buildHeaders({bool includeAuth = true}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Back-end expects this API key based on the rest of the app's calls
      'X-API-KEY': AppConfig.apiKey,
      'User-Agent': 'MartFury-Flutter-App/1.0',
    };

    if (includeAuth) {
      final token = await TokenService.getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  /// Sync products from ComeWant website
  static Future<List<Map<String, dynamic>>> syncProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
  }) async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing products from ComeWant website...');
      }

      final queryParams = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;

      // Use ecommerce namespace for products per server API
      final uri = Uri.parse('$_baseUrl/ecommerce/products')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: await _buildHeaders());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print(
            '✅ Products synced successfully: ${data['data']?.length ?? 0} items',
          );
        }
        return List<Map<String, dynamic>>.from(data['data'] ?? []);
      } else {
        if (kDebugMode) {
          print('❌ Failed to sync products: ${response.statusCode}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing products: $e');
      }
      return [];
    }
  }

  /// Sync categories from ComeWant website
  static Future<List<Map<String, dynamic>>> syncCategories() async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing categories from ComeWant website...');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/categories'),
        headers: await _buildHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print(
            '✅ Categories synced successfully: ${data['data']?.length ?? 0} items',
          );
        }
        return List<Map<String, dynamic>>.from(data['data'] ?? []);
      } else {
        if (kDebugMode) {
          print('❌ Failed to sync categories: ${response.statusCode}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing categories: $e');
      }
      return [];
    }
  }

  /// Sync vendors from ComeWant website
  static Future<List<Map<String, dynamic>>> syncVendors({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing vendors from ComeWant website...');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/vendors').replace(
          queryParameters: {'page': page.toString(), 'limit': limit.toString()},
        ),
        headers: await _buildHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print(
            '✅ Vendors synced successfully: ${data['data']?.length ?? 0} items',
          );
        }
        return List<Map<String, dynamic>>.from(data['data'] ?? []);
      } else {
        if (kDebugMode) {
          print('❌ Failed to sync vendors: ${response.statusCode}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing vendors: $e');
      }
      return [];
    }
  }

  /// Sync brands list
  static Future<List<Map<String, dynamic>>> syncBrands({
    int page = 1,
    int limit = 50,
  }) async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing brands from ComeWant website...');
      }

      final uri = Uri.parse('$_baseUrl/ecommerce/brands').replace(
        queryParameters: {
          'page': page.toString(),
          'per_page': limit.toString(),
        },
      );

      final response = await http.get(uri, headers: await _buildHeaders());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('✅ Brands synced: ${data['data']?.length ?? 0}');
        }
        return List<Map<String, dynamic>>.from(data['data'] ?? []);
      }

      if (kDebugMode) {
        print('❌ Failed to sync brands: ${response.statusCode}');
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing brands: $e');
      }
      return [];
    }
  }

  /// Sync products by brand id
  static Future<List<Map<String, dynamic>>> syncProductsByBrand({
    required String brandId,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing products for brand $brandId ...');
      }

      final uri = Uri.parse('$_baseUrl/ecommerce/brands/$brandId/products')
          .replace(queryParameters: {
        'page': page.toString(),
        'per_page': limit.toString(),
      });

      final response = await http.get(uri, headers: await _buildHeaders());
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['data'] ?? []);
      }

      if (kDebugMode) {
        print('❌ Failed to sync brand products: ${response.statusCode}');
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing brand products: $e');
      }
      return [];
    }
  }

  /// Sync product categories (ecommerce)
  static Future<List<Map<String, dynamic>>> syncProductCategories({
    int page = 1,
    int limit = 100,
  }) async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing product categories...');
      }

      final uri = Uri.parse('$_baseUrl/ecommerce/product-categories').replace(
        queryParameters: {
          'page': page.toString(),
          'per_page': limit.toString(),
        },
      );

      final response = await http.get(uri, headers: await _buildHeaders());
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['data'] ?? []);
      }

      if (kDebugMode) {
        print('❌ Failed to sync product categories: ${response.statusCode}');
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing product categories: $e');
      }
      return [];
    }
  }

  /// Sync user data with ComeWant website
  static Future<Map<String, dynamic>?> syncUserProfile({
    required String userId,
    required String authToken,
  }) async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing user profile with ComeWant website...');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/users/$userId'),
        headers: {
          ...(await _buildHeaders(includeAuth: false)),
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('✅ User profile synced successfully');
        }
        return data['data'];
      } else {
        if (kDebugMode) {
          print('❌ Failed to sync user profile: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing user profile: $e');
      }
      return null;
    }
  }

  /// Sync orders with ComeWant website
  static Future<List<Map<String, dynamic>>> syncOrders({
    required String userId,
    required String authToken,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing orders with ComeWant website...');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/users/$userId/orders').replace(
          queryParameters: {'page': page.toString(), 'limit': limit.toString()},
        ),
        headers: {
          ...(await _buildHeaders(includeAuth: false)),
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print(
            '✅ Orders synced successfully: ${data['data']?.length ?? 0} items',
          );
        }
        return List<Map<String, dynamic>>.from(data['data'] ?? []);
      } else {
        if (kDebugMode) {
          print('❌ Failed to sync orders: ${response.statusCode}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing orders: $e');
      }
      return [];
    }
  }

  /// Sync website settings and configuration
  static Future<Map<String, dynamic>?> syncWebsiteSettings() async {
    try {
      if (kDebugMode) {
        print('🔄 Syncing website settings from ComeWant...');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/v1/settings'),
        headers: await _buildHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('✅ Website settings synced successfully');
        }
        return data['data'];
      } else {
        if (kDebugMode) {
          print('❌ Failed to sync website settings: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing website settings: $e');
      }
      return null;
    }
  }

  /// Full sync - sync all data from ComeWant website
  static Future<Map<String, dynamic>> performFullSync() async {
    if (kDebugMode) {
      print('🔄 Starting full sync with ComeWant website...');
    }

    final results = <String, dynamic>{};

    try {
      // Sync categories first
      final categories = await syncCategories();
      results['categories'] = categories;

      // Sync products
      final products = await syncProducts(limit: 100);
      results['products'] = products;

      // Sync brands and map brand->products (lightweight)
      final brands = await syncBrands(limit: 100);
      results['brands'] = brands;

      // Optionally fetch a small sample of products per brand to prime cache
      final Map<String, List<Map<String, dynamic>>> brandProducts = {};
      for (final brand in brands.take(10)) {
        final id = (brand['id'] ?? brand['slug'])?.toString();
        if (id != null) {
          brandProducts[id] = await syncProductsByBrand(brandId: id, limit: 20);
        }
      }
      results['brandProducts'] = brandProducts;

      // Sync ecommerce product categories
      final productCategories = await syncProductCategories(limit: 200);
      results['productCategories'] = productCategories;

      // Sync vendors (if backend exposes it; harmless if empty)
      final vendors = await syncVendors(limit: 50);
      results['vendors'] = vendors;

      // Sync website settings
      final settings = await syncWebsiteSettings();
      results['settings'] = settings;

      if (kDebugMode) {
        print('✅ Full sync completed successfully');
        print('📊 Results:');
        print('   - Categories: ${categories.length}');
        print('   - Products: ${products.length}');
        print('   - Vendors: ${vendors.length}');
        print('   - Settings: ${settings != null ? 'Yes' : 'No'}');
      }

      return results;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Full sync failed: $e');
      }
      return results;
    }
  }
}
