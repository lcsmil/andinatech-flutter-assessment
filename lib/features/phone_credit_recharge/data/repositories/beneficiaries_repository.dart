import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/data/data_sources/beneficiaries_data_source.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/entities/beneficiary.dart';

abstract class BeneficiariesRepository {
  Future<List<Beneficiary>> getBeneficiaries();
}

class BeneficiariesDataRepository extends BeneficiariesRepository {

  BeneficiariesDataRepository(this._dataSource);

  final BeneficiariesDataSource _dataSource;

  @override
  Future<List<Beneficiary>> getBeneficiaries() async {
    return await _dataSource.getBeneficiaries();
  }
}