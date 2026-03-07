CREATE DATABASE fluxo_pessoas;

USE fluxo_pessoas;
create table endereco(
	id_endereco int primary key auto_increment,
	cep char(9) not null unique,
	numero int not null,
	complemento varchar(45),
	logradouro varchar(150) not null,
	bairro varchar(150) not null,
	cidade varchar(150) not null,
	estado char(2) not null,
	pais varchar(150) not null
);

create table empresa(
	id_empresa int primary key auto_increment,
	razao_social varchar(150) not null unique,
	nome_fantasia varchar(150) not null,
	cnpj varchar(14) not null unique,
	enderecoId int,
	-- enderecoId seria uma foreign key que ligaria a empresa com a table endereço
	contato varchar(16),
	id_usuario int,
	-- usuarioId seria uma foreign key que ligaria com o usuario
	data_criacao datetime default current_timestamp,
	data_atualizacao datetime default current_timestamp
) auto_increment = 1000;

create table usuario(
	id_usuario int primary key auto_increment,
	nome varchar(150) not null,
	email varchar(150) not null,
	senha_hash varchar(150) not null,
	empresa_id int,
	-- idEmpresa seria uma foreign key que ligaria com a empresa
	contato varchar(20),
	data_criacao datetime default current_timestamp,
	data_modificacao datetime default current_timestamp
) auto_increment = 1000;




 /*Tabelas dos eventos*/
CREATE TABLE bloco (
	id int primary key auto_increment,
    empresa_id int not null,
    -- empresa_id seria uma foreign key que ligaria o bloco com a table empresa
    nome_ambiente varchar(50) not null,
    tipo varchar(50) check(tipo in ('entrada', 'saida', 'ambiente')),
	data_criacao datetime default current_timestamp,
    data_atualizacao datetime default current_timestamp
);

create table sensor(
	id_sensor int primary key auto_increment,
	descricao varchar(150),
	bloco_id int,
	-- bloco_id seria uma foreign key que ligaria os sensores com os blocos
	data_criacao datetime default current_timestamp,
	data_atualizacao datetime default current_timestamp
);

create table sensor_evento(
	sensor_evento_id int primary key auto_increment,
	detectado tinyint(1) not null,
	duracao time,
	data_evento datetime default current_timestamp,
	data_atualizacao datetime default current_timestamp,
	sensor_id int
    -- sensor_id seria uma foreign key que ligaria o evento ao sensor ativou
);


create table alerta (
	id_alerta int primary key auto_increment,
	descricao varchar(150) not null,
	tipo varchar(40) check(tipo in('baixa movimentação', 'movimentação moderada', 'alta movimentação')),
	sensor_evento_id int,
	-- sensor_evento_id seria uma foreign key que ligaria o alerta ao sensor que ativou
	data_alerta datetime default current_timestamp,
	data_atualizacao datetime default current_timestamp
);


-- INSERT

	-- Usuario insert
insert into usuario (nome, email, senha_hash, empresa_id, contato)
values
('Carlos Mendes', 'carlos@techmonitor.com', 'hash123', 1000, '11999998888'),
('Ana Silva', 'ana@safesensors.com', 'hash456', 1001, '11988887777'),
('Lucas Pereira', 'lucas@datavision.com', 'hash789', 1002, '11977776666');

	-- Empresa insert
insert into endereco (cep, numero, complemento, logradouro, bairro, cidade, estado, pais)
values
('01234-567', 123, 'Loja 1', 'Rua Exemplo', 'Centro', 'São Paulo', 'SP', 'Brasil'),
('09876-543', 456, null, 'Avenida Teste', 'Vila Mariana', 'São Paulo', 'SP', 'Brasil'),
('04567-890', 789, 'Andar 2', 'Rua Fictícia', 'Moema', 'São Paulo', 'SP', 'Brasil');


	-- Bloco insert
insert into bloco (empresa_id, nome_ambiente, tipo)
values
(1000, 'Entrada Principal', 'entrada'),
(1000, 'Corredor Administrativo', 'ambiente'),
(1000, 'Saída de Emergência', 'saida'),
(1001, 'Entrada Visitantes', 'entrada'),
(1001, 'Sala de Reunião', 'ambiente'),
(1001, 'Saída Funcionários', 'saida'),
(1002, 'Portão Estacionamento', 'entrada'),
(1002, 'Área de Estoque', 'ambiente'),
(1002, 'Saída Carga', 'saida');

	-- Sensor insert
