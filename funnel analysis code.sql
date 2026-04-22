/* Funnel steps:
Browse -> Add to Cart -> Checkout -> Purchase
*/

-- 1. Aggregate user events per session
WITH user_journey AS (
SELECT
    "User ID",
    "Session ID",
    SUM(CASE WHEN Event = 'Browse' THEN 1 ELSE 0 END) AS browse_events,
    SUM(CASE WHEN Event = 'Add to Cart' THEN 1 ELSE 0 END) AS addtocart_events,
    SUM(CASE WHEN Event = 'Checkout' THEN 1 ELSE 0 END) AS checkout_events,
    SUM(CASE WHEN Event = 'Purchase' THEN 1 ELSE 0 END) AS purchase_events
FROM 'Funnel_Analysis_Data.csv'
GROUP BY 1, 2
),

-- 2. Count distinct users at each funnel step
funnel_counts AS (
SELECT
    COUNT(DISTINCT "User ID") AS browse_users,
    COUNT(DISTINCT CASE WHEN addtocart_events > 0 THEN "User ID" END) AS addtocart_users,
    COUNT(DISTINCT CASE WHEN checkout_events > 0 THEN "User ID" END) AS checkout_users,
    COUNT(DISTINCT CASE WHEN purchase_events > 0 THEN "User ID" END) AS purchase_users
FROM user_journey
),

-- 3. Map each funnel step to its user count
funnel_steps AS (
    SELECT 
		'01. Browse' AS step,
		browse_users AS num_users
	FROM funnel_counts
    UNION ALL
    SELECT 
		'02. Add to Cart', 
		addtocart_users
	FROM funnel_counts
    UNION ALL
    SELECT
		'03. Checkout',
		checkout_users
	FROM funnel_counts
    UNION ALL
    SELECT 
		'04. Purchase',
		purchase_users 
	FROM funnel_counts
)

-- 4. Assemble funnel steps and calculate conversion/drop-off rates
SELECT
    step,
    num_users,
    ROUND(100.0 * num_users / NULLIF(first_value(num_users) OVER (ORDER BY step), 0), 2) AS percent_users,
    ROUND(100.0 * (1 - num_users * 1.0 / NULLIF(LAG(num_users) OVER (ORDER BY step), 0)), 2) AS percent_drop_off
FROM funnel_steps;