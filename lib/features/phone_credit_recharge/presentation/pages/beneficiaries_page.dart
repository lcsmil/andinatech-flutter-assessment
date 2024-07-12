import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/presentation/controller/beneficiaries_bloc.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/presentation/widgets/beneficiaries_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BeneficiariesPage extends StatefulWidget {
  const BeneficiariesPage({super.key});

  @override
  State<BeneficiariesPage> createState() => _BeneficiariesPageState();
}

class _BeneficiariesPageState extends State<BeneficiariesPage> {
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider<BeneficiariesBloc>(
      create: (context) => getIt.get<BeneficiariesBloc>()..getBeneficiaries(),
      child: BlocBuilder<BeneficiariesBloc, BeneficiariesState>(
        builder: (context, state) {
          final bloc = context.read<BeneficiariesBloc>();
          if (state is LoadedBeneficiariesState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 16),
                    if (state.beneficiaries.length <= 5)
                      AddBeneficiaryButton(onPressed: bloc.addBeneficiary),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            for (int i = 0; i < state.beneficiaries.length; i++)
                              BeneficiaryCard(
                                beneficiary: state.beneficiaries[i],
                                screenWidth: screenWidth,
                                onAddRechargePressed: () =>
                                    showAddRechargeBottomSheet(
                                  context: context,
                                  balance: state.beneficiaries[i].balance,
                                  rechargeOptions: bloc.checkRechargeOptions(
                                      state.beneficiaries[i].balance),
                                ),
                                shouldShowRechargeButton:
                                    bloc.checkTopUpLimitExceeded(
                                  state.beneficiaries,
                                )
                                        ? false
                                        : bloc.checkUserRechargeAllowed(
                                            state.beneficiaries[i],
                                          ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is LoadingBeneficiariesState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
