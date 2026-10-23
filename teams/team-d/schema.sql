-- 표 만들기: \i teams/team-d/schema.sql
-- 규칙: docs/rules.md · 부모 표를 먼저, 연결 표를 뒤에
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- 1. users 테이블
CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    password TEXT NOT NULL,
    nickname TEXT NOT NULL,
    create_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    sex TEXT,
    age INT,
    height NUMERIC,
    weight NUMERIC
);

-- 2. exercise 테이블 (운동 종목 마스터)
CREATE TABLE exercise (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    exercise_category TEXT NOT NULL,
    target_muscle TEXT,
    exercise_name TEXT NOT NULL UNIQUE
);

-- 3. routine 테이블 (운동 루틴)
CREATE TABLE routine (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_routine_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- 4. routine_items 테이블 (루틴 상세 구성)
CREATE TABLE routine_items (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    routine_id BIGINT NOT NULL,
    exercise_id BIGINT NOT NULL,
    target_sets INT,
    target_time INT,
    target_reps INT,
    exercise_order INT NOT NULL,
    CONSTRAINT fk_routine_items_routine FOREIGN KEY (routine_id) REFERENCES routine (id) ON DELETE CASCADE,
    CONSTRAINT fk_routine_items_exercise FOREIGN KEY (exercise_id) REFERENCES exercise (id) ON DELETE RESTRICT,
    CONSTRAINT uq_routine_item_order UNIQUE (routine_id, exercise_order)
);

-- 5. session 테이블 (운동 세션)
CREATE TABLE session (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    routine_id BIGINT NULL, 
    started_at TIMESTAMPTZ NOT NULL,
    finished_at TIMESTAMPTZ,
    picture TEXT,
    memo TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_session_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_session_routine FOREIGN KEY (routine_id) REFERENCES routine (id) ON DELETE SET NULL
);

-- 6. session_set 테이블 (세트별 수행 상세)
CREATE TABLE session_set (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_id BIGINT NOT NULL,
    exercise_id BIGINT NOT NULL,
    set_number INT NOT NULL,
    weight NUMERIC,
    speed NUMERIC,
    incline NUMERIC,
    reps INT,
    duration INT,
    CONSTRAINT fk_session_set_session FOREIGN KEY (session_id) REFERENCES session (id) ON DELETE CASCADE,
    CONSTRAINT fk_session_set_exercise FOREIGN KEY (exercise_id) REFERENCES exercise (id) ON DELETE RESTRICT,
    CONSTRAINT uq_session_set_number UNIQUE (session_id, exercise_id, set_number)
);