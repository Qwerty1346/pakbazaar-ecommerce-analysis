#"Which cities are driving our revenue? Where should we focus our marketing spend?"
# Write a query that ranks every city by total revenue from delivered orders only.
SELECT delivery_city,
SUM(unit_price * quantity) total_revenue,
COUNT(DISTINCT ord.order_id) total_orders,
ROUND( 
SUM(unit_price * quantity) * 100.0 /
SUM(SUM(unit_price * quantity)) OVER(),2
) rev_share,
RANK() OVER( ORDER BY SUM(unit_price * quantity)  DESC ) rnk
FROM orders ord
JOIN order_items oi
	ON ord.order_id= oi.order_id
WHERE ord.status = 'Delivered'
GROUP BY delivery_city;
#"Which product categories are most profitable? Where are we losing margin?"
SELECT category,
COUNT(DISTINCT product_name) total_products,
SUM(unit_price * quantity) total_revenue,
ROUND(
SUM(unit_price * quantity) * 100.0 /
SUM(SUM(unit_price * quantity)) OVER(),2
) rev_share,
SUM( quantity *( unit_price - cost_price) ) gross_profit,
ROUND(
SUM(quantity *(unit_price - cost_price) ) *100.0/
SUM(quantity* unit_price)
) gross_margin,
CASE 
	WHEN ROUND(
SUM(quantity *(unit_price - cost_price) ) *100.0/
SUM(quantity* unit_price)
)  > 50 THEN 'Excellent Margin'
    WHEN ROUND(
SUM(quantity *(unit_price - cost_price) ) *100.0/
SUM(quantity* unit_price)
)BETWEEN 30 and 50 THEN 'Healthy'
    ELSE 'Poor Margin'
END label,
RANK()OVER(ORDER BY SUM(unit_price * quantity) DESC) rnk
FROM products pro
JOIN order_items oi
	ON pro.product_id = oi.product_id
JOIN orders ord
	ON ord.order_id=oi.order_id
WHERE ord.status = 'Delivered'
GROUP BY category
;
# "How loyal is our customer base? Are people buying once and leaving?"
WITH customer_summary AS
(
SELECT customer_id,
COUNT(DISTINCT order_id) total_orders
FROM orders 
WHERE status='Delivered'
GROUP BY customer_id
)
SELECT COUNT(*) total_customers,
SUM(CASE WHEN total_orders >1 THEN 1 ELSE 0 END) repeat_customers,
ROUND( SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END)*100.0/COUNT(*),2)  rpt_pc
FROM customer_summary
;
#"Where are we hemorrhaging revenue through returns? Which categories need quality control?"
WITH order_summary AS
(
SELECT 
category,
ord.order_id,
status
FROM products pro
JOIN order_items oi
	ON pro.product_id = oi.product_id
JOIN orders ord 
	ON ord.order_id=oi.order_id
GROUP BY category, order_id, ord.status
),
customer_loss AS
(
SELECT category,
COUNT(order_id) total_orders,
SUM( CASE WHEN status='Returned' THEN 1 ELSE 0 END)  total_return,
SUM( CASE WHEN status='Cancelled' THEN 1 ELSE 0 END)  total_cancelled,
ROUND(SUM(CASE WHEN status IN ('Returned','Cancelled' ) THEN 1 ELSE 0 END)*100.0/COUNT(DISTINCT order_id),2
) loss_po_rate
FROM order_summary
GROUP BY category
)
SELECT *
FROM customer_loss
ORDER BY loss_po_rate DESC
;
# "Which city has the highest spending customers? Where should we run premium promotions?"
SELECT delivery_city,
COUNT(DISTINCT cus.customer_id) total_customers,
COUNT(DISTINCT ord.order_id) total_order,
ROUND(SUM(quantity*unit_price) / COUNT(DISTINCT ord.order_id),0) avg_order_price,
SUM(quantity*unit_price)  total_revenue
FROM customers cus
JOIN orders ord
	ON cus.customer_id=ord.customer_id
JOIN order_items oi
	On oi.order_id = ord.order_id
WHERE ord.status = 'Delivered'
GROUP BY delivery_city
ORDER BY total_revenue DESC
;
#"Who are our most valuable customers? Who do we protect at all costs?"
WITH customer_summary AS
(SELECT ord.customer_id,
cus.city,
COUNT(DISTINCT ord.order_id) total_orders,
SUM(quantity*unit_price) total_spend
FROM customers cus
JOIN orders ord
	ON cus.customer_id=ord.customer_id
JOIN order_items oi
    ON ord.order_id = oi.order_id
WHERE ord.status  = 'Delivered'
GROUP BY ord.customer_id
)
SELECT *,
RANK() OVER(ORDER BY total_spend DESC) rnk,
CASE 
	WHEN total_orders > 1 AND total_spend > 50000 THEN 'VIP'
	WHEN total_orders > 1  THEN  'Regular'
    WHEN total_orders = 1 THEN 'Occasional'
END  label
FROM customer_summary
ORDER BY rnk 
;
# "Give me the full business health dashboard in one view."
 WITH delivered AS
 (
SELECT ord.customer_id,
oi.quantity,
oi.unit_price,
pro.cost_price,
ord.order_id,
ord.delivery_city,
ord.status
FROM orders ord
JOIN order_items oi
    ON ord.order_id   = oi.order_id
JOIN products pro     ON pro.product_id = oi.product_id
 ),
 summary AS
 (
 SELECT SUM(quantity * unit_price) total_revenue,
 SUM(quantity*(unit_price - cost_price)) total_gross_profit,
 ROUND(
		SUM(quantity*(unit_price - cost_price))*100.0/
        SUM(quantity*unit_price),2  
 ) mrg_pct,
COUNT(DISTINCT customer_id) total_customers,
COUNT(DISTINCT order_id)  total_orders
FROM delivered
WHERE status = 'Delivered'
 ),
 loss_summary AS
 (
 SELECT SUM( CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) total_returns,
 SUM( CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) total_cancelled,
 ROUND(
		SUM(CASE WHEN status IN ('Returned','Cancelled') THEN 1 ELSE 0 END) *100.0/
		COUNT(DISTINCT order_id),2
 ) loss_rate
 FROM orders
 )
 SELECT  s.total_revenue,
    s.total_gross_profit,
    s.mrg_pct,
    s.total_orders,
    s.total_customers,
    l.total_returns,
    l.total_cancelled,
    l.loss_rate
 FROM summary s ,loss_summary l