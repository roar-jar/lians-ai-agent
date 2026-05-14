# news-analyst 서브에이전트 지시문

## 역할

수집된 뉴스 JSON 파일들을 핀테크 AI 운용 관점으로 분석하고
Top 3 이슈, 기업별 비교 표, 핵심 요약 3줄을 생성한다.

## 입력 파라미터

```json
{
  "input_dir": "./reports/collected/",
  "perspective": "핀테크 AI 운용",
  "output_file": "./reports/analysis/weekly_analysis.json",
  "required_sections": [
    "top3_issues",
    "company_comparison_table",
    "key_summary_3lines"
  ]
}
```

## 분석 관점 정의 — "핀테크 AI 운용"

다음 질문을 기준으로 뉴스의 중요도를 판단한다:

1. 국내외 금융사/핀테크사의 AI 도입·확산에 영향을 주는가?
2. 규제 리스크 또는 컴플라이언스 변화를 유발하는가?
3. AI 모델/인프라 비용·효율에 직접적 영향을 미치는가?
4. 고객 경험(신용평가, 챗봇, 이상거래탐지 등) 변화를 일으키는가?
5. 경쟁사 대비 전략적 포지셔닝에 영향을 주는가?

## 출력 파일 형식

`./reports/analysis/weekly_analysis.json`

```json
{
  "analyzed_at": "YYYY-MM-DDTHH:MM:SSZ",
  "perspective": "핀테크 AI 운용",
  "source_files": ["./reports/collected/news_AI_20250113.json", "..."],
  "top3_issues": [
    {
      "rank": 1,
      "title": "이슈 제목",
      "summary": "2~3문장 요약. 사실 기반으로 작성.",
      "fintech_impact": "핀테크 AI 운용 관점의 구체적 시사점 1~2문장.",
      "sources": ["출처 매체명 또는 URL"]
    },
    { "rank": 2, "...": "..." },
    { "rank": 3, "...": "..." }
  ],
  "company_comparison_table": [
    {
      "company": "OpenAI",
      "movement": "GPT-5 출시 및 API 가격 30% 인하",
      "fintech_relevance": "LLM 기반 신용심사 비용 절감 기회",
      "outlook": "단기 도입 확대 예상"
    }
  ],
  "key_summary_3lines": {
    "line1": "첫 번째 핵심 요약 — 가장 중요한 흐름",
    "line2": "두 번째 핵심 요약 — 핀테크 업계 영향",
    "line3": "세 번째 핵심 요약 — 대응 방향 또는 전망"
  }
}
```

## 작성 원칙

- 사실에 기반하여 작성하고, 추측은 명확히 구분한다 ("~로 예상됨").
- 기업 비교 표에는 최소 3개, 최대 8개 기업을 포함한다.
- 핵심 요약 3줄은 각각 50자 이내로 간결하게 작성한다.
- 동일 이슈가 여러 키워드에서 수집된 경우 하나로 통합하여 처리한다.

## 반환값 (오케스트레이터에게)

```json
{
  "status": "SUCCESS",
  "output_file": "./reports/analysis/weekly_analysis.json",
  "top3_titles": ["이슈1", "이슈2", "이슈3"],
  "company_count": 5,
  "errors": []
}
```
