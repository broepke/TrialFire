SELECT COUNT(*)
FROM person_<<API_KEY>> P
WHERE (P.has_purchased is False) AND (P.first_seen > '2022-01-01');
-- False = 5273429
-- True = 181749

SELECT
  P.person_id, 
  P.first_utm_campaign, 
  P.first_utm_content, 
  P.first_utm_medium,
  P.first_utm_source,
  P.first_referrer_host, 
  P.last_geo_ip_country,
  P.multi_device::int, 
  P.session_count,
  P.last_utm_campaign, 
  P.last_utm_content, 
  P.last_utm_medium,
  P.last_utm_source,
  P.source_category,
  P.source_category_2,
  P.source_category_3, 
  EXTRACT(EPOCH FROM (P.last_seen - P.first_seen)) as days_since_first_vist,
  count(distinct S.first_utm_content) as first_utm_content_distinct,	
  count(distinct S.first_utm_medium) as first_utm_medium_distinct,	
  count(distinct S.first_utm_source) as first_utm_source_distinct,	
  count(distinct S.first_utm_term) as first_utm_term_distinct,
  sum(S.click_count) as click_count_sum,
  sum(S.input_count) as input_count_sum,
  sum(S.identify_count) as identify_count_sum,
  sum(S.view_count) as view_count_sum,
  sum(S.page_count) page_count_sum,
  count(distinct S.source_category) as source_category_distinct,
  avg(S.session_duration) as session_duration_avg,
  P.has_purchased::int
FROM person_<<API_KEY>> P
JOIN session_<<API_KEY>> S 
ON S.person_id = P.person_id
WHERE (P.has_purchased is True) AND (P.first_seen > '2022-01-01')
GROUP BY P.person_id
ORDER BY random()
LIMIT 100;
--LIMIT 96774
--LIMIT 48387

-- Get 10% of the data for not purchased
SELECT
  first_utm_campaign, 
  first_utm_content, 
  first_utm_medium,
  first_utm_source,
  first_referrer_host, 
  last_geo_ip_country,
  multi_device::int, 
  session_count,
  last_utm_campaign, 
  last_utm_content, 
  last_utm_medium,
  last_utm_source,
  source_category,
  source_category_2,
  source_category_3, 
  days_since_first,
  has_purchased::int
FROM person_<<API_KEY>> P
JOIN session_<<API_KEY>> S 
ON S.person_id = P.person_id
WHERE has_purchased = 0
ORDER BY random()
--LIMIT 1115270
LIMIT 557635

SELECT count(*) filter (where orders_total is null ) AS NotPurchased
     , count(*) filter (where orders_total is not null ) AS Purchased 
FROM person_<<API_KEY>> 


SELECT count(*)
FROM person_<<API_KEY>>

SELECT count(has_purchased)
FROM person_<<API_KEY>>
WHERE has_purchased = True
LIMIT 10


SELECT p.person_id, S.source_category
FROM person_<<API_KEY>> P 
JOIN session_<<API_KEY>> S 
ON S.person_id = P.person_id
WHERE S.first_seen between '2022-05-01' AND '2022-06-01'

SELECT p.person_id, array_agg(S.source_category)
FROM person_<<API_KEY>> P 
JOIN session_<<API_KEY>> S 
ON S.person_id = P.person_id
WHERE S.first_seen between '2022-05-01' AND '2022-06-01'
GROUP BY P.person_id
LIMIT 100

SELECT *
FROM session_<<API_KEY>>
WHERE person_id = '0001048c-0c26-11ec-9ad4-0242ac110003'
ORDER BY last_seen DESC

SELECT *
WHERE person_id = '0001048c-0c26-11ec-9ad4-0242ac110003'
ORDER BY last_seen DESC

SELECT person_id, count(*) AS total
FROM session_<<API_KEY>> S
GROUP BY person_id
ORDER BY total DESC
LIMIT 100

-- Get EPOCH time instead of timestamp
SELECT EXTRACT(EPOCH FROM (P.last_seen - P.first_seen)) as days_since_first_vist
FROM person_<<API_KEY>> P
WHERE (P.has_purchased is True) AND (P.first_seen > '2022-01-01')
LIMIT 10;

-- Booleans as INTs
SELECT P.has_purchased::int
FROM person_<<API_KEY>> P
LIMIT 10;