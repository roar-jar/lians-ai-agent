# 이메일 HTML 디자인 템플릿
## AI 주간 동향 브리핑

---

## 템플릿 사용법

`news-reporter`는 이 파일의 **HTML 섹션**을 기반으로 최종 이메일을 렌더링한다.
`{{변수명}}` 형식의 플레이스홀더를 `weekly_analysis.json` 데이터로 치환한다.

---

## 변수 매핑

| 플레이스홀더 | 데이터 출처 |
|---|---|
| `{{REPORT_DATE}}` | 발송일 (YYYY년 MM월 DD일) |
| `{{PERIOD}}` | 수집 기간 (MM.DD ~ MM.DD) |
| `{{SUMMARY_LINE1}}` | key_summary_3lines.line1 |
| `{{SUMMARY_LINE2}}` | key_summary_3lines.line2 |
| `{{SUMMARY_LINE3}}` | key_summary_3lines.line3 |
| `{{ISSUE1_TITLE}}` | top3_issues[0].title |
| `{{ISSUE1_SUMMARY}}` | top3_issues[0].summary |
| `{{ISSUE1_IMPACT}}` | top3_issues[0].fintech_impact |
| `{{ISSUE2_TITLE}}` | top3_issues[1].title |
| `{{ISSUE2_SUMMARY}}` | top3_issues[1].summary |
| `{{ISSUE2_IMPACT}}` | top3_issues[1].fintech_impact |
| `{{ISSUE3_TITLE}}` | top3_issues[2].title |
| `{{ISSUE3_SUMMARY}}` | top3_issues[2].summary |
| `{{ISSUE3_IMPACT}}` | top3_issues[2].fintech_impact |
| `{{COMPANY_TABLE_ROWS}}` | company_comparison_table (반복 렌더링) |

---

