# 이번 주 규칙

이번 주 수업에서 쓴 모양으로 씁니다. 여기 없는 문법(뷰 · 트리거 · 함수 · `ENUM` · `SERIAL`)은 쓰지 않습니다.

## schema.sql

맨 앞 두 줄은 이렇게 둡니다. 다시 실행할 때마다 표를 모두 지우고 처음부터 만듭니다. 이 두 줄은 데이터베이스의 주인만 실행할 수 있습니다 — `CREATE DATABASE project OWNER sd4`로 만들고 `sd4`로 접속합니다.

```sql
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
```

### id

```sql
id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY
```

### 칸 자료형

| 자료형 | 쓰는 곳 |
| --- | --- |
| `text` | 이름 · 제목 · 설명 |
| `integer` | 수량 · 가격 · 별점 |
| `bigint` | id와 id를 가리키는 FK |
| `date` | 날짜 |
| `timestamptz` | 날짜 + 시각 (주문 시각처럼 시각이 필요할 때) |
| `boolean` | 예/아니오 |

### 제약조건

| 제약 | 언제 |
| --- | --- |
| `NOT NULL` | 꼭 있어야 하는 칸 |
| `UNIQUE` | 두 번 나오면 안 되는 칸 (아이디 · 이메일) |
| `CHECK (조건)` | 값의 범위 (`CHECK (rating BETWEEN 1 AND 5)`) |
| `DEFAULT 값` | 안 넣으면 들어갈 값 (`DEFAULT now()`) |

### FK

```sql
user_id bigint NOT NULL REFERENCES users (id) ON DELETE CASCADE
```

- `ON DELETE CASCADE` — 가리키는 행이 지워지면 이 행도 지운다
- `ON DELETE` 를 안 쓰면 — 이 행이 있는 동안 가리키는 행을 지울 수 없다(에러). 이렇게 정했다면 그것도 결정이다

### 연결 표

```sql
CREATE TABLE post_tags (
    post_id bigint NOT NULL REFERENCES posts (id) ON DELETE CASCADE,
    tag_id  bigint NOT NULL REFERENCES tags (id) ON DELETE CASCADE,
    PRIMARY KEY (post_id, tag_id)
);
```

**표 만드는 순서**: 다른 표가 가리키는 표(부모)를 먼저, 가리키는 표(자식) · 연결 표를 뒤에.

## data.sql

```sql
BEGIN;
INSERT INTO ...;
COMMIT;
```

중간에 에러가 나면 전부 들어가지 않습니다. 에러 메시지를 읽고 고친 뒤 **`schema.sql`부터 다시** 실행합니다. `ROLLBACK`으로 행은 사라져도 id 번호는 이미 쓴 것으로 남기 때문입니다(그대로 다시 넣으면 id가 3, 4 …부터 시작해 FK 값이 어긋납니다).

## queries.sql

쓰는 문법: `SELECT` · `WHERE` · `ORDER BY` · `LIMIT` · `JOIN` · `LEFT JOIN` · `GROUP BY` · `HAVING` · `count` · `sum` · `avg` · `max` · `min` · 서브쿼리(`WHERE … = (SELECT …)` · `WHERE … IN (SELECT …)` · `FROM (SELECT …)` 세 가지만. `SELECT` 목록 안에 서브쿼리를 넣지 않는다)

날짜 조건은 `now()` · `current_date` 대신 값을 직접 씁니다(`WHERE starts_at >= '2026-11-01'`). 그래야 언제 다시 돌려도 결과가 같고, 기능 추가 뒤 결과가 달라졌을 때 표 때문인지 알 수 있습니다.

## 표를 바꾼 뒤 (기능 추가)

`ALTER TABLE`로 고치지 않고 **파일을 고쳐 처음부터 다시 만듭니다.**

```
project=> \i teams/<팀이름>/schema.sql
project=> \i teams/<팀이름>/data.sql
project=> \i teams/<팀이름>/queries.sql
```

`queries.sql`은 에러가 나도 끝까지 실행됩니다. 에러가 난 쿼리와 결과가 달라진 쿼리를 찾습니다.

## psql

저장소 맨 위 폴더에서 psql을 엽니다. 그래야 `\i teams/...` 경로가 맞습니다.

```
psql -U sd4 -d project
```
