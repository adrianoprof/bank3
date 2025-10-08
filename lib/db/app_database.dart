import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transferencia.dart';
import 'dart:io';

Future<Database> getDatabase() async{
  final String path = join(await getDatabasesPath(), 'bank.db');

  return openDatabase(
    path,
    onCreate: (db, version) async{
      await db.execute('CREATE TABLE transferencias('          
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '          
          'valor REAL, '          
          'numero_conta INTEGER)'
      );
    },
    version: 1,
  );
}

Future<int> salvarTransferencia(Transferencia transferencia) async{
  final Database db = await getDatabase();

  final Map<String, dynamic> transferenciaMap = {
    'valor': transferencia.valor,
    'numero_conta': transferencia.numeroConta,
  };

  return db.insert('transferencias', transferenciaMap);
}

Future <List<Transferencia>> buscarTransferencias() async{

  final Database db = await getDatabase();

  final List<Map<String, dynamic>> result = await db.query("transferencias");

  return List.generate(result.length, (i){
    return Transferencia(
      result[i]['valor'],
      result[i]['numero_conta']
    );

  });

}

Future<void> testarBanco() async{
  final String path = join(await getDatabasesPath(), 'bank.db');
  final File arquivoBanco = File(path);

  //await deleteDatabase(path);

  final bool existe = await arquivoBanco.exists();

  if(existe){
    print("****Banco de Dados encontrado: $path");

    final Database db = await openDatabase(path);

    final List<Map<String, dynamic>> tabelas = 
      await db.rawQuery("select name from sqlite_master where type='table'");

    if(tabelas.isNotEmpty){
      print("****Tabelas Encontradas: ");
      for(var tabela in tabelas){
        print('- ${tabela['name']}');

      }      
    }
    else{
      print('****Nenhuma tabela encontrada no banco!');
    }

    await db.close();
  }
  else{
    print("XXXX - O arquivo do banco de dados não foi encontrado em: $path");
  }

}