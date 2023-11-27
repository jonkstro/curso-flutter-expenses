import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.e,
    required this.onRemove,
  });

  final Transaction e;
  final void Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
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
                  fontSize:
                      Theme.of(context).textTheme.headlineMedium?.fontSize,
                  fontWeight:
                      Theme.of(context).textTheme.headlineMedium?.fontWeight,
                  color: Theme.of(context).textTheme.headlineMedium?.color,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          e.title,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
            fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
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
  }
}