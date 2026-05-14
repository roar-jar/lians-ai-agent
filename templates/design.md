# 텔레그램 브리핑 HTML 디자인 템플릿

텔레그램 `parse_mode: HTML` 기준으로 작성된 메시지 템플릿입니다.
`{변수명}` 형태의 플레이스홀더를 실제 값으로 치환하여 사용합니다.

---

## 전체 메시지 구조

```html
🗞 <b>AI·금융 주간 브리핑</b>
<i>{start_date} ~ {end_date}</i>
━━━━━━━━━━━━━━━━━━━━━━

📌 이번 주 핵심 이슈 Top 3
<b>발주사 리스크 관점</b>

━━━━━━━━━━━━━━━━━━━━━━
🔴 <b>TOP 1. {issue_1_title}</b>
━━━━━━━━━━━━━━━━━━━━━━
⚠️ 리스크 점수: <b>{issue_1_score}/10</b> | 관련 기사 {issue_1_count}건

{issue_1_summary}

🟢 <b>기회 측면</b>
<blockquote>{issue_1_opportunity}</blockquote>

🔴 <b>위협 측면</b>
<blockquote>{issue_1_threat}</blockquote>

📎 <a href="{issue_1_article_1_url}">{issue_1_article_1_title}</a> — <i>{issue_1_article_1_source}</i>

━━━━━━━━━━━━━━━━━━━━━━
🟠 <b>TOP 2. {issue_2_title}</b>
━━━━━━━━━━━━━━━━━━━━━━
⚠️ 리스크 점수: <b>{issue_2_score}/10</b> | 관련 기사 {issue_2_count}건

{issue_2_summary}

🟢 <b>기회 측면</b>
<blockquote>{issue_2_opportunity}</blockquote>

🔴 <b>위협 측면</b>
<blockquote>{issue_2_threat}</blockquote>

📎 <a href="{issue_2_article_1_url}">{issue_2_article_1_title}</a> — <i>{issue_2_article_1_source}</i>

━━━━━━━━━━━━━━━━━━━━━━
🟡 <b>TOP 3. {issue_3_title}</b>
━━━━━━━━━━━━━━━━━━━━━━
⚠️ 리스크 점수: <b>{issue_3_score}/10</b> | 관련 기사 {issue_3_count}건

{issue_3_summary}

🟢 <b>기회 측면</b>
<blockquote>{issue_3_opportunity}</blockquote>

🔴 <b>위협 측면</b>
<blockquote>{issue_3_threat}</blockquote>

📎 <a href="{issue_3_article_1_url}">{issue_3_article_1_title}</a> — <i>{issue_3_article_1_source}</i>

━━━━━━━━━━━━━━━━━━━━━━
📊 <b>주간 총평</b>

{weekly_summary}

━━━━━━━━━━━━━━━━━━━━━━
<i>🤖 AI 뉴스 브리핑 · 자동 생성</i>
```

---

## 변수 목록

| 변수명 | 설명 | 예시 |
|--------|------|------|
| `{start_date}` | 브리핑 시작일 | `2026-05-04 (월)` |
| `{end_date}` | 브리핑 종료일 | `2026-05-10 (일)` |
| `{issue_N_title}` | N번째 이슈 제목 | `금융권 AI 규제 강화` |
| `{issue_N_score}` | N번째 이슈 리스크 점수 | `8.5` |
| `{issue_N_count}` | N번째 이슈 관련 기사 수 | `12` |
| `{issue_N_summary}` | N번째 이슈 요약 (3~5문장) | - |
| `{issue_N_opportunity}` | N번째 이슈 기회 측면 | - |
| `{issue_N_threat}` | N번째 이슈 위협 측면 | - |
| `{issue_N_article_1_url}` | N번째 이슈 대표 기사 URL | `https://...` |
| `{issue_N_article_1_title}` | N번째 이슈 대표 기사 제목 | - |
| `{issue_N_article_1_source}` | N번째 이슈 대표 기사 출처 | `한국경제` |
| `{weekly_summary}` | 주간 전체 총평 (3~5문장) | - |

---

## 작성 규칙

1. **길이 제한**: 전체 메시지는 4096자 이내. 초과 시 TOP 1~2 / TOP 3+총평으로 분할
2. **이스케이프**: HTML 특수문자는 반드시 이스케이프
   - `&` → `&amp;`
   - `<` → `&lt;`
   - `>` → `&gt;`
3. **링크**: `<a href>` 태그 내 URL에 특수문자 포함 시 URL 인코딩 처리
4. **줄바꿈**: 빈 줄은 `\n\n`으로 표현 (텔레그램은 `<br>` 미지원)
5. **이모지**: 텔레그램에서 이모지 렌더링 지원, 적절히 활용하여 가독성 향상
6. **blockquote**: 텔레그램 최신 클라이언트에서만 지원. 미지원 환경에서는 `│ ` 접두사로 대체

---

## 실제 메시지 예시

```
🗞 AI·금융 주간 브리핑
2026-05-04 (월) ~ 2026-05-10 (일)
━━━━━━━━━━━━━━━━━━━━━━

📌 이번 주 핵심 이슈 Top 3
발주사 리스크 관점

━━━━━━━━━━━━━━━━━━━━━━
🔴 TOP 1. 금융위, AI 기반 여신심사 가이드라인 발표
━━━━━━━━━━━━━━━━━━━━━━
⚠️ 리스크 점수: 9.2/10 | 관련 기사 14건

금융위원회가 AI를 활용한 여신심사 시스템에 대한 규제 가이드라인을 발표했습니다.
금융사는 AI 의사결정에 대한 설명 가능성과 공정성 확보 의무를 갖게 됩니다.
오는 7월부터 단계적 적용이 예정되어 있어 시스템 개편이 불가피합니다.

🟢 기회 측면
│ 선제적 컴플라이언스 대응으로 시장 신뢰도 확보 가능.
│ 규제 준수 시스템 구축 수요가 신규 사업 기회로 연결될 수 있습니다.

🔴 위협 측면
│ 기존 AI 여신 시스템의 전면 재검토 및 개편 비용 발생.
│ 준비 기간 부족으로 7월 시행 시 영업 차질 우려가 있습니다.

📎 "금융위, AI 여신심사 가이드라인 7월 시행" — 한국경제
```
