class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String passwordConfirmation;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'name': '$firstName $lastName', // Combine first and last name
      'email': email,
      'password': password,
      'phone': phone,
      'password_confirmation': passwordConfirmation,
    };
  }

  // Validation method
  bool isValid() {
    return firstName.isNotEmpty &&
           lastName.isNotEmpty &&
           email.isNotEmpty &&
           password.isNotEmpty &&
           phone.isNotEmpty &&
           passwordConfirmation.isNotEmpty &&
           password == passwordConfirmation;
  }
}
