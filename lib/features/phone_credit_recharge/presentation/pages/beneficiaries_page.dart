import 'package:flutter/material.dart';

class BeneficiariesPage extends StatelessWidget {
  BeneficiariesPage({super.key});

  final beneficiaries = [
    Beneficiary(
      nickname: 'John Doe sdfsdfdsfdsfdsfdsfdsfdsfdsfds',
      phoneNumber: '+55 11 99999-9999',
      onPressed: () {},
    ),
    Beneficiary(
      nickname: 'Jane Doe',
      phoneNumber: '+55 11 99999-9999',
      onPressed: () {},
    ),
    Beneficiary(
      nickname: 'John Doe',
      phoneNumber: '+55 11 99999-9999',
      onPressed: () {},
    ),
    Beneficiary(
      nickname: 'John Doe',
      phoneNumber: '+55 11 99999-9999',
      onPressed: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (int i = 0; i < beneficiaries.length; i++)
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2.6,
                      child: Card(
                        margin: EdgeInsets.all(16),
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(beneficiaries[i].nickname),
                              Text(beneficiaries[i].phoneNumber),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _horizontalBeneficiariesRow(List<Beneficiary> data) {
  var list = <Widget>[SizedBox(width: 16)]; // 16 is start padding

  //create a new row widget for each data element
  for (var i = 0; i < data.length; i++) {
    list.add(
      Card(
        margin: EdgeInsets.all(16),
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data[i].nickname),
              Text(data[i].phoneNumber),
            ],
          ),
        ),
      ),
    );
  }

  // add the list of widgets to the Row as children
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    ),
  );
}

class Beneficiary {
  final String nickname;
  final String phoneNumber;
  final VoidCallback onPressed;

  Beneficiary({
    required this.nickname,
    required this.phoneNumber,
    required this.onPressed,
  });
}
