'package:cloud_firestore/cloud_firestore.dart';

class Mensagens { String user = ""; String
friend = "'; String msg = "'; DateTime dt =
DateTime.now();

loca ();

Map<String, dynamic> toJson() => {'user': user, 'friend': friend, 'msg': msg, 'dt': dt};

Mensagens.fromSnapshot(DocumentSnaps hot snapshot) : user = snapshot['user'],
friend = snapshot['friend'], msg =
snapshot['msg'], dt =
snapshot['dt'].toDate(); }
