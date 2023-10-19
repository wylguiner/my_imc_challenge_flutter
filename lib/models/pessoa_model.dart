import 'package:flutter/material.dart';

class Pessoa {
  final String _id = UniqueKey().toString();
  String _nome = "";
  double _altura = 0;
  double _peso = 0;
  double _imc = 0;
  String _resultado = "";

  Pessoa(this._nome, this._altura, this._peso, this._imc, this._resultado);

  String get id => _id;

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get imc => _imc;

  set imc(double imc) {
    _imc = imc;
  }

  String get resultado => _resultado;

  set resultado(String resultado) {
    _resultado = resultado;
  }
}
