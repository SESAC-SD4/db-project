# DB 설계 프로젝트

2~3인 팀이 서비스 하나를 설계하고, 만들고, **기능을 계속 더해 가며 표를 고쳐 봅니다.** 설계는 팀이 하고, Claude Code는 질문 · 판정 · 힌트로 돕습니다.

## 명령 한눈에

| 명령 | 언제 |
| --- | --- |
| `/start` | 처음 한 번 — 팀 폴더 · 주제 · 요구사항 · 기능 백로그 |
| `/check` | ERD나 `schema.sql`을 그리거나 고친 뒤 — 기준표로 검토 |
| `/data` | `schema.sql`이 에러 없이 실행된 뒤 · 표를 고친 뒤 — 샘플 데이터 |
| `/ask <기능>` | 서비스 기능 하나를 SQL로 — 실행 전에 결과를 예상하고 판정 |
| `/next` | 기본을 마친 뒤 — 기능 하나 더하기 |
| `/hint <막힌 곳>` | 막혔을 때 — 단계마다 조금씩, 세 번 뒤에는 강사 |

| 누가 | 무엇을 |
| --- | --- |
| 팀 | ERD(`erd.drawio.png`) · `schema.sql` · psql 실행 · git |
| Claude Code | 질문 · 검토 · `data.sql` · 쿼리를 같이 쓰고 판정 |

Claude Code에 ERD나 `schema.sql`을 써 달라고 하면 거절합니다. 팀이 쓰도록 설정해 둔 것입니다.

## 0. 준비 (팀에서 한 명)

1. 이 저장소를 **Fork** 합니다 (GitHub 오른쪽 위 Fork)
2. 내 Fork를 클론하고 그 폴더로 들어갑니다

   ```
   git clone https://github.com/<내아이디>/db-project.git
   cd db-project
   ```

3. 팀 폴더를 만듭니다. 팀 이름은 영어 소문자로 (예: `team-a`)

   ```
   cp -r teams/_template teams/<팀이름>
   ```

4. 프로젝트용 데이터베이스를 만듭니다. `OWNER sd4`를 빠뜨리면 `schema.sql`이 실행되지 않습니다

   ```
   psql -d postgres          # mac
   psql -U postgres          # Windows (Git Bash)
   ```

   ```
   postgres=# CREATE DATABASE project OWNER sd4;
   postgres=# \q
   ```

5. 이 폴더에서 Claude Code를 엽니다: `claude`

## 1. 기본 — 모든 팀이 끝냅니다

| # | 단계 | 파일 (`teams/<팀이름>/`) | Claude Code |
| ---: | --- | --- | --- |
| 1 | 주제 · 요구사항 · 기능 백로그 | `README.md` | `/start` |
| 2 | ERD 그리기 (draw.io) | `erd.drawio.png` | `/check` |
| 3 | 표 만들기 → psql로 실행 | `schema.sql` | `/check` |
| 4 | 샘플 데이터 → psql로 실행 | `data.sql` | `/data` |
| 5 | 기능 쿼리 3개 | `queries.sql` | `/ask <기능>` |
| 6 | 커밋 · push → **Pull Request 열기** | — | — |

막히면 언제든 `/hint <막힌 곳>`.

- **`erd.drawio.png` · `schema.sql`은 팀이 직접 씁니다.** Claude Code는 이 파일을 고칠 수 없게 설정되어 있습니다
- psql과 git은 팀이 직접 실행하고, 결과를 Claude Code에 붙여 넣습니다
- 문서: [주제 예시](docs/topics.md) · [기준표](docs/checklist.md) · [이번 주 규칙](docs/rules.md) · [ERD 그리는 법](docs/erd-guide.md)

## 2. 기능 추가 — 끝나는 시각까지 반복합니다

기본을 마친 팀은 기능을 하나씩 더합니다. **한 바퀴마다 키보드를 잡는 사람을 바꿉니다.**

1. `/next` — 기능 백로그에서 하나 고르기 (백로그가 비면 후보를 받는다) · 이번에 칠 사람 정하기
2. 요구사항에 문장 추가
3. ERD 고치기 → `/check`
4. `schema.sql` 고치기 → `/check`
5. `/data` — 바뀐 표에 맞게 `data.sql` 고치기
6. **다시 만들고 이전 쿼리 전부 다시 돌리기** — 영향받은 쿼리가 있는지 확인

   ```
   project=> \i teams/<팀이름>/schema.sql
   project=> \i teams/<팀이름>/data.sql
   project=> \i teams/<팀이름>/queries.sql
   ```

7. 영향받은 쿼리 고치기 · 이 기능의 쿼리 하나 (`/ask`)
8. `README.md` "변경 기록"에 한 줄
9. 커밋 · push — 열어 둔 Pull Request에 자동으로 더해집니다

   ```
   git add teams/<팀이름>
   git commit -m "기능: <기능> (<친 사람>)"
   git push
   ```

## 3. 제출

- 기본을 마치면 내 Fork에서 **Contribute → Open pull request** · 제목 `<팀이름> 설계 프로젝트` · 본문에 팀원 이름
- 그 뒤의 커밋은 push만 하면 같은 Pull Request에 쌓입니다
- **바꾸는 파일은 `teams/<팀이름>/` 아래뿐입니다.** 다른 팀 폴더나 `docs/` · `.claude/`는 고치지 않습니다

## 4. 발표

- 지금의 ERD 한 장
- 가장 컸던 변경 하나 — 무엇이 바뀌었고, 처음부터 알았다면 어떻게 설계했을지
- 틀렸던 SQL 하나 (팀이 쓴 것이든 AI가 쓴 것이든) — 무엇으로 틀린 것을 찾았는지
