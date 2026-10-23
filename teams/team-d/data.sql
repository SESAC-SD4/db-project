-- 샘플 데이터: \i teams/team-d/data.sql
BEGIN;

-- 1. users 데이터 삽입
-- 1 김헬스, 2 박운동
INSERT INTO users (password, nickname, sex, age, height, weight) VALUES
('hash_pw_1', '김헬스', '남', 28, 175.5, 72.0),
('hash_pw_2', '박운동', '여', 25, 162.0, 53.5);

-- 2. exercise 데이터 삽입 (운동 종목 마스터)
-- 1 벤치프레스, 2 스쿼트, 3 랫풀다운, 4 러닝머신
INSERT INTO exercise (exercise_category, target_muscle, exercise_name) VALUES
('근력', '가슴', '벤치프레스'),
('근력', '하체', '스쿼트'),
('근력', '등', '랫풀다운'),
('유산소', '전신', '러닝머신');

-- 3. routine 데이터 삽입 (운동 루틴)
-- 1 월요일 상체 뿌시기(김헬스), 2 하체 집중 루틴(박운동)
INSERT INTO routine (user_id, title) VALUES
(1, '월요일 상체 뿌시기'),
(2, '하체 집중 루틴');

-- 4. routine_items 데이터 삽입 (루틴 상세 구성)
-- 1 루틴1 벤치프레스, 2 루틴1 랫풀다운, 3 루틴2 스쿼트
INSERT INTO routine_items (routine_id, exercise_id, target_sets, target_time, target_reps, exercise_order) VALUES
(1, 1, 3, NULL, 10, 1), -- 벤치프레스 (3세트, 10회)
(1, 3, 3, NULL, 12, 2), -- 랫풀다운 (3세트, 12회)
(2, 2, 4, NULL, 8, 1);  -- 스쿼트 (4세트, 8회)

-- 5. session 데이터 삽입 (운동 세션)
-- 1 김헬스 10/23 루틴1, 2 김헬스 10/24 자유 운동
INSERT INTO session (user_id, routine_id, started_at, finished_at, picture, memo) VALUES
(1, 1, '2026-10-23 10:00:00+09', '2026-10-23 11:00:00+09', 'url_img_1.jpg', '가슴 운동 잘 먹힘!'),
(1, NULL, '2026-10-24 18:00:00+09', '2026-10-24 18:30:00+09', NULL, '루틴 없이 가볍게 유산소');

-- 6. session_set 데이터 삽입 (세트별 수행 상세)
-- 1 세션1 벤치 1세트, 2 세션1 벤치 2세트, 3 세션1 랫풀다운 1세트, 4 세션2 러닝머신 1세트
INSERT INTO session_set (session_id, exercise_id, set_number, weight, speed, incline, reps, duration) VALUES
(1, 1, 1, 60.0, NULL, NULL, 10, 60),
(1, 1, 2, 65.0, NULL, NULL, 9, 60),
(1, 3, 1, 40.0, NULL, NULL, 12, 50),
(2, 4, 1, NULL, 10.5, 1.0, NULL, 1200); -- 러닝머신 유산소 세트

COMMIT;
