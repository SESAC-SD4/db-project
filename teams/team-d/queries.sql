-- 기능 쿼리: \i teams/<팀이름>/queries.sql (`/ask`로 기능마다 덧붙인다)
-- 기능 1: 내 루틴 목록 보기
-- 쓴 사람: 팀 · 예상: 1행 · 실제: 1행
-- 판정: 맞음 (예상한 행 '월요일 상체 뿌시기'가 나옴)
select title, created_at, user_id from routine where user_id=1;

-- 기능 2: 특정 루틴 상세 구성 보기
-- 쓴 사람: 팀 · 예상: 2행 · 실제: 2행
-- 판정: 틀렸다가 고침 — 첫 실행에서 에러. 에러 메시지의 HINT를 읽고 alias로 고침
-- 틀렸던 SQL: ... from routine_items as ri join exercise on exercise.id=routine_items.exercise_id ... (as ri로 이름을 붙인 뒤 routine_items라고 부름)
select exercise.exercise_name, ri.target_sets, ri.target_time, ri.target_reps, ri.exercise_order from routine_items as ri join exercise on exercise.id=ri.exercise_id where ri.routine_id=1;

-- 기능 3: 지난 운동 기록 다시 보기
-- 쓴 사람: 팀 · 예상: 3행 · 실제: 3행
-- 판정: 틀렸다가 고침 — 12행이 나옴. 중량 40 · 횟수 12인 세트(랫풀다운) 한 행을 손으로 찾아보니 종목 이름이 4개 다 붙어 있었음. session_set과 exercise를 잇는 조건이 없었음
-- 틀렸던 SQL: ... from session, session_set, exercise where session.id=1 and session_set.session_id=1; (3행 × 종목 4개 = 12행)
select session.started_at, exercise.exercise_name, session_set.weight, session_set.reps from session, session_set, exercise where session.id=1 and session_set.session_id=1 and session_set.exercise_id=exercise.id;


-- 3. 특정 운동 세션 및 세트 상세 기록  (예: session_id = 1)
SELECT 
    s.started_at,
    s.finished_at,
    s.memo,
    ss.set_number,
    e.exercise_name,
    ss.weight,
    ss.reps,
    ss.duration
FROM session s
JOIN session_set ss ON s.id = ss.session_id
JOIN exercise e ON ss.exercise_id = e.id
WHERE s.id = 1
ORDER BY ss.set_number ASC;

