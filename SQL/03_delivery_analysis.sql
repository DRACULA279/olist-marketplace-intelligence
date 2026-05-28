
----------------------------------------Delivery Analysis -------------------------------------------------------

--What is the average delivery time and how reliable is delivery performance?

SELECT

    ROUND(AVG(DATE_PART('day',o.order_delivered_customer_date
                -
                o.order_purchase_timestamp))::numeric,2) AS avg_delivery_days,

    COUNT(
        CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
			THEN 1
        END
    ) AS delayed_orders,

    COUNT(*) AS total_delivered_orders,

    ROUND(100.0 * COUNT(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
				THEN 1 END)
        /

        NULLIF(COUNT(*),0),2) || '%' AS delay_rate

FROM orders o

WHERE
    o.order_status = 'delivered'
    AND o.order_purchase_timestamp < '2018-09-02'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_estimated_delivery_date IS NOT NULL;

/*

- Olist maintained relatively efficient logistics performance, with average delivery time around 12 days 
and ~92% of orders delivered on or before the estimated date.

- Only ~8.1% of delivered orders experienced delays, indicating generally reliable fulfillment and delivery 
operations at marketplace scale.

- Although overall operational health appeared stable, delayed orders can still significantly impact 
customer satisfaction and reviews, making delay reduction strategically important for retention 
and customer experience.

*/

-- Which states experience the highest delivery delays?

SELECT

    c.customer_state,
    COUNT(*) AS total_orders,

    COUNT(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 END) 
	AS delayed_orders,

    ROUND(100.0 * COUNT(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 END)/
    NULLIF(COUNT(*),0),2) || '%' AS delay_rate,

    ROUND(AVG(DATE_PART('day', o.order_delivered_customer_date - o.order_purchase_timestamp))::numeric,2) 
	AS avg_delivery_days

FROM orders o

LEFT JOIN customers c
    ON c.customer_id = o.customer_id

WHERE
    o.order_status = 'delivered'
    AND o.order_purchase_timestamp < '2018-09-02'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY 1
ORDER BY delay_rate DESC;

/*

- High-volume states such as SP and RJ generated the largest number of delayed orders, mainly due to 
massive operational scale rather than poor delivery efficiency.

- Northeastern states like AL, MA, PI, and CE showed the highest delay rates, indicating potential 
regional logistics bottlenecks and weaker delivery infrastructure.

- Olist may improve operational performance through regional warehouse expansion, routing optimization, 
and stronger last-mile logistics partnerships in high-delay regions.

*/


-- Which sellers contribute most to delivery delays?

SELECT

    oi.seller_id,

    COUNT(*) AS total_orders,

    COUNT(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 END) 
	AS delayed_orders,

    ROUND(100.0 * COUNT(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 END)/
    NULLIF(COUNT(*),0),2) AS delay_rate,

    ROUND(AVG(DATE_PART('day',o.order_delivered_customer_date - o.order_purchase_timestamp))::numeric,2) 
	AS avg_delivery_days

FROM orders o

LEFT JOIN order_items oi
    ON oi.order_id = o.order_id

WHERE
    o.order_status = 'delivered'
    AND o.order_purchase_timestamp < '2018-09-02'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY 1
HAVING COUNT(*) > 30

ORDER BY delay_rate DESC;

/*

## Seller Delivery Performance Insights

- Several sellers showed extremely high delay rates, with some exceeding 20–50% delayed deliveries.

- However, many of the worst-performing sellers had relatively low order volumes, 
meaning operational instability may be caused by small-scale logistics limitations 
rather than systemic marketplace issues.

- Larger sellers with high order volumes and elevated delay rates are more operationally concerning because 
they affect a significantly larger number of customers.

- Seller `06a2c3af7b3aee5d69171b0e14f0ee87` stood out operationally:
    - 402 total orders
    - 95 delayed orders
    - 23.63% delay rate

- Some high-volume sellers maintained relatively low delay rates despite handling thousands of orders, 
suggesting stronger logistics infrastructure and inventory management.

- Delay rates alone are insufficient for operational prioritization; 
both scale and delay percentage must be evaluated together.

## Operational Recommendations

- Prioritize monitoring high-volume sellers with elevated delay rates, as they create the largest customer impact.

- Introduce seller performance scorecards combining:
    - delay rate
    - delivery time
    - review score
    - cancellation rate

- Sellers with persistently high delay rates may require:
    - regional warehouse expansion
    - improved courier partnerships
    - inventory redistribution
    - stricter SLA enforcement

- Small sellers with extreme delay volatility may benefit from centralized fulfillment support or logistics 
onboarding programs.

*/

-- Do delivery delays reduce customer review scores?

SELECT

    CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Delayed' ELSE 'On Time'
    END AS delivery_status,

    COUNT(*) AS total_orders,

    ROUND(AVG(orv.review_score)::numeric,2) AS avg_review_score,

    ROUND(AVG(DATE_PART('day',o.order_delivered_customer_date - o.order_purchase_timestamp))::numeric,2)
	AS avg_delivery_days

FROM orders o

LEFT JOIN order_reviews orv
    ON orv.order_id = o.order_id

WHERE
    o.order_status = 'delivered'
    AND o.order_purchase_timestamp < '2018-09-02'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY 1;

SELECT MAX(review_score), MIN(review_score) FROM order_reviews;

/*

## Delivery Delays vs Customer Satisfaction

- Delayed orders received significantly lower review scores (2.57/5) compared to on-time deliveries (4.29/5), 
showing a strong relationship between logistics performance and customer satisfaction.

- Delayed deliveries took ~31 days on average versus ~10 days for on-time orders, indicating long shipping 
durations heavily impacted customer experience.

- Improving delivery reliability through better routing, regional warehousing, and seller performance monitoring
could improve customer satisfaction and retention.

*/

-- Do heavier or higher-freight products create more delivery delays?

SELECT MAX(freight_value), PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY freight_value),MIN(freight_value) 
FROM order_items;


SELECT

    CASE
        WHEN oi.freight_value < 20 THEN 'Low Freight'
        WHEN oi.freight_value < 50 THEN 'Medium Freight'
        ELSE 'High Freight'
    END AS freight_segment,

    COUNT(*) AS total_orders,

    ROUND(AVG(oi.freight_value)::numeric,2) AS avg_freight_value,
    ROUND(AVG(p.product_weight_g)::numeric,2) AS avg_product_weight_g,
    ROUND(AVG(DATE_PART('day',o.order_delivered_customer_date - o.order_purchase_timestamp))::numeric,2) 
	AS avg_delivery_days,

    ROUND(AVG(orv.review_score)::numeric,2) AS avg_review_score,
	
    ROUND(100.0 *
        COUNT(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 END)/
        NULLIF(COUNT(*),0),2) AS delay_rate

FROM orders o

LEFT JOIN order_items oi
    ON oi.order_id = o.order_id

LEFT JOIN products p
    ON p.product_id = oi.product_id

LEFT JOIN order_reviews orv
    ON orv.order_id = o.order_id

WHERE
    o.order_status = 'delivered'
    AND o.order_purchase_timestamp < '2018-09-02'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY 1
ORDER BY avg_freight_value;

/*

## Freight, Product Weight & Delivery Performance

- Higher freight segments contained significantly heavier products and experienced longer delivery times, 
indicating logistics complexity increases with shipment size and weight.

- High-freight orders averaged ~16.7 delivery days and showed the highest delay rate (~10.7%), while also 
receiving the lowest customer review scores.

- Operational improvements such as regional warehousing, optimized routing, and specialized handling for 
heavy shipments could reduce delays and improve customer satisfaction.

*/

