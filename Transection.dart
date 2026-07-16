import 'dart:math';

class Transection {
  final String? id;
  String? accountNumber;
  double? amount;
  DateTime? date;

  Transection
  ({
    this.accountNumber, 
    this.amount, 
    this.date
  }) : id = _generateId();

  static String _generateId() {
    final random = Random();
    return 'TH' + List.generate(3, (index) => random.nextInt(10)).join();
  }

  Map<String, List<Object?>> get transectionData => {
    id!: [
      accountNumber,
      amount,
      date,
    ],
  };

  void displayHistory() {
    print("$id --> $accountNumber --> $amount --> $date");
  }

}