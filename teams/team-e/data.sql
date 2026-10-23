-- 샘플 데이터: \i teams/team-e/data.sql
BEGIN;

-- 회원: 1 김하나, 2 이둘, 3 박셋
INSERT INTO member_info (mem_id, mem_nick_name, mem_pwd, mem_email, mem_birth, mem_sex, mem_status) VALUES
    ('hana01', '하나', 'pw1111', 'hana@example.com', '1995-03-12', 'f', 'Y'),
    ('dul02',  '둘리', 'pw2222', NULL,                '1990-07-25', 'f', 'Y'),
    ('set03',  '셋째', 'pw3333', 'set@example.com',   NULL,         NULL, 'Y');

-- 브랜드: 1 라네즈, 2 이니스프리, 3 설화수
INSERT INTO product_brand_info (brand_name, brand_state) VALUES
    ('라네즈',     'Y'),
    ('이니스프리', 'Y'),
    ('설화수',     'Y');

-- 제품: 1 라네즈 워터 슬리핑 마스크, 2 이니스프리 그린티 세럼, 3 이니스프리 노세범 파우더(단종), 4 설화수 윤조에센스, 5 설화수 벨벳 립 틴트
INSERT INTO product_info (brand_regno, product_id, detail_id, state) VALUES
    (1, '워터 슬리핑 마스크', '70ml', '판매 중'),
    (2, '그린티 세럼',        '80ml', '판매 중'),
    (2, '노세범 파우더',      '5g',   '단종'),
    (3, '윤조에센스',         '60ml', '판매 중'),
    (3, '벨벳 립 틴트',       '05호', '판매 중');

-- 상점: 1 올리브영, 2 롯데백화점, 3 쿠팡
INSERT INTO store_info (store_name, store_state) VALUES
    ('올리브영',   'Y'),
    ('롯데백화점', 'Y'),
    ('쿠팡',       'Y');

-- 지점: (상점, 지점번호) 1-1 올리브영 강남점, 1-2 올리브영 홍대점, 1-3 올리브영 명동점(폐업), 2-1 롯데백화점 본점, 2-2 롯데백화점 잠실점
INSERT INTO store_market_info (store_regno, market_regno, market_name, market_state) VALUES
    (1, 1, '강남점', 'Y'),
    (1, 2, '홍대점', 'Y'),
    (1, 3, '명동점', 'N'),
    (2, 1, '본점',   'Y'),
    (2, 2, '잠실점', 'Y');

-- 구매내역: (회원, 제품, 구매일, 금액, 수량, 지점번호, 상점)
INSERT INTO order_histories (member_id, pd_id, order_date, amount, quantity, market_regno, store_regno) VALUES
    (1, 1, '2026-09-01', 32000, 1, 1,    1),
    (1, 1, '2026-10-05', 32000, 2, NULL, NULL),
    (1, 2, '2026-09-15', 25000, 1, 2,    1),
    (2, 1, '2026-09-20', 32000, 1, 1,    2),
    (2, 2, '2026-10-01', 25000, 2, NULL, 3),
    (2, 3, '2026-08-10',  9000, 1, NULL, NULL),
    (2, 4, '2026-10-10', 98000, 1, 2,    2),
    (1, 2, '2026-09-01', 25000, 1, 1,    1);

COMMIT;