insert into sensor (descricao, bloco_id)
values
('Sensor corredor principal', 1),
('Sensor entrada prédio', 1),
('Sensor sala reunião', 2),
('Sensor estoque', 3),
('Sensor estacionamento', 3);

	-- Sensor evento insert
insert into sensor_evento (detectado, duracao, data_evento, sensor_id)
values
-- Sensor 1
(1, '00:03:15', '2026-10-11 13:00:00', 1),
(0, '00:00:20', '2026-10-11 13:00:20', 1),
(1, '00:02:40', '2026-10-11 13:03:00', 1),
(0, '00:00:15', '2026-10-11 13:03:15', 1),
-- Sensor 2
(1, '00:05:20', '2026-10-11 11:45:00', 2),
(0, '00:00:25', '2026-10-11 11:45:25', 2),
(1, '00:04:10', '2026-10-11 11:49:35', 2),
(0, '00:00:30', '2026-10-11 11:50:05', 2),
-- Sensor 3
(1, '00:02:30', '2026-10-11 13:20:00', 3),
(0, '00:00:20', '2026-10-11 13:22:30', 3),
(1, '00:06:10', '2026-10-11 13:28:40', 3),
(0, '00:00:30', '2026-10-11 13:29:10', 3),
-- Sensor 4
(1, '00:04:20', '2026-10-11 12:10:32', 4),
(0, '00:00:15', '2026-10-11 12:14:52', 4),
-- Sensor 5
(1, '00:03:30', '2026-10-11 14:20:15', 5),
(0, '00:00:20', '2026-10-11 14:23:45', 5);

	-- Alerta insert
insert into alerta (descricao, tipo, sensor_evento_id)
values
('Pouca movimentação detectada no corredor', 'baixa movimentação', 1),
('Movimentação normal na entrada', 'movimentação moderada', 2),
('Alta movimentação no estoque', 'alta movimentação', 4),
('Baixa movimentação estacionamento', 'baixa movimentação', 5);


-- QUERY

-- /* Mostra a atividade dos sensores durante uma hora do dia 11-10-2026 */
SELECT 
	data_evento,
    duracao,
    sensor_id AS numero_sensor,
    CASE
		WHEN detectado = 1 THEN 'Tem alguém'
		WHEN detectado = 0 THEN 'Não tem ninguém'
	END AS 'detecção'
FROM sensor_evento
WHERE 
	data_evento between "2026-10-11 13:00:00" and "2026-10-11 13:59:59" 
ORDER BY data_evento;

/* Mostrar quanto tempo cada sensor detectou presença durante o dia inteiro,
para saber as areas que tiveram mais movimento*/
select 
	data_evento, 
    duracao,
    sensor_id AS numero_sensor
from sensor_evento 
where 
	data_evento between '2026-10-11 00:00:00' and '2026-10-11 23:59:59' 
and 
	detectado = 1 
order by duracao; 







/* Mostrar quanto tempo cada sensor ficou sem detectar presença durante o dia inteiro,
para saber as areas que tiveram menos movimento*/
select 
	data_evento,
    duracao 
from sensor_evento 
where 
	data_evento between '2026-10-11 00:00:00' and '2026-10-11 23:59:59' 
and 
	detectado = 0
order by duracao;

/* Mostrar quanto tempo cada sensor detectou presença durante um periodo de tempo (como a hora do almoço)*/
select 
	data_evento, 
    duracao
from sensor_evento
where
	DATE(data_evento) = '2026-10-11'
and
    HOUR(data_evento) between '11:00:00' and '14:59:59'
and
	detectado = 1
order by duracao desc;

/* Mostra quais sensores eventos detectaram baixa movimentação */
select 
	descricao,
	tipo,
	sensor_evento_id,
    data_alerta
from alerta
where
	tipo = "baixa movimentação"
order by data_alerta desc;

-- Mostra o endereço de todas as unidades no estado de São Paulo
select * from endereco where cidade = 'SP';

-- Mostra nome, email e empresa de todos os usuários
select 
	nome, 
	email, 
	empresa_id 
FROM usuario;

-- Mostra cnpj, nome fantasia e endereço de todos os restaurantes cadastrados
select 
	cnpj, 
    nome_fantasia, 
    enderecoId 
FROM empresa;