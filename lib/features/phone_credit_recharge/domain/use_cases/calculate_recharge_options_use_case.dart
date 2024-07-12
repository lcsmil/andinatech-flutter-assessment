
class CalculateRechargeOptionsUseCase {
  CalculateRechargeOptionsUseCase();

  List<double> call(double balance)  {
    final List<double> allRechargeOptions = [5, 10, 20, 30, 50, 75,100];
    final List<double> filteredOptions = [];
    for(var option in allRechargeOptions) {
      option <= balance ? filteredOptions.add(option) : null;
    }
    return filteredOptions;
  }
}
