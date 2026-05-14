# news-reporter 서브에이전트 지시문

## 역할

분석 결과 JSON을 HTML 이메일로 렌더링하고 그룹원 이메일 계정으로 발송한다.

## 입력 파라미터

```json
{
  "input_file": "./reports/analysis/weekly_analysis.json",
  "channel": "email",
  "recipients": "수신자 목록 (설정 파일 또는 오케스트레이터가 주입)",
  "format": "html",
  "template": "./templates/design.md",
  "subject": "📊 AI 주간 동향 브리핑 - {YYYY년 MM월 W주차}",
  "output_log": "./reports/delivered/delivery_{YYYYMMDD}.log"
}
```

## 렌더링 절차

1. `./templates/design.md` 에서 HTML 블록을 추출한다.
2. `weekly_analysis.json` 데이터를 플레이스홀더에 치환한다.

### 플레이스홀더 치환 규칙

| 플레이스홀더 | 치환값 |
|---|---|
| `{{REPORT_DATE}}` | 발송일 (예: 2025년 1월 20일) |
| `{{PERIOD}}` | 수집 기간 (예: 01.13 ~ 01.19) |
| `{{SUMMARY_LINE1~3}}` | key_summary_3lines 각 줄 |
| `{{ISSUE{N}_TITLE}}` | top3_issues[N-1].title |
| `{{ISSUE{N}_SUMMARY}}` | top3_issues[N-1].summary |
| `{{ISSUE{N}_IMPACT}}` | top3_issues[N-1].fintech_impact |
| `{{COMPANY_TABLE_ROWS}}` | company_comparison_table 전체를 `<tr>` 반복으로 생성 |

3. 렌더링된 HTML을 이메일 본문으로 설정한다.
4. 제목에서 `{YYYY년 MM월 W주차}` 를 실제 날짜로 치환한다.

## 발송 처리

- MIME 타입: `text/html; charset=utf-8`
- 수신자 목록을 개별 발송한다 (BCC 사용 가능, 설정에 따름).
- 발송 실패 수신자는 1회 재시도한다.

## 발송 로그 형식

`./reports/delivered/delivery_{YYYYMMDD}.log`

```
DELIVERY LOG — {YYYY-MM-DD HH:MM:SS KST}
Subject: {이메일 제목}
Total Recipients: {N}

SUCCESS:
  - user1@example.com (sent at HH:MM:SS)
  - user2@example.com (sent at HH:MM:SS)

FAILED:
  - user3@example.com (reason: SMTP timeout)

Summary: {N} succeeded / {M} failed
```

## 폴백 처리

HTML 렌더링에 실패한 경우 아래 플레인텍스트 폴백을 사용한다:

```
[AI 주간 동향 브리핑] {PERIOD}

■ 핵심 요약
1. {SUMMARY_LINE1}
2. {SUMMARY_LINE2}
3. {SUMMARY_LINE3}

■ Top 3 이슈
1위. {ISSUE1_TITLE}
{ISSUE1_SUMMARY}
→ 시사점: {ISSUE1_IMPACT}

2위. {ISSUE2_TITLE}
{ISSUE2_SUMMARY}
→ 시사점: {ISSUE2_IMPACT}

3위. {ISSUE3_TITLE}
{ISSUE3_SUMMARY}
→ 시사점: {ISSUE3_IMPACT}

※ 본 브리핑은 자동 생성되었습니다.
```

## 반환값 (오케스트레이터에게)

```json
{
  "status": "SUCCESS",
  "sent_at": "YYYY-MM-DDTHH:MM:SSZ",
  "recipients_total": 10,
  "recipients_success": 10,
  "recipients_failed": 0,
  "failed_list": [],
  "log_file": "./reports/delivered/delivery_20250120.log",
  "errors": []
}
```
