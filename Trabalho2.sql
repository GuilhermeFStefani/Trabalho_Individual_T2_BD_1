--PROBLEMA 1
SELECT DISTINCT
    PED.num_pedido,
    PED.data_emissao,
    CLIENTES.nome AS nome_cliente,
    IP.quantidade,
    IP.valor_unitario,
    CA.nome AS nome_categoria,
    PRODUTOS.nome AS nome_produto,
    PRODUTOS.preco

FROM
    ARRUDA.pessoas_fisicas, ARRUDA.clientes CLIENTES 
    INNER JOIN ARRUDA.pedidos PED ON CLIENTES.cod_cliente = PED.cod_cliente
    INNER JOIN ARRUDA.pessoas_fisicas COD ON CLIENTES.cod_cliente = COD.cod_cliente
    INNER JOIN ARRUDA.itens_pedidos IP ON PED.num_pedido = IP.num_pedido
    INNER JOIN ARRUDA.produtos PRODUTOS ON IP.cod_produto = PRODUTOS.cod_produto
    INNER JOIN ARRUDA.categorias CA ON PRODUTOS.cod_categoria = CA.cod_categoria

WHERE
    to_char(PED.data_emissao, 'yyyy') = '2019' AND (COD.genero) = 'F'

ORDER BY
    PED.data_emissao DESC,
    CLIENTES.nome; 



--PROBLEMA 2
SELECT DISTINCT
    CLIENTES.nome,
    COD.data_nascimento,
    FLOOR(months_between(SYSDATE,COD.data_nascimento)/12) AS idade,
    LG.rua,
    LG.numero,
    LG.complemento,
    LG.cep,
    CIDADE.nome AS cidade,
    ESTADO.nome AS estado
    
FROM
    ARRUDA.pessoas_fisicas, ARRUDA.clientes CLIENTES
    LEFT OUTER JOIN ARRUDA.enderecos LG ON CLIENTES.cod_cliente = LG.cod_cliente
    INNER JOIN ARRUDA.pessoas_fisicas COD ON CLIENTES.cod_cliente = COD.cod_cliente
    INNER JOIN ARRUDA.cidades CIDADE ON LG.cod_cidade = CIDADE.cod_cidade
    INNER JOIN ARRUDA.estados ESTADO ON CIDADE.uf = ESTADO.uf
    
ORDER BY
    CLIENTES.nome ASC,
    COD.data_nascimento DESC;
          
               
--PROBLEMA 3
--IMPORTADOS PREMIUM
SELECT DISTINCT
    PRODUTOS.nome,
    CA.nome as nome_categoria,
    PRODUTOS.preco,
    CAST(PRODUTOS.importado as VARCHAR(11)) as Imp_Premium 
    --PRODUTOS.importado as importado_status
FROM
    arruda.pedidos PEDIDOS
    inner join arruda.itens_pedidos IP on PEDIDOS.num_pedido = IP.num_pedido
    inner join arruda.produtos PRODUTOS on IP.cod_produto = PRODUTOS.cod_produto
    inner join arruda.categorias CA on PRODUTOS.cod_categoria = CA.cod_categoria
WHERE
    (PRODUTOS.importado = 'S' and PRODUTOS.preco > 100); 
    
--IMPORTADO (<100)
SELECT DISTINCT
    PRODUTOS.nome,
    CA.nome as nome_categoria,
    PRODUTOS.preco,
    CAST(PRODUTOS.importado as VARCHAR(9)) as importado
FROM
    arruda.pedidos PEDIDOS
    inner join arruda.itens_pedidos IP on PEDIDOS.num_pedido = IP.num_pedido
    inner join arruda.produtos PRODUTOS on IP.cod_produto = PRODUTOS.cod_produto
    inner join arruda.categorias CA on PRODUTOS.cod_categoria = CA.cod_categoria
WHERE
    (PRODUTOS.importado = 'S' and PRODUTOS.preco <= 100);
    
--NACIONAL  
 SELECT DISTINCT
    PRODUTOS.nome,
    CA.nome as nome_categoria,
    PRODUTOS.preco,
    CAST(PRODUTOS.importado as VARCHAR(9)) as nacional
FROM
    arruda.pedidos PEDIDOS
    inner join arruda.itens_pedidos IP on PEDIDOS.num_pedido = IP.num_pedido
    inner join arruda.produtos PRODUTOS on IP.cod_produto = PRODUTOS.cod_produto
    inner join arruda.categorias CA on PRODUTOS.cod_categoria = CA.cod_categoria
WHERE
    (PRODUTOS.importado = 'N');


     
--PROBLEMA 4
CREATE TABLE PECAS (
    cod_pecas NUMBER(6) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    preco NUMBER(8,2) NOT NULL,
    peso NUMBER(5) NOT NULL,
    quantidade NUMBER(6) NOT NULL,
    CONSTRAINT pk_pecas PRIMARY KEY(cod_pecas));



--PROBLEMA 5
CREATE TABLE MOVIMENTO_PECAS (
    id_movimento NUMBER(8) NOT NULL,
    data_mov DATE NOT NULL,
    quantidade NUMBER(6) NOT NULL,
    tipo CHAR(1) NOT NULL, --E ou S
    cod_pecas NUMBER(6) NOT NULL);

--PROBLEMA 6 A
insert into pecas(cod_pecas,nome,preco,peso,quantidade)
values (123456,'bobina','1500','600','800');
--resultado: 1 linha inserido.
insert into pecas(cod_pecas,nome,preco,peso,quantidade)
values (234567,'helice','750','800','29');
--resultado: 1 linha inserido.
    
--PROBLEMA 6 B1
insert into movimento_pecas(id_movimento,data_mov,quantidade,tipo,cod_pecas)
values(12345678,'01/07/2021',5,'E',123456);
insert into movimento_pecas(id_movimento,data_mov,quantidade,tipo,cod_pecas)
values(23456789,'02/07/2021',10,'E',123456);

insert into movimento_pecas(id_movimento,data_mov,quantidade,tipo,cod_pecas)
values(34567891,'03/07/2021',1,'E',234567);
insert into movimento_pecas(id_movimento,data_mov,quantidade,tipo,cod_pecas)
values(45678912,'04/07/2021',1,'E',234567);

--PROBLEMA 6 B2 

insert into movimento_pecas(id_movimento,data_mov,quantidade,tipo,cod_pecas)
values(98765432,'05/07/2021',2,'S',123456);
insert into movimento_pecas(id_movimento,data_mov,quantidade,tipo,cod_pecas)
values(87654321,'06/07/2021',1,'S',123456);

insert into movimento_pecas(id_movimento,data_mov,quantidade,tipo,cod_pecas)
values(76543218,'07/07/2021',6,'S',234567);
insert into movimento_pecas(id_movimento,data_mov,quantidade,tipo,cod_pecas)
values(65432198,'08/07/2021',8,'S',234567);

-- PROBLEMA 6 C

update movimento_pecas
set quantidade = '7'
where id_movimento = 76543218;

--PROBLEMA 6 K
delete from pecas 
where quantidade = (select min(pecas.quantidade) from pecas) and rownum = 1;

select * from pecas;
    

    