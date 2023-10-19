import 'package:my_imc_challenge_flutter/models/pessoa_model.dart';

class PessoaRepository {
  final List<Pessoa> _pessoas = [];

  Future<void> adicionar(Pessoa pessoa) async {
    await Future.delayed(const Duration(milliseconds: 1));
    _pessoas.add(pessoa);
  }

  Future<void> remover(String id) async {
    await Future.delayed(const Duration(milliseconds: 1));
    _pessoas.remove(_pessoas.where((element) => element.id == id).first);
  }

  Future<List<Pessoa>> listarPessoas() async {
    await Future.delayed(const Duration(milliseconds: 1));
    return _pessoas;
  }
}
