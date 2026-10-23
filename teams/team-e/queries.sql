-- 기능 쿼리: \i teams/<팀이름>/queries.sql (`/ask`로 기능마다 덧붙인다)

-- 기능 1: 제품명이나 브랜드명으로 보유 화장품 조회 (회원 1번, 검색어 '이니스프리')
-- 변경: 구매처 기능에서 브랜드명이 product_brand_info로, 제품명 칸이 product_id로 옮겨져 고침
-- 쓴 사람: AI · 예상: 2행 · 실제: 1행 (표 바꾸기 전 결과)
-- 판정: 맞음 — 예상이 틀렸음. data.sql에서 회원 1번의 구매내역과 제품을 따라가 보고 확인
SELECT b.brand_name, p.product_id AS product_name, p.detail_id AS detail_name, o.order_date, o.amount, o.quantity
FROM order_histories o
JOIN product_info p ON p.pd_number = o.pd_id
JOIN product_brand_info b ON b.brand_regno = p.brand_regno
WHERE o.member_id = 1
  AND (b.brand_name = '이니스프리' OR p.product_id = '이니스프리')
ORDER BY o.order_date;

-- 기능 2: 내 구매 내역을 최근 순으로 보기 (회원 1번)
-- 변경: 구매처 기능에서 브랜드명이 product_brand_info로, 제품명 칸이 product_id로 옮겨져 고침
-- 쓴 사람: AI · 예상: 3행 · 실제: 3행 (표 바꾸기 전 결과)
-- 판정: 맞음 — 맨 위 행이 data.sql의 가장 최근 날짜와 같음
SELECT o.order_date, b.brand_name, p.product_id AS product_name, o.amount, o.quantity
FROM order_histories o
JOIN product_info p ON p.pd_number = o.pd_id
JOIN product_brand_info b ON b.brand_regno = p.brand_regno
WHERE o.member_id = 1
ORDER BY o.order_date DESC;

-- 기능 3: 제품별 구매 횟수 보기 (구매된 제품만)
-- 변경: 구매처 기능에서 브랜드명이 product_brand_info로, 제품명 칸이 product_id로 옮겨져 고침
-- 쓴 사람: AI · 예상: 4행 · 실제: 4행 (표 바꾸기 전 결과)
-- 판정: 맞음 — 첫 줄의 구매 횟수가 data.sql에서 손으로 센 횟수와 같음
SELECT b.brand_name, p.product_id AS product_name, count(*) AS buy_count
FROM product_info p
JOIN product_brand_info b ON b.brand_regno = p.brand_regno
JOIN order_histories o ON o.pd_id = p.pd_number
GROUP BY p.pd_number, b.brand_name, p.product_id
ORDER BY buy_count DESC;
