import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/entities/beneficiary.dart';

class CheckTopUpLimitExceededUseCase {
  CheckTopUpLimitExceededUseCase();

  bool call(List<Beneficiary> beneficiaries) {
    final totalAedSpentInMonth = beneficiaries.fold<double>(
        0, (sum, item) => sum + item.aedSpentInMonth);

    return totalAedSpentInMonth > 3000;
  }
}
