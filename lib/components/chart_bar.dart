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
    return Column(
      children: <Widget>[
        // VAI REDUZIR O TAMANHO DO TEXTO PARA NÃO EMPURRAR O RESTO PRA BAIXO
        // POR ISSO USAMOS FITTEDBOX
        FittedBox(
          child: Text("R\$ ${value.toStringAsFixed(2)}"),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
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
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
