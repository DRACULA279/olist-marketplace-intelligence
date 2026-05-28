
-- Which categories are genuinely premium and which are skewed by outliers?

SELECT
    pt.product_category_name_english AS category,
    ROUND(AVG(oi.price)::numeric,2) AS mean_price,
    ROUND(PERCENTILE_CONT(0.5)WITHIN GROUP (ORDER BY oi.price)::numeric,2) AS median_price,
    ROUND(PERCENTILE_CONT(0.25)WITHIN GROUP (ORDER BY oi.price)::numeric,2) AS q1_price,
    ROUND(PERCENTILE_CONT(0.75)WITHIN GROUP (ORDER BY oi.price)::numeric,2) AS q3_price,
    ROUND(MAX(oi.price)::numeric,2) AS max_price

FROM order_items oi

LEFT JOIN products p
    ON p.product_id = oi.product_id

LEFT JOIN product_category_name_translation pt
    ON pt.product_category_name =
       p.product_category_name

GROUP BY 1
ORDER BY mean_price DESC;

/*

- Categories such as `computers` and `small_appliances_home_oven_and_coffee` demonstrated genuinely 
premium pricing behavior, with relatively aligned mean and median prices, indicating consistently 
higher-priced products rather than isolated outlier inflation.

- Categories like `watches_gifts` and `computers_accessories` showed broader price distributions with 
high maximum prices, suggesting mixed pricing structures that combine mass-market demand with 
premium product segments.

- High-volume categories including `bed_bath_table`, `housewares`, and `sports_leisure` maintained lower and 
more stable pricing ranges, indicating their likely role as recurring-demand and transaction-volume drivers 
within the marketplace ecosystem.

*/


-- Which categories carry the highest freight burden?

SELECT
    pt.product_category_name_english AS category,
    ROUND(SUM(oi.price)::numeric, 2) AS total_revenue,
    ROUND(SUM(oi.freight_value)::numeric, 2) AS total_freight,
    ROUND(AVG(oi.freight_value)::numeric, 2) AS avg_freight_per_order,
    ROUND(
        SUM(oi.freight_value)
        /
        SUM(oi.price) * 100,
        2
    ) AS freight_to_revenue_percentage

FROM order_items oi

LEFT JOIN products p
    ON p.product_id = oi.product_id

LEFT JOIN product_category_name_translation pt
    ON pt.product_category_name =
       p.product_category_name

GROUP BY 1

HAVING SUM(oi.price) > 50000

ORDER BY freight_to_revenue_percentage DESC;

/*

- Categories such as `electronics`, `office_furniture`, and `furniture_living_room` showed disproportionately 
high freight burdens relative to revenue, indicating that operational and logistics costs may significantly 
pressure profitability despite healthy sales performance.

- Large-volume categories including `bed_bath_table`, `housewares`, and `furniture_decor` combined strong 
revenue generation with consistently elevated freight ratios, suggesting that marketplace growth is tightly 
coupled with logistics scalability and fulfillment efficiency.

- Premium categories like `watches_gifts` and `computers` maintained comparatively low freight-to-revenue 
percentages despite higher average selling prices, indicating stronger operational efficiency and potentially 
healthier contribution margins relative to bulky or logistics-heavy categories.

*/

-- Which product categories generate the worst customer satisfaction?

SELECT
    pt.product_category_name_english AS category,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.review_score)::numeric, 2) AS avg_review_score,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN r.review_score <= 2 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS negative_review_percentage

FROM order_items oi

LEFT JOIN products p
    ON p.product_id = oi.product_id

LEFT JOIN product_category_name_translation pt
    ON pt.product_category_name =
       p.product_category_name

LEFT JOIN order_reviews r
    ON r.order_id = oi.order_id

WHERE r.review_score IS NOT NULL

GROUP BY 1
HAVING COUNT(*) >= 50

ORDER BY negative_review_percentage DESC,
         avg_review_score ASC;


/*

- Categories such as 'office_furniture', 'furniture_decor', 'bed_bath_table', and 'computers_accessories'
generated both high review volumes and elevated negative-review percentages, indicating that 
large-scale operational categories also carry significant customer-experience risk.

- Premium and higher-value categories like 'watches_gifts', 'health_beauty', and 'computers' maintained relatively
stronger customer satisfaction despite substantial revenue contribution, suggesting healthier 
operational execution and stronger perceived customer value.

- Furniture and logistics-heavy categories consistently underperformed in customer satisfaction metrics, 
reinforcing earlier findings that operational complexity, delivery handling, and fulfillment quality strongly 
influence marketplace experience and scalability.

*/
