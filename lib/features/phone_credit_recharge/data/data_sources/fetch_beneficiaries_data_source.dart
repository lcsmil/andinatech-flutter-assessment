import 'dart:convert';

import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/entities/beneficiary.dart';
import 'package:flutter/services.dart';

abstract class BeneficiariesDataSource {
  Future<List<Beneficiary>> getBeneficiaries();
}

class HttpBeneficiariesDataSource implements BeneficiariesDataSource {
  @override
  Future<List<Beneficiary>> getBeneficiaries() async {
    final jsonString = await rootBundle.loadString('assets/beneficiaries.json');

    return await parseBeneficiaries(jsonString);
  }

  Future<List<Beneficiary>> parseBeneficiaries(String json) async {
    final decoded = jsonDecode(json) as List<dynamic>;
    final beneficiaries = decoded
        .map((beneficiaryMap) => Beneficiary(
              nickname: beneficiaryMap['nickname'] as String,
              phoneNumber: beneficiaryMap['phoneNumber'] as String,
              isVerified: beneficiaryMap['isVerified'] as bool,
              balance: beneficiaryMap['balance'] as double,
              aedSpentInMonth: beneficiaryMap['aedSpentInMonth'] as double,
            ))
        .toList();
    return beneficiaries;
  }
}
