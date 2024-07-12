part of 'beneficiaries_bloc.dart';

sealed class BeneficiariesState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialBeneficiariesState extends BeneficiariesState {}

class LoadingBeneficiariesState extends BeneficiariesState {}

class LoadedBeneficiariesState extends BeneficiariesState {
  final List<Beneficiary> beneficiaries;

  LoadedBeneficiariesState({required this.beneficiaries});

  LoadedBeneficiariesState copyWith({List<Beneficiary>? beneficiaries}) =>
      LoadedBeneficiariesState(
          beneficiaries: beneficiaries ?? this.beneficiaries);

  @override
  List<Object> get props => [beneficiaries];
}
