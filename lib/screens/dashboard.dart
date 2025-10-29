import 'package:flutter/material.dart';
import 'contatos/lista_contatos.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dasboard")),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset("images/bytebank_logo.png"),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),

              height: 100,
              width: 150,

              color: Theme.of(context).primaryColor,
              child: Material(
                // Importante para que o Container tenha o fundo desejado
                color: const Color.fromARGB(0, 0, 0, 0),

                child: InkWell(
                  onTap: () {
                    // Navegação para a lista de contatos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListaContatos(),
                      ),
                    );
                  },

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.people, color: Colors.white, size: 24),

                      Text(
                        'Contacts',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
