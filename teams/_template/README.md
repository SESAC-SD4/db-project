# 팀 이름

- 팀원:
- 주제:

## 요구사항

1.
2.
3.

## ERD

![ERD](erd.drawio.png)

## 기능 쿼리

`queries.sql`에 기능마다 SQL이 있습니다.

1.
2.
3.

## 기능 백로그

나중에 넣고 싶은 기능. `/next`에서 하나씩 꺼냅니다.

- [ ]

## 변경 기록

| 기능 | 바뀐 표 | 영향받은 쿼리 | 처음부터 알았다면 |
| --- | --- | --- | --- |

## 틀렸던 SQL

팀이 쓴 것이든 AI가 쓴 것이든 하나.

- 기능:
- 처음 SQL이 낸 결과:
- 무엇으로 틀린 것을 찾았나:
- 고친 SQL:

## 실행

저장소 맨 위 폴더에서:

```
psql -U sd4 -d project
project=> \i teams/<팀이름>/schema.sql
project=> \i teams/<팀이름>/data.sql
project=> \i teams/<팀이름>/queries.sql
```
