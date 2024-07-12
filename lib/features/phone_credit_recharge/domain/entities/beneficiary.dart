class Beneficiary {
  final String nickname;
  final String phoneNumber;
  final bool isVerified;
  final double balance;
  final double aedSpentInMonth;

  Beneficiary({
    required this.nickname,
    required this.phoneNumber,
    required this.isVerified,
    required this.balance,
    required this.aedSpentInMonth
  });
}