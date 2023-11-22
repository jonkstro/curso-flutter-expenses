// ignore_for_file: prefer_const_constructors

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(String) onRemove;

  const TransactionList(
      {super.key, required this.transactions, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // SÓ PRA DAR UM <BR>
                  SizedBox(height: constraints.maxHeight * .1),
                  SizedBox(
                    height: constraints.maxHeight * .3,
                    child: Text(
                      "Não há nenhuma trnasação cadastrada",
                      style: TextStyle(
                        fontFamily: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.fontFamily,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.fontSize,
                        color:
                            Theme.of(context).textTheme.headlineMedium?.color,
                      ),
                    ),
                  ),
                  // SÓ PRA DAR UM <BR>
                  SizedBox(height: constraints.maxHeight * .1),
                  SizedBox(
                    height: constraints.maxHeight * .5,
                    width: constraints.maxWidth * .5,
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
              );
            },
          )
        : ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            physics: PageScrollPhysics(),

            /// O BUILDER VAI CHAMAR DE POUCO EM POUCO, CONFORME FOR FAZENDO SCROLLS
            itemCount: transactions.length,
            itemBuilder: ((context, index) {
              final e = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      /**
                       * FittedBox é pra poder o texto se ajustar no texto
                       */
                      child: FittedBox(
                        child: Text(
                          'R\$${e.value.toStringAsFixed(2)}',
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
                    ),
                  ),
                  title: Text(
                    e.title,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.bodyMedium?.fontWeight,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('dd MMMM yyyy', 'PT_BR').format(e.date),
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),

                  /// VAI CHAMAR O ONREMOVE QUE TÁ CHAMANDO O REMOVETRANSACTION NO MAIN!!!!!!
                  trailing: MediaQuery.of(context).size.width < 400
                      ? IconButton(
                          onPressed: () {
                            onRemove(e.id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      : ElevatedButton.icon(
                          // Deixar ele transparente
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Excluir',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                ),
              );
              /**
               * NÃO VAI MAIS SER USADO O CARD!!!!!!!!!!1
               * MAS SE QUISER USAR CARD FICA AÍ DE EXEMPLO
               */
              // return Card(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.symmetric(
              //           horizontal: 15,
              //           vertical: 10,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).colorScheme.primary,
              //             width: 2,
              //           ),
              //           borderRadius: BorderRadius.circular(50),
              //           color: Theme.of(context).colorScheme.primary,
              //         ),
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //           /// Vai ter 2 casas decimais associada no valor de transação
              //           /// O \ antes do $ quer dizer que é char, que deve dar escape
              //           /// o outro $ quer dizer que é vairável, igual o ` no JS
              //           'R\$ ${e.value.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             fontSize: Theme.of(context)
              //                 .textTheme
              //                 .headlineMedium
              //                 ?.fontSize,
              //             fontWeight: Theme.of(context)
              //                 .textTheme
              //                 .headlineMedium
              //                 ?.fontWeight,
              //             color: Theme.of(context)
              //                 .textTheme
              //                 .headlineMedium
              //                 ?.color,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         margin: EdgeInsets.symmetric(
              //           horizontal: 30,
              //           vertical: 10,
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: <Widget>[
              //             Text(
              //               e.title,
              //               style: TextStyle(
              //                 fontSize: Theme.of(context)
              //                     .textTheme
              //                     .bodyMedium
              //                     ?.fontSize,
              //                 fontWeight: Theme.of(context)
              //                     .textTheme
              //                     .bodyMedium
              //                     ?.fontWeight,
              //               ),
              //             ),
              //             Text(
              //               /// Obs.: Para poder formatar a data dessa forma foi preciso
              //               /// adicionar a dependencia:    intl: ^0.17.0
              //               DateFormat('dd MMM yyyy').format(e.date),
              //               style: TextStyle(
              //                 fontSize: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.fontSize,
              //                 color: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.color,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            }),
            scrollDirection: Axis.vertical,
          );
  }
}
