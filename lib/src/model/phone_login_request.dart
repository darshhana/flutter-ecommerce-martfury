class PhoneLoginRequest {
  final String phoneNumber;
  final String otp;

  PhoneLoginRequest({
    required this.phoneNumber,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
    'phone': phoneNumber,
    'otp': otp,
  };

  bool isValid() {
    return phoneNumber.isNotEmpty && otp.isNotEmpty;
  }
}
