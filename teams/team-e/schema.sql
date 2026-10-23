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

-- 브랜드정보
CREATE TABLE product_brand_info (
    brand_regno INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    brand_state VARCHAR(1) NOT NULL DEFAULT 'Y'
);

-- 제품정보(제품등록번호, 브랜드명, 제품명, 상세명, 현재상태)
CREATE TABLE product_info (
    pd_number BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    brand_regno INTEGER NOT NULL REFERENCES product_brand_info(brand_regno),
    product_id text NOT NULL,
    detail_id text NOT NULL,
    state text NOT NULL DEFAULT 'Y'
);

-- 상점 정보
CREATE TABLE store_info (
    store_regno BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_state VARCHAR(1) NOT NULL DEFAULT 'Y'
);

-- 상점 지점정보
CREATE TABLE store_market_info (
    store_regno BIGINT NOT NULL REFERENCES store_info(store_regno),
    market_regno SMALLINT NOT NULL,
    market_name VARCHAR(100) NOT NULL,
    market_state VARCHAR(1) NOT NULL DEFAULT 'Y',
    CONSTRAINT PK_store_market_info PRIMARY KEY (store_regno, market_regno)
);

-- 회원구매내역(구매내역등록번호, 회원등록번호, 제품등록번호, 구매일자, 금액, 수량)
CREATE TABLE order_histories (
    order_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id BIGINT NOT NULL REFERENCES member_info(member_regno),
    pd_id BIGINT NOT NULL REFERENCES product_info(pd_number),
    market_regno SMALLINT,
    store_regno BIGINT,
    order_date DATE,
    amount INTEGER NOT NULL DEFAULT 0,
    quantity SMALLINT NOT NULL DEFAULT 0,
    CONSTRAINT fk_order_histories FOREIGN KEY (market_regno, store_regno) REFERENCES store_market_info (market_regno, store_regno)
);

COMMENT ON TABLE member_info IS '회원정보';
COMMENT ON COLUMN member_info.member_regno IS '회원등록번호';
COMMENT ON COLUMN member_info.mem_id IS '회원 아이디';
COMMENT ON COLUMN member_info.mem_nick_name IS '회원 닉네임';
COMMENT ON COLUMN member_info.mem_pwd IS '회원 비밀번호';
COMMENT ON COLUMN member_info.mem_email IS '회원 이메일 주소';
COMMENT ON COLUMN member_info.mem_birth IS '회원 생년월일';
COMMENT ON COLUMN member_info.mem_sex IS '회원 성별(m:남, f:여)';
COMMENT ON COLUMN member_info.mem_status IS '회원 상태(Y:사용, N:미사용)';

COMMENT ON TABLE product_brand_info IS '브랜드 정보';
COMMENT ON COLUMN product_brand_info.brand_regno IS '브랜드 등록번호';
COMMENT ON COLUMN product_brand_info.brand_name IS '브랜드 명';
COMMENT ON COLUMN product_brand_info.brand_state IS '브랜드 상태(Y:운영, N:폐업)';

COMMENT ON TABLE product_info IS '제품정보';
COMMENT ON COLUMN product_info.pd_number IS '제품등록번호';
COMMENT ON COLUMN product_info.brand_regno IS '브랜드 등록번호';
COMMENT ON COLUMN product_info.product_id IS '제품명';
COMMENT ON COLUMN product_info.detail_id IS '상세명';
COMMENT ON COLUMN product_info.state IS '현재상태(판매중, 입고대기, 판매, 품절)';

COMMENT ON TABLE store_info IS '상점 정보';
COMMENT ON COLUMN store_info.store_regno IS '상점 등록번호';
COMMENT ON COLUMN store_info.store_name IS '상점 명';
COMMENT ON COLUMN store_info.store_state IS '상점 상태(Y:운영, N:폐업)';

COMMENT ON TABLE store_market_info IS '상점 지점정보';
COMMENT ON COLUMN store_market_info.store_regno IS '상점 등록번호';
COMMENT ON COLUMN store_market_info.market_regno IS '지점 등록번호';
COMMENT ON COLUMN store_market_info.market_name IS '지점 명';
COMMENT ON COLUMN store_market_info.market_state IS '지점 상태';

COMMENT ON TABLE order_histories IS '회원구매내역';
COMMENT ON COLUMN order_histories.order_id IS '구매이력번호';
COMMENT ON COLUMN order_histories.member_id IS '회원등록번호';
COMMENT ON COLUMN order_histories.pd_id IS '제품등록번호';
COMMENT ON COLUMN order_histories.order_date IS '구매일자';
COMMENT ON COLUMN order_histories.amount IS '구매금액';
COMMENT ON COLUMN order_histories.quantity IS '구매수량';
COMMENT ON COLUMN order_histories.market_regno IS '지점등록번호';
COMMENT ON COLUMN order_histories.store_regno IS '상점등록번호';