// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  // Vai receber as transações no construtor
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  // CRIAR UM GETTER DE MAP DE CHAVE STRING E VALOR OBJECT (UMA VEZ VAI SER STRING, OUTRA VAI SER NUMERO...)
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // Aqui vamos diminuir os dias da semana de acordo com o index.
      // Diminuir index dias. (1 a 7)
      final weekDay = DateTime.now().subtract(Duration(days: index));

      // Inicialize o sistema de localização. Senão vai pegar tudo em ingles
      initializeDateFormatting('pt_BR', null);
      // De acordo com o dia, vai pegar a primeira letra. Ex.: Segunda-Feira -> 'S'
      String letraDia = DateFormat.E('pt_BR').format(weekDay).toUpperCase();

      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        /**
         * Se for o mesmo dia mes e ano do weekday, vai somar o valor da transação
         * no valor da soma total.
         */
        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }
      // print(letraDia);
      // print(totalSum);
      return {'day': letraDia, 'value': totalSum};
    });
  }

  // GETTER QUE VAI PEGAR O VALOR TOTAL DA SEMANA PRA DEPOIS CALCULAR A PORCENTAGEM
  double get _weekTotalValue {
    // REDUCE do MapReduce
    return groupedTransactions.fold(0, (soma, tr) {
      return soma + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      // Pra evitar de quebrar por overflowed pixels
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            // AQUI ELE DIVIDE OS ELEMENTOS PRA NÃO QUEBRAR A TELA
            return Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(1.5),
                child: ChartBar(
                  // Ele tá vindo OBJECT, então tem que castear pro valor certo
                  label: (tr['day'] as String),
                  value: (tr['value'] as double),
                  percentage: (tr['value'] as double) / _weekTotalValue,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
