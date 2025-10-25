import 'package:get/get.dart';
import 'package:martfury/src/model/ad.dart';
import 'package:martfury/src/model/category.dart';
import 'package:martfury/src/model/product.dart';
import 'package:martfury/src/model/brand.dart';
import 'package:martfury/src/service/category_service.dart';
import 'package:martfury/src/service/product_service.dart';
import 'package:martfury/src/service/ad_service.dart';
import 'package:martfury/src/service/brand_service.dart';
import 'package:martfury/src/service/website_sync_service.dart';
import 'package:martfury/src/service/email_service.dart';

class HomeController extends GetxController {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();
  final AdService _adService = AdService();
  final BrandService _brandService = BrandService();
  final WebsiteSyncService _websiteSyncService = WebsiteSyncService();

  // Reactive state variables
  final isLoading = true.obs;
  final adsLoading = true.obs;
  final error = RxnString(); // Rxn<String> for nullable string
  final adsError = RxnString(); // Added for ads error state
  final featuredCategories = <Category>[].obs;
  final featuredBrands = <Brand>[].obs;
  final flashSaleProducts = <Map<String, dynamic>>[].obs;
  final flashSaleEndTime =
      Rxn<DateTime>(); // Rxn<DateTime> for nullable DateTime
  final flashSaleName = ''.obs;
  final categoryProducts = <int, List<Product>>{}.obs;
  final ads = <Ad>[].obs;

  // Website sync state
  final isSyncing = false.obs;
  final syncError = RxnString();
  final lastSyncTime = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    loadAllData();
    loadAds();
    // Perform initial sync with ComeWant website
    syncWithWebsite();
  }

  Future<void> loadAds() async {
    adsLoading.value = true;
    adsError.value = null;
    try {
      final fetchedAds = await _adService.getAds();

      ads.assignAll(fetchedAds);
    } catch (e) {
      adsError.value = e.toString();
      ads.assignAll([]); // Clear ads on error
    } finally {
      adsLoading.value = false;
    }
  }

  Future<void> loadAllData() async {
    isLoading.value = true;
    error.value = null;

    try {
      // Load flash sale products
      final flashSaleData = await _productService.getFlashSaleProducts();

      if (flashSaleData.isNotEmpty) {
        flashSaleEndTime.value = flashSaleData['endDate'] as DateTime?;
        flashSaleName.value = flashSaleData['name'] as String;
        flashSaleProducts.assignAll(
          (flashSaleData['products'] as List<dynamic>)
              .map((product) => product as Map<String, dynamic>)
              .toList(),
        );
      }

      // Load featured categories
      final categories = await _categoryService.getCategories(isFeatured: true);
      featuredCategories.assignAll(categories);

      // Load featured brands
      final brands = await _brandService.getBrands(isFeatured: true);
      featuredBrands.assignAll(brands);

      // Load all products instead of filtering by categories
      await loadAllProducts();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadAllProducts() async {
    try {
      final products = await _productService.getAllProducts(
        order: 'default_sorting',
      );

      // Store products under a general key (0) for all products
      categoryProducts[0] = products['data'];
      categoryProducts.refresh();
    } catch (e) {
      categoryProducts[0] = [];
      categoryProducts.refresh();
    }
  }

  /// Sync with ComeWant website
  Future<void> syncWithWebsite() async {
    isSyncing.value = true;
    syncError.value = null;

    try {
      final syncResults = await WebsiteSyncService.performFullSync();

      // Update last sync time
      lastSyncTime.value = DateTime.now();

      // Process synced data and update local state
      if (syncResults['categories'] != null) {
        // Update categories with synced data
        // This would integrate with your existing category service
      }

      if (syncResults['products'] != null) {
        // Update products with synced data
        // This would integrate with your existing product service
      }

      if (syncResults['vendors'] != null) {
        // Update vendors/brands with synced data
        // This would integrate with your existing brand service
      }
    } catch (e) {
      syncError.value = e.toString();
    } finally {
      isSyncing.value = false;
    }
  }

  /// Send welcome email to new user
  Future<void> sendWelcomeEmail({
    required String userEmail,
    required String userName,
  }) async {
    try {
      await EmailService.sendWelcomeEmail(
        userEmail: userEmail,
        userName: userName,
      );
    } catch (e) {
      // Handle error silently or show user-friendly message
    }
  }

  /// Send order confirmation email
  Future<void> sendOrderConfirmationEmail({
    required String userEmail,
    required String orderId,
    required String totalAmount,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      await EmailService.sendOrderConfirmation(
        userEmail: userEmail,
        orderId: orderId,
        totalAmount: totalAmount,
        items: items,
      );
    } catch (e) {
      // Handle error silently or show user-friendly message
    }
  }

  /// Manual sync trigger
  Future<void> refreshWebsiteData() async {
    await syncWithWebsite();
  }
}
