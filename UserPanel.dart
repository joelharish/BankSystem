import 'dart:io';

import 'Transection.dart';
import 'User.dart';

class UserPanel extends User {
  UserPanel({
    super.fullName,
    super.nicNumber,
    super.phoneNumber,
    super.address,
    super.dob,
    super.Amount,
  });

  UserPanel.withAccount({
    required String accountNumber,
    String? fullName,
    String? nicNumber,
    String? phoneNumber,
    String? address,
    String? dob,
    double? initialDeposit,
  }) : super.withAccount(
         accountNumber: accountNumber,
         fullName: fullName,
         nicNumber: nicNumber,
         phoneNumber: phoneNumber,
         address: address,
         dob: dob,
         initialDeposit: initialDeposit,
       );

  void viewAccountDetails() {
    print("Account Number     : $accountNumber");
    print("Full Name          : $fullName");
    print("NIC Number         : $nicNumber");
    print("Phone Number       : $phoneNumber");
    print("Address            : $address");
    print("Date of Birth      : $dob");
    print("Amount             : $Amount");
  }

  void deposit(double amount) {
    if (amount <= 0) {
      print("Deposit amount must be greater than zero.");
      return;
    }
    Amount = (Amount ?? 0) + amount;
    print(
      "Successfully deposited $amount. New balance: ${Amount?.toStringAsFixed(2)}",
    );
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      print("Withdrawal amount must be greater than zero.");
      return;
    }
    if (Amount == null || Amount! < amount) {
      print("Insufficient balance for withdrawal.");
      return;
    }
    Amount = (Amount! - amount);
    print(
      "Successfully withdrew $amount. New balance: ${Amount?.toStringAsFixed(2)}",
    );
  }

  void transfer(User recipient, double amount) {
    if (amount <= 0) {
      print("Transfer amount must be greater than zero.");
      return;
    }
    if (Amount == null || Amount! < amount) {
      print("Insufficient balance for transfer.");
      return;
    }
    Amount = (Amount! - amount);
    recipient.Amount = (recipient.Amount ?? 0) + amount;

    final transaction = Transection(
      accountNumber: recipient.accountNumber,
      amount: amount,
      date: DateTime.now(),
    );

    transactions.add(transaction);
    recipient.transactions.add(
      Transection(
        accountNumber: accountNumber,
        amount: amount,
        date: DateTime.now(),
      ),
    );

    print(
      "Successfully transferred $amount to ${recipient.fullName}. New balance: ${Amount?.toStringAsFixed(2)}",
    );
  }

  void updateProfile() {
    stdout.write("Enter new Full Name (leave blank to keep current): ");
    String newFullName = stdin.readLineSync() ?? '';

    stdout.write("Enter new NIC Number (leave blank to keep current): ");
    String newNicNumber = stdin.readLineSync() ?? '';

    stdout.write("Enter new Phone Number (leave blank to keep current): ");
    String newPhoneNumber = stdin.readLineSync() ?? '';

    stdout.write("Enter new Address (leave blank to keep current): ");
    String newAddress = stdin.readLineSync() ?? '';

    var changed = false;
    if (newFullName.isNotEmpty) {
      fullName = newFullName;
      changed = true;
    }
    if (newNicNumber.isNotEmpty) {
      nicNumber = newNicNumber;
      changed = true;
    }
    if (newPhoneNumber.isNotEmpty) {
      phoneNumber = newPhoneNumber;
      changed = true;
    }
    if (newAddress.isNotEmpty) {
      address = newAddress;
      changed = true;
    }

    if (!changed) {
      print("No changes made to the profile.");
    } else {
      print("Profile updated successfully.");
    }
  }

  void logout() {
    print("Logging out...");
  }

  void mainScreen(List<User> users) {
    while (true) {
      print("================= Welcome to the User Panel ================");
      print("");
      print("""
          1. View Account
          2. Deposit
          3. Withdraw
          4. Transfer
          5. Transaction History
          6. Update Profile
          7. Logout
          """);

      stdout.write("Enter your choice: ");
      int choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          viewAccountDetails();
          break;
        case 2:
          stdout.write("Enter amount to deposit: ");
          double depositAmount = double.parse(stdin.readLineSync()!);
          deposit(depositAmount);
          break;
        case 3:
          stdout.write("Enter amount to withdraw: ");
          double withdrawAmount = double.parse(stdin.readLineSync()!);
          withdraw(withdrawAmount);
          break;
        case 4:
          stdout.write("Enter recipient's account number: ");
          String recipientAccountNumber = stdin.readLineSync()!;
          User? recipient;
          try {
            recipient = users.firstWhere(
              (user) => user.accountNumber == recipientAccountNumber,
            );
          } catch (_) {
            recipient = null;
          }
          if (recipient != null) {
            stdout.write("Enter amount to transfer: ");
            double transferAmount = double.parse(stdin.readLineSync()!);
            transfer(recipient, transferAmount);
          } else {
            print("Recipient not found.");
          }
          break;
        case 5:
          if (transactions.isEmpty) {
            print("No transaction history available.");
          } else {
            print("============= Transaction History =============");
            for (var transaction in transactions) {
              transaction.displayHistory();
            }
          }
          break;
        case 6:
          updateProfile();
          break;
        case 7:
          logout();
          if (choice == 7) {
            return; // Exit the mainScreen method to log out
          }
          break;
        default:
          print("Invalid choice. Please try again.");
      }
    }
  }
}
