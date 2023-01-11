-- Criacao do banco e tabelas ----------------------------------------------------------------
create database desafioSQL;
use desafioSQL;
create schema inspecao;

create table inspecao.tipo_produto(
	cd_tipo_produto	int			primary	key	identity(1, 1)
,	nm_tipo_produto varchar(30)	not null
);

create table inspecao.inspetor(
	cd_matricula_inspetor int			primary key	identity(1, 1)
,	nm_inspetor			  varchar(40)   not null
);

create table inspecao.avaliacao(
	sg_avaliacao char(2)	 primary key
,	ds_avaliacao varchar(30) not null
);

create table inspecao.produto(
	cd_produto		  varchar(25)	primary key
,	cd_tipo_produto   int			not null
	foreign key(cd_tipo_produto) references inspecao.tipo_produto(cd_tipo_produto) 
		on delete cascade 
		on update cascade
);

create table inspecao.ficha_inspecao(
	cd_ficha			  int	primary key identity(1, 1)
,	dt_inspecao			  date	not null
,	cd_matricula_inspetor int	not null
,	foreign key(cd_matricula_inspetor) references inspecao.inspetor(cd_matricula_inspetor)
		on delete cascade
		on update cascade
);

create table inspecao.ficha_produto(
	cd_produto		  varchar(25)   not null
,	cd_ficha	      int			not null
,	sg_avaliacao	  char(2)		not null
,	hr_horario_inicio time			not null
,	hr_horario_fim	  time			not null
,	primary key (cd_produto, cd_ficha)
,	foreign key(sg_avaliacao) references inspecao.avaliacao(sg_avaliacao)
		on delete cascade
		on update cascade
,	foreign key(cd_produto) references inspecao.produto(cd_produto)
		on delete cascade
		on update cascade
, 
);

--------------------------------------------------------------------------------------------



-- Insercao de dados -----------------------------------------------------------------------
begin transaction;
insert into inspecao.avaliacao(sg_avaliacao, ds_avaliacao)
	values
	  ('OK', 'Liberado')
	, ('PL', 'Problema elétrico')
	, ('PT', 'Problema de pintura')
	, ('PE', 'Problema de estrutura')
	, ('TR', 'Todo rejeitado')

commit;

select * from inspecao.avaliacao

begin transaction
insert into inspecao.tipo_produto(nm_tipo_produto)
	values 
	  ('Geladeira')
	, ('Maquina de lavar')
	, ('Fogão')
	, ('Freezer')
	, ('Frigobar')
commit;

select * from inspecao.tipo_produto

begin transaction;
insert into inspecao.inspetor(nm_inspetor)
	values 
	  ('Trancoso da Silva')
	, ('Fernando Lázaro')
	, ('Gustavo Tanamati')
	, ('Romero')
commit;

select * from inspecao.inspetor

begin transaction;
	insert into inspecao.ficha_inspecao(dt_inspecao, cd_matricula_inspetor)
		values
		  ('2022-12-01', 1)
		, ('2022-12-01', 3)
		, ('2022-12-02', 1)
		, ('2022-12-16', 1)
		, ('2022-12-03', 2)
		, ('2022-12-04', 1)
		, ('2022-12-05', 2)
		, ('2022-12-06', 1)
		, ('2022-12-07', 4)
		, ('2022-12-08', 1)
		, ('2022-12-09', 1)
		, ('2022-12-10', 2)
		, ('2022-12-10', 1)
		, ('2022-12-11', 1)
		, ('2022-12-12', 1)
		, ('2022-12-13', 1)
		, ('2022-12-14', 1)
		, ('2022-12-15', 1)
		, ('2022-12-17', 1)
		, ('2022-12-18', 1)
		, ('2022-12-19', 1)
		, ('2022-12-20', 1)
		, ('2022-12-21', 1)
		, ('2022-12-22', 1)
commit;

select * from inspecao.ficha_inspecao

begin transaction;
insert into inspecao.produto(cd_produto, cd_tipo_produto)
	values
		('17.1.22', 4)
,		('20.4.22', 1)
,	    ('19.3.22', 2)
,	    ('16.3.22', 3)
,	    ('11.1.22', 4)
,	    ('18.5.22', 5)
,	    ('13.1.22', 4)
,	    ('26.4.22', 1)
,	    ('14.3.22', 2)
,	    ('70.3.22', 3)
,	    ('25.1.22', 4)
,	    ('32.5.22', 5)
,	    ('19.1.22', 4)
,	    ('46.4.22', 1)
,	    ('84.3.22', 2)
,	    ('29.3.22', 3)
,	    ('65.1.22', 4)
,	    ('62.1.22', 5)
,	    ('94.3.21', 2)
,	    ('01.3.21', 2)	
,	    ('45.3.22', 2)
,		('29.1.12', 1)
,		('30.1.12', 2)
,		('31.1.12', 3)
,		('32.1.12', 4)
,		('45.2.13', 5)
;
commit;

select * from inspecao.produto
select * from inspecao.ficha_produto

begin transaction;
	insert into inspecao.ficha_produto(cd_produto, cd_ficha, sg_avaliacao, hr_horario_inicio, hr_horario_fim)
		values
		 ('17.1.22',  1, 'PL', '09:05:00', '09:45:00')
