import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/entities/beneficiary.dart';

class CheckUserRechargeAllowedUseCase {
  CheckUserRechargeAllowedUseCase();

  bool call(Beneficiary beneficiary) {
    if ((beneficiary.isVerified && beneficiary.aedSpentInMonth <= 1000) ||
        (!beneficiary.isVerified && beneficiary.aedSpentInMonth <= 500)) {
      return true;
    }
    return false;
  }
}
