// ignore_for_file: prefer_const_constructors

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SÓ PRA DAR UM <BR>
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Não há nenhuma trnasação cadastrada",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headlineMedium?.fontFamily,
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                  ),
                ),
                // SÓ PRA DAR UM <BR>
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  // child: Image.asset(
                  //   'assets/images/waiting.png',
                  //   fit: BoxFit.cover,
                  // ),
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    strokeAlign: 1,
                  ),
                )
              ],
            )
          : ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              physics: PageScrollPhysics(),

              /// O BUILDER VAI CHAMAR DE POUCO EM POUCO, CONFORME FOR FAZENDO SCROLLS
              itemCount: transactions.length,
              itemBuilder: ((context, index) {
                final e = transactions[index];
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          /// Vai ter 2 casas decimais associada no valor de transação
                          /// O \ antes do $ quer dizer que é char, que deve dar escape
                          /// o outro $ quer dizer que é vairável, igual o ` no JS
                          'R\$ ${e.value.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.fontWeight,
                            color: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.color,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              e.title,
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.fontSize,
                                fontWeight: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.fontWeight,
                              ),
                            ),
                            Text(
                              /// Obs.: Para poder formatar a data dessa forma foi preciso
                              /// adicionar a dependencia:    intl: ^0.17.0
                              DateFormat('dd MMM yyyy').format(e.date),
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.fontSize,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              scrollDirection: Axis.vertical,
            ),
    );
  }
}
