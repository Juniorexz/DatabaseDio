create database ecommerce;
use ecommerce;

-- cliente
create table cliente(
	idcliente int auto_increment primary key,
    nome varchar(45),
    endereco varchar(45),
  	cpf char (11) not null,
    contato (11),
    cnpj varchar(18),
    constraint unique_cpf_cliente unique (cpf),
    constraint unique_cnpj_cliente unique (cnpj)
    );

desc cliente;

-- produto
create table produto(
	idproduto int auto_increment primary key,
    categoria varchar(45),
    descricao varchar(45),
	valor double
);

desc produto;

-- pagamento
create table pagamento(
	idpagamento int auto_increment primary key,
    pagamentocliente int,
    cartao varchar(45),
    bandeira varchar(45),
    numero varchar(45),
    constraint fk_pagamento_cliente foreign key (pagamentocliente) references cliente(idcliente)
);

desc pagamento;

-- entrega
create table entrega(
	identrega int auto_increment primary key,
    statusentrega bool,
    codigorastreio varchar(45),
    dataentrega date
);

desc entrega;

-- pedido
create table pedido(
	idpedido int auto_increment primary key,
    statuspedido bool default false,
    frete float,
    descricao varchar(45),
    constraint fk_entrega foreign key (idpedido) references entrega(identrega)
);

desc pedido;

-- estoque
create table estoque(
	idestoque int auto_increment primary key,
    local varchar(45)
);

desc estoque;

-- produtos em etoque
create table estoqueproduto(
	idproduto int primary key,
    idestoqueproduto int,
    quantidade float,
    constraint fk_estoque foreign key (idproduto) references produto(idproduto),
    constraint fk_produto_estoque foreign key (idestoqueproduto) references estoque(idestoque)
);

desc estoqueproduto;

-- fornecedor principal
create table fornecedor(
	idfornecedor int auto_increment primary key,
    razaosocial varchar(45),
    cpf char (11) not null,
    cnpj varchar(18),
    constraint unique_cpf_cliente unique (cpf),
    constraint unique_cnpj_cliente unique (cnpj)
);

desc fornecedor;

-- fornecedor terceiro
create table terceiro(
	idterceiro int auto_increment primary key,
	razaosocial varchar(45),
    localizacao varchar(45),
    cpf char (11) not null,
    cnpj varchar(18),
    constraint unique_cpf_cliente unique (cpf),
    constraint unique_cnpj_cliente unique (cnpj)
);

desc terceiro;

-- pedido de produto
create table pedidoproduto(
	idpedido int,
    idproduto int,
    quantidade float default 1,
    constraint fk_pedido foreign key (idpedido) references terceiro(idterceiro),
    constraint fk_produto foreign key (idproduto) references produto(idproduto)
);

desc pedidoproduto;

-- pedido de produto para fornecedor principal
create table pedidofornecedor(
	idcomprafornecedor int,
    idfornecedorpedido int,
    quantidade float default 1,
    constraint fk_pedido_forncedor foreign key (idcomprafornecedor) references fornecedor(idfornecedor),
    constraint fk_fornecedor_pedido foreign key (idfornecedorpedido) references pedido(idpedido)
);

desc pedidofornecedor;

-- produtos em estoque fornecedor principal (verifica se o fornecedor tem o produto que o cliente deseja)
create table estoquefornecedor(
	idestoquefornecedor int,
    idprodutofornecedor int,
    constraint fk_estoque_fornecedor foreign key (idestoquefornecedor) references fornecedor(idfornecedor),
    constraint fk_produtos_fornecedor foreign key (idprodutofornecedor) references produto(idproduto)
);

desc estoquefornecedor;

-- produtos em estoque fornecedor terceiro (verifica se o fornecedor tem o produto que o cliente deseja)

create table estoqueterceiro(
	idprodutosestoque int,
    idpofornecedor int,
    constraint fk_produtos_estoque foreign key (idprodutosestoque) references produto(idproduto),
    constraint fk_po_fornecedor foreign key (idpofornecedor) references terceiro(idterceiro)
);

desc estoqueterceiro;
