------------------------------------------Review Analysis-----------------------------------------===========

-- Since we already found out about the delayed deliveries might the one of the reasons for poor reviews. 
-- Let's recheck that ABORT

WITH categorized_reviews AS (
    SELECT
        review_id,
        review_score,
        LOWER(
            COALESCE(review_comment_message, '')
        ) AS review_text,

        CASE

            -- Delivery Issues
            WHEN review_comment_message ILIKE '%atras%'
              OR review_comment_message ILIKE '%demora%'
              OR review_comment_message ILIKE '%não recebi%'
              OR review_comment_message ILIKE '%nao recebi%'
              OR review_comment_message ILIKE '%entrega%'
              OR review_comment_message ILIKE '%prazo%'
            THEN 'Delivery Issue'

            -- Wrong / Missing Product
            WHEN review_comment_message ILIKE '%veio outro%'
              OR review_comment_message ILIKE '%faltou%'
              OR review_comment_message ILIKE '%recebi somente%'
              OR review_comment_message ILIKE '%produto diferente%'
            THEN 'Wrong / Missing Product'

            -- Damaged / Defective Product
            WHEN review_comment_message ILIKE '%defeito%'
              OR review_comment_message ILIKE '%quebrado%'
              OR review_comment_message ILIKE '%amassado%'
              OR review_comment_message ILIKE '%não funciona%'
              OR review_comment_message ILIKE '%nao funciona%'
            THEN 'Damaged / Defective Product'

            -- Quality Issues
            WHEN review_comment_message ILIKE '%péssima qualidade%'
              OR review_comment_message ILIKE '%produto inferior%'
              OR review_comment_message ILIKE '%não gostei%'
              OR review_comment_message ILIKE '%nao gostei%'
            THEN 'Poor Product Quality'

            -- Service / Communication Issues
            WHEN review_comment_message ILIKE '%sem resposta%'
              OR review_comment_message ILIKE '%não obtive resposta%'
              OR review_comment_message ILIKE '%nao obtive resposta%'
              OR review_comment_message ILIKE '%ninguém%'
            THEN 'Customer Service Issue'

            ELSE 'Other'
        END AS complaint_category

    FROM order_reviews

    WHERE review_comment_message IS NOT NULL
)

SELECT
    complaint_category,
    COUNT(*) AS total_reviews,

    ROUND(
        AVG(review_score),
        2
    ) AS avg_review_score,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN review_score <= 2 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS negative_review_percentage

FROM categorized_reviews
GROUP BY complaint_category
ORDER BY total_reviews DESC;


/*

### Key Insights

- Delivery and fulfillment-related complaints emerged as one of the most frequent drivers of 
customer dissatisfaction, reinforcing the strong relationship between operational performance 
and customer experience.

- Customer service issues recorded the lowest average review scores and the highest percentage of 
negative reviews, indicating that poor issue resolution and communication severely damage customer trust.

- A large portion of reviews remained uncategorized due to language complexity and limited keyword-based 
classification. Future improvements could include advanced NLP techniques such as Portuguese sentiment analysis,
topic modeling, and semantic classification for deeper customer feedback intelligence.

*/

--- Moving to Product analysis 