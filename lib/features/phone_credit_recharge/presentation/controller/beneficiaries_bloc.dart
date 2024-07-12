import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/entities/beneficiary.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/use_cases/calculate_recharge_options_use_case.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/use_cases/check_user_recharge_allowed_use_case.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/use_cases/get_beneficiaries_use_case.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/use_cases/check_top_up_limit_exceeded_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'beneficiaries_state.dart';

class BeneficiariesBloc extends Cubit<BeneficiariesState> {
  final GetBeneficiariesUseCase getBeneficiariesUseCase;
  final CheckUserRechargeAllowedUseCase checkUserRechargeAllowedUseCase;
  final CalculateRechargeOptionsUseCase checkRechargeOptionsUseCase;
  final CheckTopUpLimitExceededUseCase sumAllBeneficiariesTopUpUseCase;

  BeneficiariesBloc(
    this.getBeneficiariesUseCase,
    this.checkUserRechargeAllowedUseCase,
    this.checkRechargeOptionsUseCase,
    this.sumAllBeneficiariesTopUpUseCase,
  ) : super(InitialBeneficiariesState());

  Future<void> getBeneficiaries() async {
    emit(LoadingBeneficiariesState());

    final beneficiaries = await getBeneficiariesUseCase.call();

    emit(LoadedBeneficiariesState(beneficiaries: beneficiaries));
  }

  bool checkUserRechargeAllowed(Beneficiary beneficiary) {
    return checkUserRechargeAllowedUseCase.call(beneficiary);
  }

  List<double> checkRechargeOptions(double balance) {
    return checkRechargeOptionsUseCase.call(balance);
  }

  bool checkTopUpLimitExceeded(List<Beneficiary> beneficiaries) {
    return (sumAllBeneficiariesTopUpUseCase.call(beneficiaries));
  }

  Future<void> addBeneficiary(Beneficiary beneficiary) async {}
}
