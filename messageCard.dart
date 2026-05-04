import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'mensagens/models/mensagens.dart';

Widget buildMessageCard(BuildContext context, DocumentSnapshot document, String friend) {
  final mensagem = Mensagens.fromSnapshot(document);
  return new Container(
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
              child: Wrap(
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.spaceAround,
                children: [
                  Text(mensagem.msg)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
              child: Wrap(
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.spaceAround,
                children: [
                  Text(mensagem.dt.toString())
                ],
              ),
            ),
          ],
        ),
      ),
      onDoubleTap: () {
        print("Double tap");
      },
    ),
  );
}