## HTML 템플릿

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AI 주간 동향 브리핑</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif;
      background: #f4f6f9;
      color: #1a1a2e;
    }
    .wrapper {
      max-width: 680px;
      margin: 0 auto;
      background: #ffffff;
    }

    /* 헤더 */
    .header {
      background: linear-gradient(135deg, #0f3460 0%, #16213e 100%);
      padding: 36px 40px 28px;
      text-align: center;
    }
    .header .badge {
      display: inline-block;
      background: rgba(255,255,255,0.15);
      color: #a8d8ea;
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 2px;
      text-transform: uppercase;
      padding: 4px 12px;
      border-radius: 20px;
      margin-bottom: 12px;
    }
    .header h1 {
      color: #ffffff;
      font-size: 24px;
      font-weight: 700;
      line-height: 1.3;
      margin-bottom: 8px;
    }
    .header .period {
      color: #a8d8ea;
      font-size: 13px;
    }

    /* 핵심 요약 박스 */
    .summary-box {
      background: #eef4ff;
      border-left: 4px solid #3a86ff;
      margin: 32px 40px;
      padding: 20px 24px;
      border-radius: 0 8px 8px 0;
    }
    .summary-box .label {
      font-size: 11px;
      font-weight: 700;
      color: #3a86ff;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      margin-bottom: 12px;
    }
    .summary-box ol {
      padding-left: 18px;
    }
    .summary-box li {
      font-size: 14px;
      line-height: 1.7;
      color: #2d3748;
      margin-bottom: 4px;
    }

    /* 섹션 제목 */
    .section-title {
      font-size: 13px;
      font-weight: 700;
      color: #718096;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      padding: 0 40px;
      margin-bottom: 16px;
    }

    /* Top 3 이슈 카드 */
    .issue-card {
      margin: 0 40px 16px;
      border: 1px solid #e2e8f0;
      border-radius: 10px;
      overflow: hidden;
    }
    .issue-card .card-header {
      display: flex;
      align-items: center;
      padding: 14px 20px;
      background: #f8fafc;
      border-bottom: 1px solid #e2e8f0;
    }
    .issue-card .rank {
      width: 28px;
      height: 28px;
      background: #0f3460;
      color: #ffffff;
      font-size: 13px;
      font-weight: 700;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 12px;
      flex-shrink: 0;
    }
    .issue-card .rank.rank-1 { background: #e63946; }
    .issue-card .rank.rank-2 { background: #f4a261; }
    .issue-card .rank.rank-3 { background: #2a9d8f; }
    .issue-card .card-title {
      font-size: 15px;
      font-weight: 600;
      color: #1a202c;
      line-height: 1.4;
    }
    .issue-card .card-body {
      padding: 16px 20px;
    }
    .issue-card .summary-text {
      font-size: 13px;
      color: #4a5568;
      line-height: 1.7;
      margin-bottom: 10px;
    }
    .issue-card .impact-box {
      background: #fffbeb;
      border: 1px solid #fcd34d;
      border-radius: 6px;
      padding: 8px 12px;
    }
    .issue-card .impact-label {
      font-size: 10px;
      font-weight: 700;
      color: #b45309;
      letter-spacing: 1px;
      margin-bottom: 4px;
    }
    .issue-card .impact-text {
      font-size: 12px;
      color: #92400e;
      line-height: 1.6;
    }

    /* 기업 비교 표 */
    .table-wrapper {
      margin: 0 40px 32px;
      border-radius: 10px;
      overflow: hidden;
      border: 1px solid #e2e8f0;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 12px;
    }
    thead tr {
      background: #0f3460;
      color: #ffffff;
    }
    thead th {
      padding: 11px 14px;
      text-align: left;
      font-weight: 600;
      letter-spacing: 0.5px;
    }
    tbody tr:nth-child(even) {
      background: #f8fafc;
    }
    tbody tr:hover {
      background: #eef4ff;
    }
    tbody td {
      padding: 10px 14px;
      color: #2d3748;
      line-height: 1.5;
      border-bottom: 1px solid #e2e8f0;
      vertical-align: top;
    }
    tbody tr:last-child td {
      border-bottom: none;
    }

    /* 구분선 */
    .divider {
      height: 1px;
      background: #e2e8f0;
      margin: 28px 40px;
    }

    /* 푸터 */
    .footer {
      background: #f8fafc;
      border-top: 1px solid #e2e8f0;
      padding: 24px 40px;
      text-align: center;
    }
    .footer p {
      font-size: 11px;
      color: #a0aec0;
      line-height: 1.7;
    }
    .footer .footer-brand {
      font-weight: 700;
      color: #718096;
      margin-bottom: 4px;
    }
  </style>
</head>
<body>
<div class="wrapper">

  <!-- 헤더 -->
  <div class="header">
    <div class="badge">Weekly AI Briefing</div>
    <h1>AI 주간 동향 브리핑</h1>
    <div class="period">{{PERIOD}} 수집 | {{REPORT_DATE}} 발행</div>
  </div>

  <!-- 핵심 요약 -->
  <div style="height:32px;"></div>
  <div class="section-title">이번 주 핵심 요약</div>
  <div class="summary-box">
    <div class="label">Key Insights</div>
    <ol>
      <li>{{SUMMARY_LINE1}}</li>
      <li>{{SUMMARY_LINE2}}</li>
      <li>{{SUMMARY_LINE3}}</li>
    </ol>
  </div>

  <div class="divider"></div>

  <!-- Top 3 이슈 -->
  <div class="section-title">Top 3 이슈</div>

  <div class="issue-card">
    <div class="card-header">
      <div class="rank rank-1">1</div>
      <div class="card-title">{{ISSUE1_TITLE}}</div>
    </div>
    <div class="card-body">
      <div class="summary-text">{{ISSUE1_SUMMARY}}</div>
      <div class="impact-box">
        <div class="impact-label">핀테크 AI 운용 시사점</div>
        <div class="impact-text">{{ISSUE1_IMPACT}}</div>
      </div>
    </div>
  </div>

  <div class="issue-card">
    <div class="card-header">
      <div class="rank rank-2">2</div>
      <div class="card-title">{{ISSUE2_TITLE}}</div>
    </div>
    <div class="card-body">
      <div class="summary-text">{{ISSUE2_SUMMARY}}</div>
      <div class="impact-box">
        <div class="impact-label">핀테크 AI 운용 시사점</div>
        <div class="impact-text">{{ISSUE2_IMPACT}}</div>
      </div>
    </div>
  </div>

  <div class="issue-card">
    <div class="card-header">
      <div class="rank rank-3">3</div>
      <div class="card-title">{{ISSUE3_TITLE}}</div>
    </div>
    <div class="card-body">
      <div class="summary-text">{{ISSUE3_SUMMARY}}</div>
      <div class="impact-box">
        <div class="impact-label">핀테크 AI 운용 시사점</div>
        <div class="impact-text">{{ISSUE3_IMPACT}}</div>
      </div>
    </div>
  </div>

  <div class="divider"></div>

  <!-- 기업별 비교 표 -->
  <div class="section-title">기업별 동향 비교</div>
  <div class="table-wrapper">
    <table>
      <thead>
        <tr>
          <th>기업</th>
          <th>주요 움직임</th>
          <th>핀테크 연관성</th>
          <th>전망</th>
        </tr>
      </thead>
      <tbody>
        {{COMPANY_TABLE_ROWS}}
        <!-- 행 반복 패턴 (news-reporter가 company_comparison_table 배열을 순회하여 생성):
        <tr>
          <td><strong>{company}</strong></td>
          <td>{movement}</td>
          <td>{fintech_relevance}</td>
          <td>{outlook}</td>
        </tr>
        -->
      </tbody>
    </table>
  </div>

  <!-- 푸터 -->
  <div class="footer">
    <p class="footer-brand">AI 주간 동향 브리핑</p>
    <p>
      본 브리핑은 자동화 파이프라인으로 생성되었습니다.<br>
      키워드: AI · 인공지능 · AX · 핀테크 · 금융<br>
      문의 사항은 담당자에게 연락해 주세요.
    </p>
  </div>

</div>
</body>
</html>
```
