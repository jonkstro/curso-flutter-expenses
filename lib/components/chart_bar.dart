// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  // CONSTRUTOR
  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            // VAI REDUZIR O TAMANHO DO TEXTO PARA NÃO EMPURRAR O RESTO PRA BAIXO
            // POR ISSO USAMOS FITTEDBOX
            SizedBox(
              // RESPONSIVIDADE DO TAMANHO PRA OCUPAR 100%

              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text("R\$ ${value.toStringAsFixed(2)}"),
              ),
            ),
            // RESPONSIVIDADE DO TAMANHO PRA OCUPAR 100%
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              // RESPONSIVIDADE DO TAMANHO PRA OCUPAR 100%
              height: constraints.maxHeight * 0.6,
              width: 15,
              child: Stack(
                // Começar de baixo pra cima, já que vem por padrão de cima pra baixo
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        // Metade do tamanho deixa circular
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                          // Metade do tamanho deixa circular
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              // RESPONSIVIDADE DO TAMANHO PRA OCUPAR 100%
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
