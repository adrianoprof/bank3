import 'package:bank2/db/app_database.dart';
import 'package:flutter/material.dart';
import '../../models/transferencia.dart';
import '../../components/editor.dart';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();

  final TextEditingController _controladorCampoValor = TextEditingController();

  static const _tituloAppBar = 'Criando Transferência';
  static const _rotuloCampoValor = 'Valor';
  static const _dicaCampoValor = '0,00';
  static const _rotuloCampoNumeroConta = 'Número da conta';
  static const _dicaCampoNumeroConta = '0000';
  static const _textoBotaoConfirmar = 'Confirmar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
            ),

            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
            ),

            ElevatedButton(
              child: Text(_textoBotaoConfirmar),
              onPressed: () {
                debugPrint("Clicou no confirmar!");

                _criaTransferencia(
                  context,
                  _controladorCampoNumeroConta,
                  _controladorCampoValor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _criaTransferencia(
  BuildContext context,
  TextEditingController controladorCampoNumeroConta,
  TextEditingController controladorCampoValor,
) {
  final int? numeroConta = int.tryParse(controladorCampoNumeroConta.text);

  final double? valor = double.tryParse(controladorCampoValor.text);

  if (numeroConta != null && valor != null) {
    final transferenciaCriada = Transferencia(valor, numeroConta);

    salvarTransferencia(transferenciaCriada).then((id) {
      debugPrint('Transferência salva com id: $id');

      Navigator.pop(context, transferenciaCriada);
    });
  }
}
