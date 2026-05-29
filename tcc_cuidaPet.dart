import 'dart:io';

void main() {

  int totalVendas = 0;
  double valorTotalVendas = 0;

  while(true){
    print("\nBem vindo ao autoatendimento do Cuidapet");
    print("Digite seu nome:");
    String nomeCliente = stdin.readLineSync()!;

    if(nomeCliente == "cuidapetrestrito"){
      double valorTotal = areaRestrita();
      totalVendas++;
      valorTotalVendas += valorTotal;
    }else{
      List carrinho = [];
      List valores = [];

      while(true){
        exibirMenu();
        int opcao = int.parse(stdin.readLineSync()!);

        if(opcao == 0){
          print("\nEncerrando sistema...");
          print("Quantidade de vendas: $totalVendas");
          print("Valor total das vendas: R\$ $valorTotalVendas");
          break;
        }

        switch(opcao){
          case 1:
            menuPromocoes(carrinho, valores);
            break;
          case 2:
            menuServicos(carrinho, valores);
            break;
          case 3:
            listarCarrinho(carrinho, valores);
            break;
          case 4:
            double valorTotal = calcularTotal(valores);
            print("Forma de pagamento (dinheiro ou cartão):");
            String formaPagamento = stdin.readLineSync()!;

            if(formaPagamento == "dinheiro" || formaPagamento == "Dinheiro"){
              valorTotal = valorTotal * 0.9;
            }
            print("Valor final a pagar: R\$ $valorTotal");
            totalVendas++;
            valorTotalVendas += valorTotal;
            carrinho.clear();
            valores.clear();
            break;
          default:
            print("\nOpção inválida.");
        }
      }
      break;
    }
  }
}

void exibirMenu(){
  print("\n---- MENU ----");
  print("\n1 – Ver promoções");
  print("2 – Solicitar serviço");
  print("3 – Listar carrinho de compra");
  print("4 - Finalizar carrinho de compra");
  print("0 - Sair");
  print("Digite sua opção desejada:");
}

double areaRestrita(){
  print("\n---- ÁREA RESTRITA ----");
  print("Digite o nome do cliente:");
  String nomeCliente = stdin.readLineSync()!;
  print("Digite o valor gasto na loja:");
  double valorTotal = double.parse(stdin.readLineSync()!);
  print("Forma de pagamento (D – dinheiro / C – cartão):");
  String formaPagamento = stdin.readLineSync()!;

  if(formaPagamento == "D" || formaPagamento == "d"){
    valorTotal = valorTotal * 0.9;
  }
  print("Valor final a pagar: R\$ $valorTotal");
  return valorTotal;
}

void menuPromocoes(List carrinho, List valores){
  while(true){
    print("\n---- ITENS ----");
    print("\nCódigo 101 - Ração Royal Canin Indoor Para Cães Adultos De Porte Mini De Ambientes Internos 7,5kg na promoção pelo preço de R\$ 290,00.");
    print("Código 102 - Ração Royal Canin Sterilised para Gatos Adultos Castrados e com o valor promocional de R\$ 492,00.");
    print("Código 103 - Bifinho Keldog para Cães Porte Pequeno Sabor Carne e Cereais por R\$23,92.");
    print("Código 104 - Fraldas Descartáveis Super Secão para Cães Machos com 12 Unidades R\$ 38,61.");
    print("8 – Adicionar ao carrinho de compras.");
    print("0 – Voltar.");
    int opcao = int.parse(stdin.readLineSync()!);

    if(opcao == 0){
      break;
    }

    if(opcao == 8){
      if(carrinho.length >= 3){
        print("Seu carrinho de compras já está cheio.");
      }else{
        print("Digite o código do produto:");
        int codigoProduto = int.parse(stdin.readLineSync()!);

        if(codigoProduto == 101){
          carrinho.add("Ração Royal Canin Indoor");
          valores.add(290.0);
        }else if(codigoProduto == 102){
          carrinho.add("Ração Royal Canin Sterilised");
          valores.add(492.0);
        }else if(codigoProduto == 103){
          carrinho.add("Bifinho Keldog");
          valores.add(23.92);
        }else if(codigoProduto == 104){
          carrinho.add("Fraldas Descartáveis");
          valores.add(38.61);
        }else{
          print("Código inválido.");
        }
      }
    }else{
      print("Opção inválida.");
    }
  }
}

void menuServicos(List carrinho, List valores){
  while(true){
    print("\n---- SERVIÇOS ----");
    print("\nCódigo 201 - Banho e tosa - R\$ 55,99.");
    print("Código 202 - Tosa higienica -R\$ 12,99.");
    print("Código 203 - Hidratação dos pelos - R\$ 20,99.");
    print("8 – Adicionar ao carrinho de compras.");
    print("0 – Voltar.");
    int opcao = int.parse(stdin.readLineSync()!);

    if(opcao == 0){
      break;
    }

    if(opcao == 8){
      if(carrinho.length >= 3){
        print("Seu carrinho de compras já está cheio.");
      }else{
        print("Digite o código do serviço:");
        int codigoServico = int.parse(stdin.readLineSync()!);

        if(codigoServico == 201){
          carrinho.add("Banho e tosa");
          valores.add(55.99);
        }else if(codigoServico == 202){
          carrinho.add("Tosa higienica");
          valores.add(12.99);
        }else if(codigoServico == 203){
          carrinho.add("Hidratação dos pelos");
          valores.add(20.99);
        }else{
          print("Código inválido.");
        }
      }
    }else{
      print("Opção inválida.");
    }
  }
}

void listarCarrinho(List carrinho, List valores){
  print("\n---- CARRINHO DE COMPRA ----");

  if(carrinho.length == 0){
    print("Carrinho vazio.");
  }else{
    for(int i = 0; i < carrinho.length; i = i + 1){
      print("${carrinho[i]} - R\$ ${valores[i]}");
    }
  }
}

double calcularTotal(List valores){
  double valorTotal = 0;

  for(int i = 0; i < valores.length; i = i + 1){
    valorTotal += valores[i];
  }
  return valorTotal;
}