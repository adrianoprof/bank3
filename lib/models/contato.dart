// define uma classe chamada 'contato', que representa um registro de contato no sistema
class Contato {
  // o 'id' é o identificador único do contato no banco de dados.
  // o tipo 'int?' (com interrogação) indica que ele pode ser nulo,
  // pois, normalmente, o banco define esse valor automaticamente ao salvar.
  final int? id;

  // 'nome' é obrigatório (por isso o 'required' será usado no construtor)
  // e armazena o nome da pessoa associada ao contato.
  final String nome;

  // 'numeroConta' também é obrigatório e guarda o número da conta vinculada ao contato.
  final int numeroConta;

  // construtor da classe: usado para criar novos objetos 'contato'.
  // o parâmetro 'id' é opcional (pode não ser informado),
  // mas 'nome' e 'numeroConta' são obrigatórios (por isso o 'required').
  Contato({this.id, required this.nome, required this.numeroConta});

  // método que converte o objeto 'contato' em um mapa (chave/valor).
  // esse formato é usado pelo sqflite para salvar os dados no banco.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "numero_conta": numeroConta,
    };
  }

  // sobrescreve o método padrão 'toString' do Dart
  // para facilitar a visualização dos dados do contato no console (debug, logs etc.)
  @override
  String toString() {
    return "Contato{id: $id, nome: $nome, numeroConta: $numeroConta}";
  }
}