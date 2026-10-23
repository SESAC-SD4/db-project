---
name: hint
description: 막힌 곳에 3단계 힌트를 하나씩 준다(방향 → 비슷한 예 → 거의 답)
argument-hint: <막힌 곳>
disable-model-invocation: true
---

# /hint — 3단계 힌트

막힌 곳: $ARGUMENTS

막힌 곳이 비어 있으면 무엇에서 막혔는지 먼저 묻는다. 팀 폴더의 `README.md` · ERD · `schema.sql`을 읽고 지금 어디까지 했는지 확인한다.

**한 번에 한 단계만 준다.** 단계는 이 대화에서 같은 곳에 `/hint`로 준 횟수로만 센다. `/check`의 질문이나 대화 중의 질문은 세지 않는다. 처음 부르면 1단계다. 단계마다 끝에 "더 필요하면 `/hint`를 한 번 더 부르세요"라고 적는다.

## 1단계 — 방향

어느 기준(`docs/checklist.md`)이나 어느 요구사항 문장을 다시 보면 되는지 알려 준다. 질문 하나로 끝낸다. **해법의 모양(표를 하나 더 둔다 · 칸을 옮긴다)은 말하지 않는다** — 그건 2 · 3단계다.

- 예: "요구사항 4번 '한 주문에 메뉴를 여러 개 담는다'를 다시 읽어 보세요. 주문과 메뉴는 하나가 여럿인가요, 서로 여럿인가요?"

## 2단계 — 비슷한 예

이번 주 수업의 Netflix 표에서 같은 모양을 보여 준다.

- 1:N → `ratings` 하나에 `titles` 여럿, FK `titles.rating_id`
- N:M → `titles` · `genres`를 잇는 `title_genres` (`PRIMARY KEY (title_id, genre_id)`)
- 사람 하나가 두 역할 → `people` 하나 + `title_directors` · `title_cast`

팀의 표 이름으로 바꿔 말하지 않는다. 바꾸는 것은 팀이 한다.

## 3단계 — 거의 답

막힌 **그 부분 하나**만 모양을 보여 준다. 표 하나, 칸 이름과 PK · FK까지. 전체 `CREATE TABLE`이나 다른 표는 보여 주지 않는다. ERD · `schema.sql`에 옮기는 것은 팀이 한다.

## 3단계 다음

같은 곳에 `/hint`를 또 부르면 새 힌트를 주지 않는다. "힌트는 세 단계를 다 썼어요. 강사님을 불러 주세요."라고만 말한다.
