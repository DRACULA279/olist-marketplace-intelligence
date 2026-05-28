----------------------------------------------SELLER ANALYSIS----------------------------------------------------

-- Which sellers drive most revenue?

SELECT

    s.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(COALESCE(SUM(oi.price),0)::numeric,2) AS revenue

FROM sellers s

LEFT JOIN order_items oi
    ON oi.seller_id = s.seller_id

LEFT JOIN orders o
    ON o.order_id = oi.order_id

WHERE
    o.order_purchase_timestamp < '2018-09-02'

GROUP BY 1
ORDER BY revenue DESC;


/*

- Revenue is heavily concentrated among a small number of sellers.

- Some sellers generate high revenue through massive order volume, while others rely on high-ticket products.

- Operational risk is high because delays or poor logistics from top sellers can directly impact 
customer satisfaction and marketplace revenue.

*/

-- Which sellers handle the highest operational volume?

SELECT

    s.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(COALESCE(SUM(oi.price),0)::numeric,2) AS revenue,
    ROUND(AVG(oi.price)::numeric,2) AS avg_order_value

FROM sellers s

LEFT JOIN order_items oi
    ON oi.seller_id = s.seller_id

LEFT JOIN orders o
    ON o.order_id = oi.order_id

WHERE
    o.order_purchase_timestamp < '2018-09-02'

GROUP BY 1

ORDER BY total_orders DESC;

SELECT COUNT(DISTINCT seller_id) AS total_sellers FROM sellers;


/*

## Seller Distribution Insight

- The marketplace contains 3095 distinct sellers, so seller count alone does not indicate market concentration.

- Seller dominance can only be validated through revenue and order distribution analysis, not by the 
total number of sellers.

- To confirm concentration risk, analyze:
  - Top 1%, 5%, and 10% seller contribution
  - Median vs average seller revenue
  - Pareto distribution / cumulative revenue share

*/

-- Seller Concentration / Pareto Analysis

WITH seller_revenue AS 
(
    SELECT
	
        oi.seller_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(op.payment_value) AS revenue
		
    FROM 
		orders o
	
    JOIN order_items oi
        ON o.order_id = oi.order_id
		
    JOIN order_payments op
        ON o.order_id = op.order_id
		
    GROUP BY seller_id
),

ranked_sellers AS 
(
    SELECT
        seller_id,
        total_orders,
        revenue,
        ROUND(revenue * 1.0 / total_orders, 2) AS aov, --JIC
        
        ROW_NUMBER() OVER (ORDER BY revenue DESC) AS seller_rank,
        
        COUNT(*) OVER () AS total_sellers,
        
        SUM(revenue) OVER () AS total_marketplace_revenue,
        
        SUM(revenue) OVER (ORDER BY revenue DESC) AS cumulative_revenue
		
    FROM seller_revenue
)

SELECT
    seller_id,
    total_orders,
    revenue,
    aov,
    
    seller_rank,
    
    ROUND(seller_rank * 100.0 / total_sellers,2) AS seller_percentile,
    
    ROUND(cumulative_revenue * 100.0 / total_marketplace_revenue,2) AS cumulative_revenue_percent

FROM 
	ranked_sellers

ORDER BY revenue DESC;


/*

### Seller Insights

1. Revenue is highly concentrated — few sellers dominate GMV while majority contribute very little. 
Long-tail marketplace structure.

2. High-ticket sellers outperform volume sellers — ~31 orders generating ₹3.9K–₹4.2K revenue indicates 
premium pricing beats low-margin scaling.

3. Core business bottleneck is seller quality, not seller quantity — improving average seller performance 
will create higher ROI than onboarding more weak sellers.

*/