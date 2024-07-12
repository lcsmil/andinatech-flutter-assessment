import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/data/data_sources/fetch_beneficiaries_data_source.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/data/repositories/beneficiaries_repository.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/use_cases/calculate_recharge_options_use_case.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/use_cases/check_top_up_limit_exceeded_use_case.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/use_cases/check_user_recharge_allowed_use_case.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/use_cases/get_beneficiaries_use_case.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/presentation/controller/beneficiaries_bloc.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/presentation/pages/beneficiaries_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory<BeneficiariesBloc>(() => BeneficiariesBloc(
        getIt.get<GetBeneficiariesUseCase>(),
        getIt.get<CheckUserRechargeAllowedUseCase>(),
        getIt.get<CalculateRechargeOptionsUseCase>(),
        getIt.get<CheckTopUpLimitExceededUseCase>(),
      ));
  getIt.registerFactory<GetBeneficiariesUseCase>(
      () => GetBeneficiariesUseCase(getIt.get<BeneficiariesRepository>()));
  getIt.registerFactory<CheckUserRechargeAllowedUseCase>(
      () => CheckUserRechargeAllowedUseCase());
  getIt.registerFactory<CalculateRechargeOptionsUseCase>(
      () => CalculateRechargeOptionsUseCase());
  getIt.registerFactory<CheckTopUpLimitExceededUseCase>(
      () => CheckTopUpLimitExceededUseCase());
  getIt.registerFactory<BeneficiariesRepository>(() =>
      BeneficiariesDataRepository(getIt.get<HttpBeneficiariesDataSource>()));
  getIt.registerFactory<HttpBeneficiariesDataSource>(
      () => HttpBeneficiariesDataSource());
}

void main() {
  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const BeneficiariesPage(),
    );
  }
}
