class PhoneRegisterRequest {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String otp;

  PhoneRegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'name': '$firstName $lastName', // Combine first and last name
      'phone': phoneNumber,
      'otp': otp,
    };
  }

  // Validation method
  bool isValid() {
    return firstName.isNotEmpty &&
           lastName.isNotEmpty &&
           phoneNumber.isNotEmpty &&
           otp.isNotEmpty;
  }
}
