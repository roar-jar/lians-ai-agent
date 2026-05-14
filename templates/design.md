# AI 뉴스 브리핑 — Telegram HTML 디자인 템플릿

이 파일은 `news-reporter` 에이전트가 참조하는 Telegram 메시지 디자인 템플릿입니다.  
`{{ }}` 변수 자리에 분석 JSON 데이터를 채워 넣어 최종 메시지를 생성합니다.

---

## 메시지 템플릿

```
🤖 <b>AI 동향 브리핑</b>
<i>{{ week_label }} | 발주사 리스크 관점</i>
<i>📅 {{ date_from }} ~ {{ date_to }}</i>

━━━━━━━━━━━━━━━━━━━

📌 <b>이번 주 동향 요약</b>
{{ weekly_trend }}

━━━━━━━━━━━━━━━━━━━

🔴 <b>TOP 이슈 #1 — {{ issue1.title }}</b>
<code>{{ issue1.category }} | 심각도: {{ issue1.severity }} | 시급성: {{ issue1.urgency }}</code>

{{ issue1.summary }}

⚠️ <b>리스크 우려</b>
{{ issue1.risk_perspective.content }}

✅ <b>기회·대응</b>
{{ issue1.opportunity_perspective.content }}

━━━━━━━━━━━━━━━━━━━

🟠 <b>TOP 이슈 #2 — {{ issue2.title }}</b>
<code>{{ issue2.category }} | 심각도: {{ issue2.severity }} | 시급성: {{ issue2.urgency }}</code>

{{ issue2.summary }}

⚠️ <b>리스크 우려</b>
{{ issue2.risk_perspective.content }}

✅ <b>기회·대응</b>
{{ issue2.opportunity_perspective.content }}

━━━━━━━━━━━━━━━━━━━

🟡 <b>TOP 이슈 #3 — {{ issue3.title }}</b>
<code>{{ issue3.category }} | 심각도: {{ issue3.severity }} | 시급성: {{ issue3.urgency }}</code>

{{ issue3.summary }}

⚠️ <b>리스크 우려</b>
{{ issue3.risk_perspective.content }}

✅ <b>기회·대응</b>
{{ issue3.opportunity_perspective.content }}

━━━━━━━━━━━━━━━━━━━

🎯 <b>이번 주 액션 아이템</b>
▸ {{ action_item_1 }}
▸ {{ action_item_2 }}
▸ {{ action_item_3 }}

━━━━━━━━━━━━━━━━━━━
<i>🤖 AI 오케스트레이터 자동 생성 | {{ analyzed_at }}</i>
```

---

## 변수 매핑표

| 변수 | JSON 경로 | 설명 |
|------|-----------|------|
| `{{ week_label }}` | `meta.week_label` | 예: 2025년 1월 2주차 |
| `{{ date_from }}` | `meta.date_from` | 시작일 |
| `{{ date_to }}` | `meta.date_to` | 종료일 |
| `{{ weekly_trend }}` | `weekly_trend` | 주간 동향 요약 |
| `{{ issue1.title }}` | `top_issues[0].title` | 1위 이슈 제목 |
| `{{ issue1.category }}` | `top_issues[0].category` | 카테고리 |
| `{{ issue1.severity }}` | `top_issues[0].severity` | 심각도 |
| `{{ issue1.urgency }}` | `top_issues[0].urgency` | 시급성 |
| `{{ issue1.summary }}` | `top_issues[0].summary` | 이슈 요약 |
| `{{ issue1.risk_perspective.content }}` | `top_issues[0].risk_perspective.content` | 리스크 시각 |
| `{{ issue1.opportunity_perspective.content }}` | `top_issues[0].opportunity_perspective.content` | 기회 시각 |
| `{{ action_item_1~3 }}` | `action_items[0~2]` | 액션 아이템 |
| `{{ analyzed_at }}` | `meta.analyzed_at` | 분석 일시 |

---

## 심각도·시급성 표시 규칙

| 값 | 한국어 표시 |
|----|------------|
| `high` | 높음 🔴 |
| `medium` | 보통 🟠 |
| `low` | 낮음 🟡 |
| `immediate` | 즉시 대응 |
| `short-term` | 단기 (1-3개월) |
| `mid-term` | 중기 (3-6개월) |

---

## 디자인 가이드

- 이모지는 구분자와 강조 용도로만 사용한다
- 각 이슈 사이에 `━━━` 구분선을 넣어 가독성을 높인다
- 본문 글자는 일반 텍스트, 제목은 `<b>`, 메타 정보는 `<i>` 처리한다
- 카테고리·심각도·시급성은 `<code>` 태그로 한 줄에 표시한다
- 전체 메시지 4096자 초과 시 이슈 3을 별도 메시지로 분리한다
