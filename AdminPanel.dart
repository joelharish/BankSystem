import 'dart:io';

import 'User.dart';

class AdminPanel extends User {
  final String adminUsername = "admin";
  final String adminPassword = "admin123";

  AdminPanel({
    super.fullName,
    super.nicNumber,
    super.phoneNumber,
    super.address,
    super.dob,
    super.Amount,
  });

  void adminLogin(List<User> users) {
    print("=============== Admin Login ===============");
    stdout.write("Enter Admin Username: ");
    String username = stdin.readLineSync()!;
    stdout.write("Enter Admin Password: ");
    String password = stdin.readLineSync()!;

    if (username == adminUsername && password == adminPassword) {
      print("Admin login successful!");
      mainScreen(users);
    } else {
      print("Invalid admin credentials. Access denied.");
    }
  }

  void viewAllUsers(List<User> users) {
    print("============= All Users =============");

    String pad(String text, int width) {
      final padded = text.padRight(width);
      return padded.length > width ? padded.substring(0, width) : padded;
    }

    final header =
        '${pad('Account Number', 16)} | ${pad('Full Name', 20)} | ${pad('NIC Number', 15)} | ${pad('Phone Number', 15)} | ${pad('Address', 25)} | ${pad('Date of Birth', 12)} | ${pad('Amount', 10)}';
    final separator = List.filled(header.length, '-').join();

    print(header);
    print(separator);

    for (var user in users) {
      final row =
          '${pad(user.accountNumber, 16)} | '
          '${pad(user.fullName ?? '-', 20)} | '
          '${pad(user.nicNumber ?? '-', 15)} | '
          '${pad(user.phoneNumber ?? '-', 15)} | '
          '${pad(user.address ?? '-', 25)} | '
          '${pad(user.dob ?? '-', 12)} | '
          '${pad(user.Amount?.toStringAsFixed(2) ?? '0.00', 10)}';
      print(row);
    }
  }

  void deleteUser(List<User> users, String accountNumber) {
    User? userToDelete;
    try {
      userToDelete = users.firstWhere(
        (user) => user.accountNumber == accountNumber,
      );
    } catch (_) {
      userToDelete = null;
    }

    if (userToDelete != null) {
      users.remove(userToDelete);
      print("User with account number $accountNumber has been deleted.");
    } else {
      print("No user found with account number $accountNumber.");
    }
  }

  void searchUser(List<User> users, String accountNumber) {
    User? matchingUser;
    try {
      matchingUser = users.firstWhere(
        (user) => user.accountNumber == accountNumber,
      );
    } catch (_) {
      matchingUser = null;
    }

    if (matchingUser != null) {
      print("============= User Details =============");
      matchingUser.display();
    } else {
      print("No user found with account number $accountNumber.");
    }
  }

  void blockUser(List<User> users, String accountNumber) {
    User? userToBlock;
    try {
      userToBlock = users.firstWhere(
        (user) => user.accountNumber == accountNumber,
      );
    } catch (_) {
      userToBlock = null;
    }

    if (userToBlock != null) {
      // Implement blocking logic here. For now, we'll just print a message.
      print("User with account number $accountNumber has been blocked.");
    } else {
      print("No user found with account number $accountNumber.");
    }
  }

  void updateUserProfile(
    List<User> users,
    String accountNumber, {
    String? fullName,
    String? nicNumber,
    String? phoneNumber,
    String? address,
    String? dob,
  }) {
    User? userToUpdate;
    try {
      userToUpdate = users.firstWhere(
        (user) => user.accountNumber == accountNumber,
      );
    } catch (_) {
      userToUpdate = null;
    }

    if (userToUpdate != null) {
      if (fullName != null) userToUpdate.fullName = fullName;
      if (nicNumber != null) userToUpdate.nicNumber = nicNumber;
      if (phoneNumber != null) userToUpdate.phoneNumber = phoneNumber;
      if (address != null) userToUpdate.address = address;
      if (dob != null) userToUpdate.dob = dob;

      print("User profile updated successfully.");
    } else {
      print("No user found with account number $accountNumber.");
    }
  }

  void mainScreen(List<User> users) {
    while (true) {
      print("================= Welcome to the Admin Panel ================");
      print("");
      print("""
          1. View All Users
          2. Delete User
          3. Search User
          4. Block User
          5. Update User Profile
          6. Logout
          """);

      stdout.write("Enter your choice: ");
      int choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          viewAllUsers(users);
          break;
        case 2:
          stdout.write("Enter account number to delete: ");
          String accountNumberToDelete = stdin.readLineSync()!;
          deleteUser(users, accountNumberToDelete);
          break;
        case 3:
          stdout.write("Enter account number to search: ");
          String accountNumberToSearch = stdin.readLineSync()!;
          searchUser(users, accountNumberToSearch);
          break;
        case 4:
          stdout.write("Enter account number to block: ");
          String accountNumberToBlock = stdin.readLineSync()!;
          blockUser(users, accountNumberToBlock);
          break;
        case 5:
          stdout.write("Enter account number to update: ");
          String accountNumberToUpdate = stdin.readLineSync()!;
          updateUserProfile(users, accountNumberToUpdate);
          break;
        case 6:
          print("Logging out...");
          return;
      }
    }
  }
}
