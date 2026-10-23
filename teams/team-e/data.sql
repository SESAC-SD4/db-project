-- 샘플 데이터: \i teams/team-e/data.sql
BEGIN;

-- 회원: 1 김하나, 2 이둘, 3 박셋
INSERT INTO member_info (mem_id, mem_nick_name, mem_pwd, mem_email, mem_birth, mem_sex, mem_status) VALUES
    ('hana01', '하나', 'pw1111', 'hana@example.com', '1995-03-12', 'f', 'Y'),
    ('dul02',  '둘리', 'pw2222', NULL,                '1990-07-25', 'f', 'Y'),
    ('set03',  '셋째', 'pw3333', 'set@example.com',   NULL,         NULL, 'Y');

-- 제품: 1 라네즈 워터 슬리핑 마스크, 2 이니스프리 그린티 세럼, 3 이니스프리 노세범 파우더(단종), 4 설화수 윤조에센스, 5 롬앤 쥬시 래스팅 틴트
INSERT INTO product_info (brand_name, product_name, detail_name, state) VALUES
    ('라네즈',     '워터 슬리핑 마스크', '70ml',  '판매 중'),
    ('이니스프리', '그린티 세럼',        '80ml',  '판매 중'),
    ('이니스프리', '노세범 파우더',      '5g',    '단종'),
    ('설화수',     '윤조에센스',         '60ml',  '판매 중'),
    ('롬앤',       '쥬시 래스팅 틴트',   '05호',  '판매 중');

-- 구매내역: (회원, 제품) 번호는 위 주석 참고
INSERT INTO order_histories (member_id, pd_id, order_date, amount, quantity) VALUES
    (1, 1, '2026-09-01', 32000, 1),
    (1, 1, '2026-10-05', 32000, 2),
    (1, 2, '2026-09-15', 25000, 1),
    (2, 1, '2026-09-20', 32000, 1),
    (2, 2, '2026-10-01', 25000, 2),
    (2, 3, '2026-08-10',  9000, 1),
    (2, 4, '2026-10-10', 98000, 1);

COMMIT;
