SELECT
    t2.seller_id,
    date('2017-10-02') as data_safra, 
    max(date(t1.order_approved_at)),
    "1" as venda

FROM tb_orders as t1

LEFT JOIN tb_order_items as t2
on t1.order_id = t2.order_id

WHERE t1.order_status = 'delivered' AND
t1.order_approved_at BETWEEN date('2017-10-02') AND date('2017-10-02', '+3
 months')

GROUP BY t2.seller_id

