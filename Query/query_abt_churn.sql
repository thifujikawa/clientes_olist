SELECT 
    -- Relativo a dados do cliente
    -- Data related with age of the seller on the Database
    COALESCE(t8.venda,0) as flag_compra,  -- Variavel resposta
    '{safra}' as data_lim_safra,
    t2.seller_id,
    t7.seller_state as estado,  -- seller_state
    CAST(t3.idade_base AS INTEGER) as idade_dias, -- age_days

    -- Vendas e qualidade dos anuncios
    -- Sales and ad quality
    COUNT(DISTINCT t1.order_id) as qtde_vendas, -- sales_qty
    COUNT(DISTINCT t2.product_id) as variedade_prod, -- prod_vblty
    COUNT(t2.product_id) as qtde_prod_vendidos, -- prod_qty_sold
    CAST(COUNT(t2.product_id)  as FLOAT)/ COUNT(DISTINCT t1.order_id)  as media_prod_vend_order, -- prod_avg_sold_order
    AVG(t6.product_photos_qty) as media_fotos, -- photos_avg
    AVG(t6.product_description_lenght) as media_letras_desc, --char_desc_avg

    --Relativo a avaliação do vendendor
    --Related to the seller score rate 
    AVG(t5.review_score) as avaliacao_safra, --harvest_score_rate
    AVG(t3.avaliacao_acumulada) as avaliacao_acumulada, -- acc_harvest_score_rate
    ROUND(AVG(t3.avaliacao_acumulada) - AVG(t5.review_score),2) as delta_avaliacao_idade_base, --delta_btw_score_rates


-- We stopped here 
    --Relativo a datas
    -- Related with sales dates
    CAST(julianday('{safra}') - julianday(max(t1.order_approved_at)) as INTEGER) as ultima_venda,--last sell
    COUNT( DISTINCT strftime("%m", t1.order_approved_at) ) as qtde_mes_ativos, --qty_month_activation
    SUM(CASE WHEN julianday(t1.order_delivered_customer_date) > julianday(t1.order_estimated_delivery_date) THEN 1 ELSE 0 END) / CAST(COUNT(t1.order_id) AS FLOAT) as prop_atrasos, --late_proportion
    CAST(AVG(julianday(t1.order_estimated_delivery_date) - julianday(t1.order_approved_at)) as INTEGER) as media_prazo_entrega,--avg_days_delivered

    -- Referente a receita
    -- Related with the reciept
    sum(t2.price) as receita_total, -- total revenue
    sum(t2.price) / COUNT(DISTINCT( t2.order_id)) as ticket_medio, --ticket_medium
    sum(t2.price) / COUNT(t2.product_id) as valor_medio_prod, -- avg_product_price
    sum(t2.price) / COUNT(DISTINCT(strftime("%m", t1.order_approved_at))) as total_mensal, --total_month
    sum(t2.freight_value) / COUNT(DISTINCT(t2.order_id)) as frete_medio,--carrier_avg
    sum(t2.freight_value) / sum(t2.price)  as prop_valor_frete ,--prop_avg_carrier_price
    CAST((julianday('{safra}') - min(julianday(t1.order_approved_at))) / COUNT(DISTINCT t1.order_id)  AS INTERGER)
    as intervalo_pedidos_dias -- gap_btw_orders


FROM tb_orders as t1

LEFT JOIN tb_order_items as t2
ON t1.order_id = t2.order_id

    --Acrescentando Idade da pessoa na base de dados
    --Adding the age of the seller on the database
LEFT JOIN(
    SELECT 
        t2.seller_id,
        max(julianday('{safra}') - julianday(t1.order_approved_at)) as idade_base, --age_days since born
        AVG(t3.review_score) as avaliacao_acumulada --acc_score_rates

    from tb_orders as t1
    LEFT JOIN tb_order_items as t2
    ON t1.order_id = t2.order_id

    LEFT JOIN tb_order_reviews as t3
    on t1.order_id = t3.order_id

    WHERE t1.order_approved_at < '{safra}'
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

-- Variavel Resposta
LEFT JOIN (
    SELECT
    t2.seller_id,
    '{safra}' as data_safra, 
    max(date(t1.order_approved_at)) as dt_venda_var,
    "1" as venda

FROM tb_orders as t1

LEFT JOIN tb_order_items as t2
on t1.order_id = t2.order_id

WHERE t1.order_status = 'delivered' AND
t1.order_approved_at BETWEEN date('{safra}') AND date('{safra}', '+3
 months')

GROUP BY t2.seller_id) as t8
on t2.seller_id = t8.seller_id


WHERE t1.order_approved_at BETWEEN  date('{safra}', '-6 months')
                            AND     '{safra}'
                            AND t1.order_status = 'delivered'

GROUP BY t2.seller_id