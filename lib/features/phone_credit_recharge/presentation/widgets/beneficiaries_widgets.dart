import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/domain/entities/beneficiary.dart';
import 'package:andinatech_flutter_assessment/features/phone_credit_recharge/presentation/beneficiaries_messages.dart';
import 'package:flutter/material.dart';

class AddBeneficiaryButton extends StatelessWidget {
  final Future<void> Function(Beneficiary) onPressed;

  const AddBeneficiaryButton({super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 60,
      child: OutlinedButton(
        onPressed: () => showAddBeneficiaryBottomSheet(
            context: context, onAddBeneficiary: onPressed),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            SizedBox(
              width: 10,
            ),
            Text(BeneficiariesMessages.addBeneficiaryButtonText),
          ],
        ),
      ),
    );
  }
}

class BeneficiaryCard extends StatelessWidget {
  final Beneficiary beneficiary;
  final double screenWidth;
  final void Function()? onAddRechargePressed;
  final bool shouldShowRechargeButton;

  const BeneficiaryCard({super.key,
    required this.beneficiary,
    required this.screenWidth,
    required this.onAddRechargePressed,
    required this.shouldShowRechargeButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.32,
      child: Card(
        margin: EdgeInsets.all(screenWidth * 0.02),
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                beneficiary.nickname,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                beneficiary.phoneNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              if (shouldShowRechargeButton)
                TextButton(
                  onPressed: onAddRechargePressed,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red.shade300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    BeneficiariesMessages.rechargeNowText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAddBeneficiaryBottomSheet({
  required BuildContext context,
  required Future<void> Function(Beneficiary) onAddBeneficiary,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: AddBeneficiaryWidget(onBeneficiaryAdded: (beneficiary) {
        onAddBeneficiary;
      }),
    ),
  );
}

class AddBeneficiaryWidget extends StatelessWidget {
  final _nicknameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final Function(Beneficiary beneficiary) onBeneficiaryAdded;

  AddBeneficiaryWidget({
    super.key,
    required this.onBeneficiaryAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          maxLength: 20,
          decoration: const InputDecoration(
            labelText: BeneficiariesMessages.nicknameLabelText,
          ),
          controller: _nicknameController,
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: const InputDecoration(
            labelText: BeneficiariesMessages.phoneNumberLabelText,
          ),
          keyboardType: TextInputType.phone,
          controller: _phoneNumberController,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            onBeneficiaryAdded(Beneficiary(
              nickname: _nicknameController.text,
              phoneNumber: _phoneNumberController.text,
              isVerified: false,
              balance: 0,
              aedSpentInMonth: 0,
            ));
            Navigator.pop(context);
          },
          child: const Text(BeneficiariesMessages.submitButtonText),
        ),
      ],
    );
  }
}

void showAddRechargeBottomSheet({
  required BuildContext context,
  required double balance,
  required List<double> rechargeOptions,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => RechargeBottomSheet(
      onRechargeSelected: (value) {},
      balance: balance,
      rechargeOptions: rechargeOptions,
    ),
  );
}

class RechargeBottomSheet extends StatelessWidget {
  final Function(double) onRechargeSelected;
  final double balance;
  final List<double> rechargeOptions;

  const RechargeBottomSheet({
    super.key,
    required this.onRechargeSelected,
    required this.balance,
    required this.rechargeOptions,
  });

  @override
  Widget build(BuildContext context) {
    List<RechargeButton> rechargeButtons = [];
    for (int i = 0; i < rechargeOptions.length; i++) {
      rechargeButtons.add(
        RechargeButton(
          onPressed: onRechargeSelected,
          value: rechargeOptions[i],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            BeneficiariesMessages.selectRechargeAmountText,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: rechargeButtons,
          ),
        ],
      ),
    );
  }
}

class RechargeButton extends StatelessWidget {
  final double value;
  final Function(double) onPressed;

  const RechargeButton(
      {super.key, required this.value, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(value),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text(
        "AED $value",
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}

void showRechargeBottomSheet({
  required BuildContext context,
  required Function(double) onValueSelected,
  required double balance,
  required List<double> rechargeOptions,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => RechargeBottomSheet(
      onRechargeSelected: onValueSelected,
      balance: balance,
      rechargeOptions: rechargeOptions,
    ),
  );
}