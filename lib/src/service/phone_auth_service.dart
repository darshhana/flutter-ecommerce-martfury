import 'package:flutter/foundation.dart';
import 'package:martfury/src/model/phone_login_request.dart';
import 'package:martfury/src/model/phone_register_request.dart';
import 'package:martfury/src/service/base_service.dart';
import 'package:martfury/src/service/token_service.dart';
import 'package:martfury/src/service/notification_service.dart';

class PhoneAuthService extends BaseService {

  /// Send OTP to phone number using ComeWant backend
  Future<void> sendOTP(String phoneNumber) async {
    try {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Sending OTP to $phoneNumber');
      }

      final Map<String, Object> requestData = {
        'phone': phoneNumber,
      };

      if (kDebugMode) {
        print('📱 PhoneAuthService: Sending OTP request: ${requestData}');
      }

      final response = await postAuth('/api/v1/phone/send-otp', requestData);

      if (kDebugMode) {
        print('📱 PhoneAuthService: OTP send response: $response');
      }

      if (response['error'] == false) {
        if (kDebugMode) {
          print('📱 PhoneAuthService: OTP sent successfully');
        }
      } else {
        throw Exception(response['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Error sending OTP: $e');
      }
      throw Exception('Failed to send OTP: $e');
    }
  }

  /// Verify OTP using ComeWant backend
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    try {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Verifying OTP for $phoneNumber');
      }

      final Map<String, Object> requestData = {
        'phone': phoneNumber,
        'otp': otp,
      };

      if (kDebugMode) {
        print('📱 PhoneAuthService: Verifying OTP request: ${requestData}');
      }

      final response = await postAuth('/api/v1/phone/verify-otp', requestData);

      if (kDebugMode) {
        print('📱 PhoneAuthService: OTP verification response: $response');
      }

      if (response['error'] == false) {
        if (kDebugMode) {
          print('📱 PhoneAuthService: OTP verified successfully');
        }
        return true;
      } else {
        throw Exception(response['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Error verifying OTP: $e');
      }
      throw Exception('Failed to verify OTP: $e');
    }
  }

  /// Register user with phone number using ComeWant backend
  Future<Map<String, dynamic>> registerWithPhone(PhoneRegisterRequest request) async {
    try {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Registering with phone: ${request.phoneNumber}');
      }

      // First verify OTP
      await verifyOTP(request.phoneNumber, request.otp);

      // Prepare registration data for ComeWant backend
      final Map<String, Object> requestData = {
        'phone': request.phoneNumber,
        'otp': request.otp,
        'first_name': request.firstName,
        'last_name': request.lastName,
      };

      if (kDebugMode) {
        print('📱 PhoneAuthService: Registering with backend: ${requestData}');
      }

      final response = await postAuth('/api/v1/phone/verify-otp', requestData);

      if (kDebugMode) {
        print('📱 PhoneAuthService: Backend registration response: $response');
      }

      if (response['error'] == false && response['data'] != null) {
        // Store the token
        await TokenService.saveToken(response['data']['token']);
        
        // Register device token for notifications
        await NotificationService.registerDeviceToken();
        
        return response['data'];
      } else {
        throw Exception(response['message'] ?? 'Registration failed');
      }
    } catch (e) {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Registration error: $e');
      }
      throw Exception('Failed to register: $e');
    }
  }

  /// Login user with phone number using ComeWant backend
  Future<Map<String, dynamic>> loginWithPhone(PhoneLoginRequest request) async {
    try {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Logging in with phone: ${request.phoneNumber}');
      }

      // Prepare login data for ComeWant backend
      final Map<String, Object> requestData = {
        'phone': request.phoneNumber,
        'otp': request.otp,
      };

      if (kDebugMode) {
        print('📱 PhoneAuthService: Logging in with backend: ${requestData}');
      }

      final response = await postAuth('/api/v1/phone/verify-otp', requestData);

      if (kDebugMode) {
        print('📱 PhoneAuthService: Backend login response: $response');
      }

      if (response['error'] == false && response['data'] != null) {
        // Store the token
        await TokenService.saveToken(response['data']['token']);
        
        // Register device token for notifications
        await NotificationService.registerDeviceToken();
        
        return response['data'];
      } else {
        throw Exception(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Login error: $e');
      }
      throw Exception('Failed to login: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Signing out');
      }
      
      // Unregister device token before logout
      await NotificationService.unregisterDeviceToken();
      await TokenService.deleteToken();
    } catch (e) {
      if (kDebugMode) {
        print('📱 PhoneAuthService: Sign out error: $e');
      }
      throw Exception('Failed to sign out: $e');
    }
  }
}