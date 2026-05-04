final _user = TextEditingController();
final _friend = TextEditingController();
final _msg = TextEditingController();

List _resultsList = [];
late QuerySnapshot result;

Future<void> inicializarFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Firebase.initializeApp().whenComplete(() => print("Conectado"));
}

void _clicksend(BuildContext ctx) {
  Mensagens ms = new Mensagens();
  ms.friend = _friend.text.toString().trim();
  ms.user = _user.text.toString().trim();
  ms.msg = _msg.text.toString().trim();
  ms.dt = DateTime.now();

  CollectionReference instanciaColecaoFirestore =
      FirebaseFirestore.instance.collection("msg");

  Future<void> addMsg() {
    return instanciaColecaoFirestore
        .doc(ms.dt.toString().trim())
        .set(ms.toJson())
        .then((value) => print("Mensagem adicionada"))
        .catchError((onError) => print("Erro ao gravar no banco $onError"));
  }

  addMsg();
}

Future<void> _buscaRegistro() async {
  var banco = FirebaseFirestore.instance.collection("msg");
  var filtronaColecao = banco;
  var consulta;

  consulta = await filtronaColecao
      .where("friend", isEqualTo: _friend.text.trim())
      .where("user", isEqualTo: _user.text.trim())
      .limit(100);

  result = await consulta.get();
  setState(() {
    _resultsList = result.docs;
  });
}

Widget ContainerOldMessages() {
  return Container(
    color: Colors.transparent,
    height: 270,
    width: double.maxFinite,
    margin: EdgeInsets.only(left: 3, right: 3, bottom: 0, top: 0),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: _resultsList.length == null ? 0 : _resultsList.length,
      itemBuilder: (BuildContext ctx, int index) =>
          buildMessageCard(ctx, _resultsList[index], widget.friend),
    ),
  );
}

@override
Widget build(BuildContext context) {
  inicializarFirebase();
  _user.text = widget.user.toString();
  _friend.text = widget.friend.toString();

  return Scaffold(
    appBar: AppBar(
      title: Text("Mensagens"),
    ),
    body: _body(),
  );
}

Widget _body() {
  return ListView(
    padding: EdgeInsets.all(9),
    children: [
      TextosCustom("Conversas com seu amigo: " + _friend.text),
      TextosCustom(" ", 12, Colors.black),
      ContainerOldMessages(),
      ContainerInsere(_msg, "", "Digite a mensagem:"),
      BotoesCustom("Enviar", onPressed: () {
        _clicksend(context);
      }),
      BotoesCustom("Receber", onPressed: _buscaRegistro),
    ],
  );
}
