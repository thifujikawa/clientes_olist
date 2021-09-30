
SELECT *
from tb_book_sellers



/*  SELECT 
    t1.product_id ,
    t1.product_category_name,
   CASE WHEN t1.product_category_name IN ('artes', 'artes_e_artesanato') THEN 'artes_artesanato'
        WHEN t1.product_category_name IN ('artigos_de_festas', 'artigos_de_natal') THEN 'artigos_de_festas'
        WHEN t1.product_category_name IN ('alimentos', 'alimentos_bebidas','bebidas') THEN 'alimentos_bebidas'
        WHEN t1.product_category_name IN ('casa_conforto', 'casa_conforto_2') THEN 'casa_conforto'
        WHEN t1.product_category_name IN ('cds_dvds_musicais', 'cine_foto', 'dvds_blu_ray' ) THEN 'midias'
        WHEN t1.product_category_name IN ('construcao_ferramentas_construcao', 'construcao_ferramentas_ferramentas',
        'construcao_ferramentas_iluminacao','construcao_ferramentas_jardim', 'construcao_ferramentas_seguranca','ferramentas_jardim') THEN 'construcao_ferramentas'
        WHEN t1.product_category_name IN ('eletrodomesticos', 'eletrodomesticos_2') THEN 'eletrodomesticos'
        WHEN t1.product_category_name IN ('fashion_bolsas_e_acessorios','fashion_calcados','fashion_esporte',
        'fashion_roupa_feminina','fashion_roupa_infanto_juvenil','fashion_roupa_masculina' 
        ,'fashion_underwear_e_moda_praia') THEN'fashion'
        WHEN t1.product_category_name IN ('fraldas_higiene', 'bebes') THEN 'bebes'
        WHEN t1.product_category_name IN ('informatica_acessorios', 'pc_gamer', 'pcs') THEN 'pcs'
        WHEN t1.product_category_name IN ('instrumentos_musicais', 'audio', 'musica') THEN 'audio'
        WHEN t1.product_category_name IN ('livros_importados', 'livros_interesse_geral', 'livros_tecnicos') THEN 'livros'        
        WHEN t1.product_category_name IN ('moveis_colchao_e_estofado','moveis_cozinha_area_de_servico_jantar_e_jardim','moveis_decoracao',
        'moveis_escritorio','moveis_quarto','moveis_sala') THEN'moveis'
        WHEN t1.product_category_name IN ('beleza_saude','perfumaria') THEN 'beleza_saude_perfumaria'
        WHEN t1.product_category_name IN ('telefonia','telefonia_fixa') THEN 'telefonia'
        WHEN t1.product_category_name IN ('eletronicos','eletroportateis','tablets_impressao_imagem') THEN 'eletronicos'


   ELSE product_category_name
   END as categorias_resumidas

from tb_products t1

GROUP BY t1.product_category_name  */




--Qual o valor total de receita gerado por cliente em cada estado?

-- Considere apenas pedidos entregues



with tb_maiores_produtos as (
SELECT
     COUNT(t1.product_id) as aparicoes,
     t1.product_id,
     t1.seller_id,
     t2.product_category_name as categoria,
     ROW_NUMBER() OVER(PARTITION BY t1.seller_id ORDER BY COUNT(t1.product_id) desc) as indexado
     

FROM tb_order_items as t1

LEFT JOIN tb_products as t2
on t1.product_id = t2.product_id


GROUP BY t1.product_id,t1.seller_id)

SELECT
     t1.seller_id,
     t1.product_id,
     t1.categoria

FROM tb_maiores_produtos as t1
WHERE indexado = 1


SELECT *
from tb_order_items as t1
where t1.seller_id = '1d29dfba02015238dfbe2449a5eaa361'
ORDER BY t1.shipping_limit_date



SELECT *

FROM tb_churn_score
