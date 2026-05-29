import 'dart:io';

void main() {
  SistemaCuidapet sistema = SistemaCuidapet();
  sistema.iniciar();
}

class Cliente {
  String _nome;

  Cliente(this._nome);

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }
}

abstract class Item {
  int _codigo;
  String _nome;
  double _preco;

  Item(this._codigo, this._nome, this._preco);

  int get codigo => _codigo;
  String get nome => _nome;
  double get preco => _preco;

  void exibirDetalhes();
}

class Produto extends Item {
  Produto(int codigo, String nome, double preco) : super(codigo, nome, preco);

  @override
  void exibirDetalhes() {
    print("Código $codigo - $nome - R\$ ${preco.toStringAsFixed(2)}");
  }
}

class Servico extends Item {
  Servico(int codigo, String nome, double preco) : super(codigo, nome, preco);

  @override
  void exibirDetalhes() {
    print("Código $codigo - $nome - R\$ ${preco.toStringAsFixed(2)}");
  }
}

class Carrinho {
  List<Item> itens = [];

  void adicionarItem(Item item) {
    if (itens.length >= 3) {
      print("Seu carrinho já está cheio.");
    } else {
      itens.add(item);
      print("${item.nome} adicionado ao carrinho.");
    }
  }

  void listarCarrinho() {
    print("\n---- CARRINHO DE COMPRAS ----");

    if (itens.length == 0) {
      print("Carrinho vazio.");
    } else {
      for (var item in itens) {
        print("${item.nome} - R\$ ${item.preco.toStringAsFixed(2)}");
      }
    }
  }

  double calcularTotal() {
    double total = 0;

    for (var item in itens) {
      total += item.preco;
    }
    return total;
  }

  void limparCarrinho() {
    itens.clear();
  }
}

class SistemaCuidapet {
  int totalVendas = 0;
  double valorTotalVendas = 0;

  List<Produto> promocoes = [
    Produto(101, "Ração Royal Canin Indoor", 290.0),
    Produto(102, "Ração Royal Canin Sterilised", 492.0),
    Produto(103, "Bifinho Keldog", 23.92),
    Produto(104, "Fraldas Descartáveis", 38.61),
  ];

  List<Servico> servicos = [
    Servico(201, "Banho e tosa", 55.99),
    Servico(202, "Tosa higiênica", 12.99),
    Servico(203, "Hidratação dos pelos", 20.99),
  ];

  void iniciar() {
    while (true) {
      print("\nBem vindo ao autoatendimento do Cuidapet");
      print("Digite seu nome:");

      String nomeCliente = stdin.readLineSync()!;

      if (nomeCliente == "cuidapetrestrito") {
        double valorTotal = areaRestrita();
        totalVendas++;
        valorTotalVendas += valorTotal;
      } else {
        Cliente cliente = Cliente(nomeCliente);
        Carrinho carrinho = Carrinho();
        menuPrincipal(cliente, carrinho);
      }
    }
  }

  void menuPrincipal(Cliente cliente, Carrinho carrinho) {
    while (true) {
      exibirMenu();

      int opcao = int.parse(stdin.readLineSync()!);

      if (opcao == 0) {
        print("\nEncerrando sistema...");
        print("Quantidade de vendas: $totalVendas");
        print("Valor total das vendas: R\$ ${valorTotalVendas.toStringAsFixed(2)}");
        return;
      }

      switch (opcao) {
        case 1:
          menuPromocoes(carrinho);
          break;

        case 2:
          menuServicos(carrinho);
          break;

        case 3:
          carrinho.listarCarrinho();
          break;

        case 4:
          finalizarCompra(carrinho);
          break;

        default:
          print("\nOpção inválida.");
      }
    }
  }

  void exibirMenu() {
    print("\n---- MENU ----");
    print("1 – Ver promoções");
    print("2 – Solicitar serviço");
    print("3 – Listar carrinho de compra");
    print("4 – Finalizar carrinho de compra");
    print("0 – Sair");
    print("Digite sua opção desejada:");
  }

  void menuPromocoes(Carrinho carrinho) {
    while (true) {
      print("\n---- PROMOÇÕES ----");

      for (var produto in promocoes) {
        produto.exibirDetalhes();
      }
      print("\nDigite o código do produto");
      print("0 – Voltar");

      int cod = int.parse(stdin.readLineSync()!);

      if (cod == 0) {
        break;
      }

      int cont = 0;

      for (var produto in promocoes) {
        if (produto.codigo == cod) {
          carrinho.adicionarItem(produto);
          cont++;
        }
      }

      if (cont == 0) {
        print("Código inválido.");
      }
    }
  }

  void menuServicos(Carrinho carrinho) {
    while (true) {
      print("\n---- SERVIÇOS ----");

      for (var servico in servicos) {
        servico.exibirDetalhes();
      }

      print("\nDigite o código do serviço");
      print("0 – Voltar");

      int cod = int.parse(stdin.readLineSync()!);

      if (cod == 0) {
        break;
      }

      int cont = 0;

      for (var servico in servicos) {
        if (servico.codigo == cod) {
          carrinho.adicionarItem(servico);
          cont++;
        }
      }

      if (cont == 0) {
        print("Código inválido.");
      }
    }
  }

  void finalizarCompra(Carrinho carrinho) {
    double valorTotal = carrinho.calcularTotal();

    print("Forma de pagamento (dinheiro ou cartão):");
    String formaPagamento = stdin.readLineSync()!;

    if (formaPagamento.toLowerCase() == "dinheiro" || formaPagamento.toLowerCase() == "d") {
      valorTotal = valorTotal * 0.9;
    }
    print("Valor final a pagar: R\$ ${valorTotal}");
    totalVendas++;
    valorTotalVendas += valorTotal;
    carrinho.limparCarrinho();
  }

  double areaRestrita() {
    print("\n---- ÁREA RESTRITA ----");
    print("Digite o nome do cliente:");
    String nomeCliente = stdin.readLineSync()!;
    print("Digite o valor gasto na loja:");
    double valorTotal = double.parse(stdin.readLineSync()!);
    print("Forma de pagamento (D – dinheiro / C – cartão):");
    String formaPagamento = stdin.readLineSync()!;

    if (formaPagamento.toLowerCase() == "d" || formaPagamento.toLowerCase() == "dinheiro") {
      valorTotal = valorTotal * 0.9;
    }

    print("Cliente: $nomeCliente");
    print("Valor final a pagar: R\$ ${valorTotal}");
    return valorTotal;
  }
}