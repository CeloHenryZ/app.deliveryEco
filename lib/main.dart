import 'dart:io';
import 'dart:typed_data';

import 'package:delivery_eco/app/providers/ponto_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:delivery_eco/app/model/produto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:delivery_eco/app/cadastro/cadastro_dados_endere%C3%A7o.dart';
import 'package:delivery_eco/app/cadastro/cadastro_dados_pagador.dart';
import 'package:delivery_eco/app/cadastro/cadastro_dados_pessoais.dart';
import 'package:delivery_eco/app/providers/campanhas_list.dart';
import 'package:delivery_eco/app/providers/categorias_list.dart';
import 'package:delivery_eco/app/providers/itens_pedido_list.dart';
import 'package:delivery_eco/app/providers/produtos_list.dart';
import 'package:delivery_eco/app/providers/user_data_provider.dart';
import 'package:delivery_eco/app/resumo_pedido/resumo_pedido.dart';
import 'package:provider/provider.dart';
import 'package:delivery_eco/app/carrinho/carrinho_view.dart';
import '/app/compra/retirada_view.dart';
import 'package:delivery_eco/app/dados_usuario/dados_usuario_view.dart';
import 'package:delivery_eco/app/endereco_usuario/cadastrar_endereco_usuario_view.dart';
import 'package:delivery_eco/app/endereco_usuario/cadastro_novo_endereco.dart';
import 'package:delivery_eco/app/endereco_usuario/editar_endereco_usuario_view.dart';
import 'package:delivery_eco/app/home/home_view.dart';
import 'package:delivery_eco/app/login/login_view.dart';
import 'package:delivery_eco/app/compra/finalizar_compra.dart';
import 'package:delivery_eco/app/pesquisa/pesquisar_view.dart';
import '/app/produto/descricaoProduto_view.dart';
import 'package:delivery_eco/app/pdf/pdf_view.dart';
import 'package:delivery_eco/app/produto/produtosPage_view.dart';
import 'package:delivery_eco/app/providers/bairros_list.dart';
import 'package:delivery_eco/app/registro_usuario/registrar_usuario.dart';
import 'package:delivery_eco/app/usuario/editar_dados_usuario_view.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListaItensPedido()),
        ChangeNotifierProvider(create: (context) => ProdutosList()),
        ChangeNotifierProvider(create: (context) => CategoriasList()),
        ChangeNotifierProvider(create: (context) => CampanhasList()),
        ChangeNotifierProvider(create: (context) => BairrosList()),
        ChangeNotifierProvider(create: (context) => UserDataList()),
        ChangeNotifierProvider(create: (context) => PontoConfigProvider())
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => HomeView(),
          '/login': (context) => LoginView(),
          '/carrinho': (context) => Carrinho(),
          '/retirada': (context) => RetiradaView(),
          '/finalizarCompra': (context) => FinalizarCompra(),
          '/navegacaoProdutos': (context) => NavegacaoProdutosView(),
          '/pesquisaProdutos': (context) => TelaPesquisaView(),
          '/cadastro': (context) => CadastroView(),
          '/cadastroEndereco': (context) => CadastroEnderecoView(),
          '/cadastroPagador': (context) => CadastroPagadorView(),
          '/resumoPedido': (context) => ResumoPedido(),
          '/registrarUsuario': (context) => RegistrarUsuarioView(),
          '/registroEdereco': (context) => CadastrarEnderecoUsuarioView(),
          '/dadosUsuario': (context) => DadosUsuarioView(),
          '/editarDadosUsuario': (context) => EditarDadosUsuario(),
          '/adicionarEndereco': (context) => CadastroNovoEndereco()
        },
        initialRoute: '/home',
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
