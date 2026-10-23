-- 표 만들기: \i teams/<팀이름>/schema.sql
-- 규칙: docs/rules.md · 부모 표를 먼저, 연결 표를 뒤에
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;


-- 회원정보(회원등록번호, 아이디, 닉네임, 비번, 이메일, 생년월일, 성별)
CREATE TABLE member_info (
    member_regno BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    mem_id VARCHAR(100) NOT NULL UNIQUE,
    mem_nick_name VARCHAR(20) NOT NULL,
    mem_pwd VARCHAR(200) NOT NULL,
    mem_email VARCHAR(50) NULL,
    mem_birth DATE NULL,
    mem_sex VARCHAR(1) NULL,
    mem_status VARCHAR(1) NOT NULL DEFAULT 'Y'
);

-- 제품정보(제품등록번호, 브랜드명, 제품명, 상세명, 현재상태)
CREATE TABLE product_info (
    pd_number BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    brand_name text NOT NULL,
    product_name text NOT NULL,
    detail_name text NOT NULL,
    state text NOT NULL
);

-- 회원구매내역(구매내역등록번호, 회원등록번호, 제품등록번호, 구매일자, 금액, 수량)
CREATE TABLE order_histories (
    order_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id BIGINT NOT NULL,
    pd_id BIGINT NOT NULL,
    order_date DATE,
    amount INTEGER,
    quantity SMALLINT
);

ALTER TABLE order_histories ADD CONSTRAINT order_histories_member_id_fkey
FOREIGN KEY (member_id) REFERENCES member_info(member_regno);

ALTER TABLE order_histories ADD CONSTRAINT order_histories_pd_id_fkey
FOREIGN KEY (pd_id) REFERENCES product_info(pd_number);

COMMENT ON TABLE member_info IS '회원정보';
COMMENT ON COLUMN member_info.member_regno IS '회원등록번호';
COMMENT ON COLUMN member_info.mem_id IS '회원 아이디';
COMMENT ON COLUMN member_info.mem_nick_name IS '회원 닉네임';
COMMENT ON COLUMN member_info.mem_pwd IS '회원 비밀번호';
COMMENT ON COLUMN member_info.mem_email IS '회원 이메일 주소';
COMMENT ON COLUMN member_info.mem_birth IS '회원 생년월일';
COMMENT ON COLUMN member_info.mem_sex IS '회원 성별(m:남, f:여)';
COMMENT ON COLUMN member_info.mem_status IS '회원 상태(Y:사용, N:미사용)';

COMMENT ON TABLE product_info IS '제품정보';
COMMENT ON COLUMN product_info.pd_number IS '제품등록번호';
COMMENT ON COLUMN product_info.brand_name IS '브랜드명';
COMMENT ON COLUMN product_info.brand_name IS '제품명';
COMMENT ON COLUMN product_info.detail_name IS '상세명';
COMMENT ON COLUMN product_info.state IS '현재상태';

COMMENT ON TABLE order_histories IS '회원구매내역';
COMMENT ON COLUMN order_histories.order_id IS '구매이력번호';
COMMENT ON COLUMN order_histories.member_id IS '회원등록번호';
COMMENT ON COLUMN order_histories.pd_id IS '제품등록번호';
COMMENT ON COLUMN order_histories.order_date IS '구매일자';
COMMENT ON COLUMN order_histories.amount IS '구매금액';
COMMENT ON COLUMN order_histories.quantity IS '구매수량';