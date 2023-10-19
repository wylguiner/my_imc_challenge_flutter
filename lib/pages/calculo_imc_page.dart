import 'package:flutter/material.dart';
import 'package:my_imc_challenge_flutter/models/pessoa_model.dart';
import 'package:my_imc_challenge_flutter/repositories/pessoa_repository.dart';
import 'package:my_imc_challenge_flutter/services/calculadora_imc_service.dart';
import 'package:my_imc_challenge_flutter/shared/widgets/text_label.dart';

class CalculoIMCPage extends StatefulWidget {
  const CalculoIMCPage({super.key});

  @override
  State<CalculoIMCPage> createState() => _CalculoIMCPageState();
}

class _CalculoIMCPageState extends State<CalculoIMCPage> {
  var pessoaRepository = PessoaRepository();
  var _pessoas = <Pessoa>[];

  var nomeController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  var pesoController = TextEditingController(text: "");

  var calculadora = Calculo();

  @override
  void initState() {
    super.initState();
    obterPessoas();
  }

  void obterPessoas() async {
    _pessoas = await pessoaRepository.listarPessoas();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Cálculo de IMC!")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Center(child: TextLabel(texto: "Nome")),
              TextField(
                  controller: nomeController, keyboardType: TextInputType.name),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TextLabel(texto: "Altura"),
                      TextField(
                          controller: alturaController,
                          keyboardType: TextInputType.number),
                    ],
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                    children: [
                      const TextLabel(texto: "Peso"),
                      TextField(
                          controller: pesoController,
                          keyboardType: TextInputType.number),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextButton(
                    onPressed: () async {
                      double altura = double.parse(alturaController.text);
                      double peso = double.parse(pesoController.text);
                      var imc =
                          double.parse(calculadora.calcularIMC(peso, altura));
                      var resultado = calculadora.resultadoIMC(imc);

                      await pessoaRepository.adicionar(Pessoa(
                          nomeController.text, altura, peso, imc, resultado));
                      nomeController.text = "";
                      pesoController.text = "";
                      alturaController.text = "";
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 69, 94, 207)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: TextLabel(texto: "Calcular"),
                    )),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: _pessoas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var pessoa = _pessoas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await pessoaRepository.remover(pessoa.id);
                    },
                    key: Key(pessoa.id),
                    child: ListTile(
                        title: TextLabel(texto: "Olá ${pessoa.nome}"),
                        subtitle: TextLabel(
                            texto:
                                "Seu IMC é de ${pessoa.imc} e seu resultado é: ${pessoa.resultado}")),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
