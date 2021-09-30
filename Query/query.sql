-- t3 Considera a data do fim da safra até o começo dos dados


SELECT 
    -- Relativo a dados de Idade do cliente
    t2.seller_id,
    t7.seller_state as estado_vendendor,
    CAST(t3.idade_base AS INTEGER) as idade_dias,

    -- Vendas e qualidade dos anuncios
    COUNT(DISTINCT t1.order_id) as qtde_vendas,
    COUNT(DISTINCT t2.product_id) as variedade_prod,
    COUNT(t2.product_id) as qtde_prod_vendidos,
    CAST(COUNT(t2.product_id)  as FLOAT)/ COUNT(DISTINCT t1.order_id)  as media_prod_vend_order,
    AVG(t6.product_photos_qty) as media_fotos,
    AVG(t6.product_description_lenght) as soma_char_desc,

    --Relativo a avaliação do vendendor
    AVG(t5.review_score) as avaliacao_safra,
    AVG(t3.avaliacao_acumulada) as avaliacao_acumulada,
    ROUND(AVG(t3.avaliacao_acumulada) - AVG(t5.review_score),2) as delta_review_idade_base, 

    --Relativo a datas
    CAST(julianday("2017-04-01") - julianday(max(t1.order_approved_at)) as INTEGER) as ultima_venda,
    COUNT( DISTINCT strftime("%m", t1.order_approved_at) ) as qtde_mes_ativacao,
    SUM(CASE WHEN julianday(t1.order_delivered_customer_date) > julianday(t1.order_estimated_delivery_date) THEN 1 ELSE 0 END) / CAST(COUNT(t1.order_id) AS FLOAT) as prop_atrasos,
    CAST(AVG(julianday(t1.order_estimated_delivery_date) - julianday(t1.order_approved_at)) as INTEGER) as media_prazo_entrega,

    -- Referente a receita
    sum(t2.price) as receita_total,
    sum(t2.price) / COUNT(DISTINCT( t2.order_id)) as ticket_medio,
    sum(t2.price) / COUNT(t2.product_id) as valor_medio_prod,
    sum(t2.price) / COUNT(DISTINCT(strftime("%m", t1.order_approved_at))) as total_mensal,
    sum(t2.freight_value) / COUNT(DISTINCT(t2.order_id)) as frete_medio,
    sum(t2.freight_value) / sum(t2.price)  as prop_valor_frete ,
    CAST((julianday("2017-04-01") - min(julianday(t1.order_approved_at))) / COUNT(DISTINCT t1.order_id)  AS INTEGER)
    as intervalo_pedidos_dias


FROM tb_orders as t1

LEFT JOIN tb_order_items as t2
ON t1.order_id = t2.order_id

    --Acrescentando Idade da pessoa na base de dados
LEFT JOIN(
    SELECT 
        t2.seller_id,
        max(julianday("2017-04-01") - julianday(t1.order_approved_at)) as idade_base,
        AVG(t3.review_score) as avaliacao_acumulada

    from tb_orders as t1
    LEFT JOIN tb_order_items as t2
    ON t1.order_id = t2.order_id

    LEFT JOIN tb_order_reviews as t3
    on t1.order_id = t3.order_id

    WHERE t1.order_approved_at < "2017-04-01"
    AND t1.order_status = 'delivered'

    GROUP BY t2.seller_id

) as t3
on t2.seller_id = t3.seller_id

--Acrescentando o Valor referente a compra
LEFT JOIN(
    SELECT
    t1.order_id,
    sum(t1.payment_value) as valor_compra

    FROM tb_order_payments as t1

    GROUP BY t1.order_id
) as t4
on t1.order_id = t4.order_id


LEFT JOIN tb_order_reviews as t5
on t1.order_id = t5.order_id

LEFT JOIN tb_products as t6
on t2.product_id = t6.product_id

LEFT JOIN tb_sellers as t7
on t2.seller_id = t7.seller_id


WHERE t1.order_approved_at BETWEEN  "2016-10-01" 
                            AND     "2017-04-01"
                            AND t1.order_status = 'delivered'

GROUP BY t2.seller_id

