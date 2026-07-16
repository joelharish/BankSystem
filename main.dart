import 'dart:async';
import 'dart:io';
import 'AdminPanel.dart';
import 'User.dart';
import 'UserPanel.dart';

final List<User> users = [];

void CreateAccount() {
  print("============= Create Account =============");

  stdout.write("Enter Full Name: ");
  String fullName = stdin.readLineSync()!;

  stdout.write("Enter NIC Number: ");
  String nicNumber = stdin.readLineSync()!;

  stdout.write("Enter Phone Number: ");
  String phoneNumber = stdin.readLineSync()!;

  stdout.write("Enter Address: ");
  String address = stdin.readLineSync()!;

  stdout.write("Enter Date of Birth (YYYY-MM-DD): ");
  String dob = stdin.readLineSync()!;

  stdout.write("Enter Deposit Amount: ");
  double initialDeposit = double.parse(stdin.readLineSync()!);

  User newUser = User(
    fullName: fullName,
    nicNumber: nicNumber,
    phoneNumber: phoneNumber,
    address: address,
    dob: dob,
    Amount: initialDeposit,
  );

  users.add(newUser);

  print("\nAccount Created Successfully!");
  print("Account Number: ${newUser.accountNumber}");

  //For Testing Purpose
  print("\nUser Details:");
  newUser.display();
  //-------------------------
}

void login() {
  print("============= User Login =============");

  stdout.write("Enter Account Number: ");
  String accountNumber = stdin.readLineSync()!;

  User? matchingUser;
  try {
    matchingUser = users.firstWhere(
      (user) => user.accountNumber == accountNumber,
    );
  } catch (_) {
    matchingUser = null;
  }

  if (matchingUser != null) {
    print("Login Successful!");
    UserPanel userPanel = UserPanel.withAccount(
      accountNumber: matchingUser.accountNumber,
      fullName: matchingUser.fullName,
      nicNumber: matchingUser.nicNumber,
      phoneNumber: matchingUser.phoneNumber,
      address: matchingUser.address,
      dob: matchingUser.dob,
      initialDeposit: matchingUser.Amount,
    );
    userPanel.mainScreen(users);
  } else {
    print("Invalid Account Number. Please try again.");
  }
}

void main() {
  while (true) {
    print("===================== BANK SYSTEM =====================");
    print("");
    print("""
            1. Create Account
            2. User Login
            3. Admin Login
            4. Exit
          """);

    stdout.write("Enter your choice: ");
    int input = int.parse(stdin.readLineSync()!);

    switch (input) {
      case 1:
        CreateAccount();
        break;
      case 2:
        login();
        break;
      case 3:
        AdminPanel adminPanel = AdminPanel();
        adminPanel.adminLogin(users);
        break;
      case 4:
        print("Exiting the program...");
        exit(0);
      default:
        Timer(const Duration(seconds: 5), () {
          print("Invalid choice. Please try again.");
        });
    }
  }
}
