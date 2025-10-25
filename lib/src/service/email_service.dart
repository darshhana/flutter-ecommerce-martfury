import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:martfury/core/app_config.dart';

class EmailService {
  static const String _baseUrl =
      'https://us-central1-comewant-4a4c8.cloudfunctions.net';

  /// Send email using Firebase Cloud Functions
  static Future<bool> sendEmail({
    required String to,
    required String subject,
    required String body,
    String? from,
    bool isHtml = false,
  }) async {
    try {
      if (kDebugMode) {
        print('📧 Sending email to: $to');
        print('📧 Subject: $subject');
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/sendEmail'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConfig.apiKey}',
        },
        body: jsonEncode({
          'to': to,
          'subject': subject,
          'body': body,
          'from': from ?? 'noreply@comewant.com',
          'isHtml': isHtml,
        }),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('✅ Email sent successfully');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('❌ Email sending failed: ${response.statusCode}');
          print('Response: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error sending email: $e');
      }
      return false;
    }
  }

  /// Send welcome email to new users
  static Future<bool> sendWelcomeEmail({
    required String userEmail,
    required String userName,
  }) async {
    final subject = 'Welcome to ComeWant!';
    final body =
        '''
    <html>
    <body>
      <h2>Welcome to ComeWant, $userName!</h2>
      <p>Thank you for joining our multi-vendor marketplace.</p>
      <p>You can now:</p>
      <ul>
        <li>Browse thousands of products from trusted sellers</li>
        <li>Make secure purchases</li>
        <li>Track your orders</li>
        <li>Sell your own products</li>
      </ul>
      <p>Happy shopping!</p>
      <p>The ComeWant Team</p>
    </body>
    </html>
    ''';

    return await sendEmail(
      to: userEmail,
      subject: subject,
      body: body,
      isHtml: true,
    );
  }

  /// Send order confirmation email
  static Future<bool> sendOrderConfirmation({
    required String userEmail,
    required String orderId,
    required String totalAmount,
    required List<Map<String, dynamic>> items,
  }) async {
    final subject = 'Order Confirmation - #$orderId';

    String itemsList = '';
    for (var item in items) {
      itemsList +=
          '<li>${item['name']} x ${item['quantity']} - \$${item['price']}</li>';
    }

    final body =
        '''
    <html>
    <body>
      <h2>Order Confirmation</h2>
      <p>Thank you for your order!</p>
      <p><strong>Order ID:</strong> #$orderId</p>
      <p><strong>Total Amount:</strong> \$$totalAmount</p>
      <h3>Items Ordered:</h3>
      <ul>$itemsList</ul>
      <p>We'll send you tracking information once your order ships.</p>
      <p>Thank you for shopping with ComeWant!</p>
    </body>
    </html>
    ''';

    return await sendEmail(
      to: userEmail,
      subject: subject,
      body: body,
      isHtml: true,
    );
  }

  /// Send password reset email
  static Future<bool> sendPasswordResetEmail({
    required String userEmail,
    required String resetToken,
  }) async {
    final subject = 'Password Reset - ComeWant';
    final resetUrl = '${AppConfig.apiBaseUrl}/reset-password?token=$resetToken';

    final body =
        '''
    <html>
    <body>
      <h2>Password Reset Request</h2>
      <p>You requested to reset your password for your ComeWant account.</p>
      <p>Click the link below to reset your password:</p>
      <a href="$resetUrl" style="background-color: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Reset Password</a>
      <p>This link will expire in 24 hours.</p>
      <p>If you didn't request this, please ignore this email.</p>
    </body>
    </html>
    ''';

    return await sendEmail(
      to: userEmail,
      subject: subject,
      body: body,
      isHtml: true,
    );
  }

  /// Send vendor notification email
  static Future<bool> sendVendorNotification({
    required String vendorEmail,
    required String message,
    required String type,
  }) async {
    final subject = 'ComeWant Notification - $type';

    final body =
        '''
    <html>
    <body>
      <h2>ComeWant Vendor Notification</h2>
      <p><strong>Type:</strong> $type</p>
      <p>$message</p>
      <p>Please log in to your vendor dashboard for more details.</p>
    </body>
    </html>
    ''';

    return await sendEmail(
      to: vendorEmail,
      subject: subject,
      body: body,
      isHtml: true,
    );
  }
}
