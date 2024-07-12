import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/data/repositories/beneficiaries_repository.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/entities/beneficiary.dart';

class GetBeneficiariesUseCase{
  GetBeneficiariesUseCase(
      this.beneficiariesRepository
      );

  final BeneficiariesRepository beneficiariesRepository;

  Future<List<Beneficiary>> call() async {
    return await beneficiariesRepository.getBeneficiaries();
  }
}