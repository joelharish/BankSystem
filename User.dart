import 'dart:math';

import 'Transection.dart';

class User {
  final String accountNumber;
  String? fullName;
  String? nicNumber;
  String? phoneNumber;
  String? address;
  String? dob;
  double? Amount;
  final List<Transection> transactions = [];

  User({
    this.fullName,
    this.nicNumber,
    this.phoneNumber,
    this.address,
    this.dob,
    this.Amount,
  }) : accountNumber = _generateAccountNumber();

  User.withAccount({
    required String accountNumber,
    String? fullName,
    String? nicNumber,
    String? phoneNumber,
    String? address,
    String? dob,
    double? initialDeposit,
  }) : accountNumber = accountNumber {
    this.fullName = fullName;
    this.nicNumber = nicNumber;
    this.phoneNumber = phoneNumber;
    this.address = address;
    this.dob = dob;
    this.Amount = initialDeposit;
  }

  static String _generateAccountNumber() {
    final random = Random();
    return '00' + List.generate(8, (index) => random.nextInt(10)).join();
  }

  Map<String, List<Object?>> get userData => {
    accountNumber: [fullName, nicNumber, phoneNumber, address, dob, Amount],
  };

  void display() {
    print("Account Number     : $accountNumber");
    print("Full Name          : $fullName");
    print("NIC Number         : $nicNumber");
    print("Phone Number       : $phoneNumber");
    print("Address            : $address");
    print("Date of Birth      : $dob");
    print("Amount             : ${Amount?.toStringAsFixed(2) ?? '0.00'}");
  }
}