,		 ('45.3.22',  1, 'TR', '10:00:00', '10:11:00')
,		 ('17.1.22',  2, 'OK', '09:10:00', '09:30:00')
,		 ('16.3.22',  3, 'PE', '09:03:00', '09:12:00')
,		 ('16.3.22',  4, 'OK', '09:12:00', '15:35:00')
,		 ('29.3.22',  5, 'OK', '09:03:00', '09:20:00')
,		 ('32.5.22',  6, 'PT', '12:05:00', '12:20:00')
,		 ('14.3.22',  7, 'OK', '11:05:00', '11:45:00')
,		 ('70.3.22',  8, 'TR', '10:00:00', '10:11:00')
,		 ('70.3.22',  9, 'OK', '09:10:00', '09:30:00')
,		 ('62.1.22', 10, 'OK', '09:02:00', '09:17:00')
,		 ('94.3.21', 11, 'PE', '11:12:00', '11:35:00')
,		 ('01.3.21', 12, 'OK', '09:03:00', '09:20:00')
,		 ('70.3.22', 13, 'PT', '12:05:00', '12:20:00')
,		 ('45.2.13', 14, 'OK', '08:45:00', '09:10:00')
,		 ('32.1.12', 15, 'OK', '09:02:00', '09:15:00')
,		 ('19.1.22', 16, 'PE', '10:01:00', '10:19:00')
,		 ('11.1.22', 17, 'TR', '09:20:00', '09:30:00')
,		 ('19.1.22', 18, 'OK', '09:03:00', '09:08:00')
commit;

---------------------------------------------------------------------------------------------------------------------



-- Questão 1 --------------------------------------------------------------------------------------------------------
SELECT DATEDIFF(MINUTE, fp.hr_horario_inicio, fp.hr_horario_fim) / 60.0 as HorasTrabalhadas
  FROM inspecao.ficha_inspecao as fi
  JOIN inspecao.inspetor       as i  on i.cd_matricula_inspetor = fi.cd_matricula_inspetor
  JOIN inspecao.ficha_produto  as fp on fp.cd_ficha             = fi.cd_ficha
 WHERE fi.dt_inspecao = '2022-12-16' 
   AND i.cd_matricula_inspetor = 1
-- R: O inspetor Trancoso da Silva fez 6.3 horas de trabalho no dia 



-- Questão 2 --------------------------------------------------------------------------------------------------------

SELECT SUM(DATEDIFF(MINUTE, fp.hr_horario_inicio, fp.hr_horario_fim)) /60.0 AS HorasTrabalhadas 
  FROM inspecao.ficha_inspecao AS fi
  JOIN inspecao.ficha_produto  AS fp ON fp.cd_ficha = fi.cd_ficha	
  JOIN inspecao.inspetor	   AS i  ON i.cd_matricula_inspetor = fi.cd_matricula_inspetor
 WHERE fi.dt_inspecao BETWEEN '2022-12-01' AND '2022-12-22' AND i.nm_inspetor = 'Trancoso da Silva'

-- R: Durante esse período, Trancoso trabalhou 9.8 horas



 -- Questão 3 -------------------------------------------------------------------------------------------------------
  SELECT fp.sg_avaliacao
       , count(fp.sg_avaliacao)  AS Quantidade
    FROM inspecao.ficha_inspecao AS fi
    JOIN inspecao.ficha_produto  AS fp ON fp.cd_ficha = fi.cd_ficha
   WHERE fi.dt_inspecao BETWEEN '2022-12-01' AND '2022-12-22' AND fp.sg_avaliacao != 'OK'
GROUP BY fp.sg_avaliacao
ORDER BY Quantidade DESC

-- R: O tipo de defeito mais recorrente é o de PE - Problema elétrico, seguido por PT, TR e PL



-- Questão 4 ---------------------------------------------------------------------------------------------------------
   SELECT i.nm_inspetor			  AS Inspetores, COUNT(1) as Avaliacoes_TR
	 FROM inspecao.inspetor		  AS i
LEFT JOIN inspecao.ficha_inspecao AS fi         ON fi.cd_matricula_inspetor = i.cd_matricula_inspetor
LEFT JOIN inspecao.ficha_produto  AS fp         ON fp.cd_ficha = fi.cd_ficha
    WHERE fp.sg_avaliacao = 'TR'
 GROUP BY i.nm_inspetor

-- R: O inspetor Trancoso foi o que mais atestaram produtos com avaliação TR (e por coincidência, único)



-- Questão 5 -------------------------------------------------------------------------------------
    SELECT	p.cd_produto		   AS produtos_retrabalhados
     FROM	inspecao.tipo_produto  AS tp
LEFT JOIN	inspecao.produto	   AS p  ON p.cd_tipo_produto = tp.cd_tipo_produto
LEFT JOIN	inspecao.ficha_produto AS fp ON fp.cd_produto     = p.cd_produto
    WHERE	fp.sg_avaliacao = 'TR'
       OR	fp.sg_avaliacao = 'PT'
       OR	fp.sg_avaliacao = 'PE'
       OR	fp.sg_avaliacao = 'EL'
      AND	fp.sg_avaliacao = 'OK'
 GROUP BY	p.cd_produto