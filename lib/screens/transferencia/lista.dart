import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transferencia.dart';
import 'formulario.dart';
import '../../db/app_database.dart';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTranferenciasState();
  }
}

class ListaTranferenciasState extends State<ListaTransferencias> {
  static const _tituloAppBar = "Transferências";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),

      body: FutureBuilder<List<Transferencia>>(
        future: buscarTransferencias(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar transferências!"));
          }

          if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text("Nenhuma transferência encontrada!"));
          }

          final transferencias = snapshot.data!;

          return ListView.builder(
            itemCount: transferencias.length,

            itemBuilder: (context, indice){
              final transferencia = transferencias[indice];
              return ItemTransferencia(transferencia);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Botão + pressionado!");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          ).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _atualiza(transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  // Campos para armazenar os dados do item
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    NumberFormat formato = NumberFormat.simpleCurrency();
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(formato.format(_transferencia.valor).toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}
