import 'package:flutter/material.dart';
import 'formulario_contato.dart';
import '../../models/contato.dart';
import '../../db/app_database.dart';

class ListaContatos extends StatefulWidget {
  final List<Contato> _contatos = [];

  ListaContatos({super.key});

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos>{
  static const _tituloAppBar = "Contatos";

  @override
  void iniState(){
    super.initState();
    _carregarContatosDoBanco();
  }

  void _carregarContatosDoBanco() async{
    final contatosDoBanco = await buscarContatos();
    setState((){
      widget._contatos.addAll(contatosDoBanco);

    });
  }

  @override
  Widget build(BuildContext){
    return Scaffold();
  }

}