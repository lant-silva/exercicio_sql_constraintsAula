-- botão de emergencia
use master
go
drop database livraria

CREATE DATABASE livraria
GO
USE livraria

-- Tabelas

CREATE TABLE autor(
id_autor		INT				NOT NULL	IDENTITY(2351, 1),
nome			VARCHAR(100)	NOT NULL	UNIQUE,
data_nasc		DATE			NOT NULL,
pais_nasc		VARCHAR(50)		NOT NULL	CHECK((pais_nasc = 'Brasil') OR (pais_nasc = 'Estados Unidos') OR (pais_nasc = 'Inglaterra') OR (pais_nasc = 'Alemanha')),
biografia		VARCHAR(255)	NOT NULL
PRIMARY KEY (id_autor)
)

CREATE TABLE livro(
codigo		INT				NOT NULL	IDENTITY(100001, 100),
nome		VARCHAR(200)	NOT NULL,
lingua		VARCHAR(10)		NOT NULL	DEFAULT('PT-BR'),
ano			INT				NOT NULL	CHECK(ano > 1990)
PRIMARY KEY (codigo)
)

CREATE TABLE livro_autor(
livro_codigo	INT		NOT NULL,
id_autor		INT		NOT NULL
FOREIGN KEY	(livro_codigo) REFERENCES livro(codigo),
FOREIGN KEY (id_autor)	REFERENCES	autor(id_autor)
)

CREATE TABLE edicao(
isbn			CHAR(13)		NOT NULL	CHECK(LEN(isbn) = 13),
preco			DECIMAL(4,2)	NOT NULL	CHECK(preco > 0),
ano				INT				NOT NULL	CHECK(ano > 1993),
numero_paginas	INT				NOT NULL	CHECK(numero_paginas > 15),
qtd_estoque		INT				NOT NULL
PRIMARY KEY (isbn)
)

CREATE TABLE editora(
id_editora				INT				NOT NULL	IDENTITY(491, 16),
nome					VARCHAR(70)		NOT NULL	UNIQUE,
telefone				VARCHAR(11)		NOT NULL	CHECK(LEN(telefone) >= 10),
logradouro_endereco		VARCHAR(200)	NOT NULL,
numero_endereco			INT				NOT NULL	CHECK(numero_endereco > 0),
cep_endereco			CHAR(8)			NOT NULL	CHECK(LEN(cep_endereco) = 8),
complemento_endereco	VARCHAR(255)	NOT NULL
PRIMARY KEY (id_editora)
)

CREATE TABLE editora_edicao_livro(
id_editora			INT			NOT NULL,
edicao_isbn			CHAR(13)	NOT NULL,
livro_codigo		INT			NOT NULL
FOREIGN KEY (id_editora) REFERENCES editora(id_editora),
FOREIGN KEY (edicao_isbn) REFERENCES edicao(isbn),
FOREIGN KEY (livro_codigo) REFERENCES livro(codigo)
)