#!/usr/bin/env bash
# Telegram 봇 연결 테스트 스크립트 (@lians_ai_bot)
# 사용법: bash scripts/test-telegram.sh

set -euo pipefail

# ── 환경변수 로드 ─────────────────────────────────────────
if [ -f ".env" ]; then
  # shellcheck disable=SC1091
  export $(grep -v '^#' .env | grep -v '^$' | xargs)
fi

# ── 필수값 확인 ───────────────────────────────────────────
if [ -z "${TELEGRAM_BOT_TOKEN:-}" ]; then
  echo "❌ TELEGRAM_BOT_TOKEN 이 설정되지 않았습니다."
  echo "   .env.example 을 참고하여 .env 파일을 생성하세요."
  exit 1
fi

BASE_URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Telegram 봇 연결 테스트"
echo "  Bot: @lians_ai_bot"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ── 1. getMe — 봇 정보 확인 ───────────────────────────────
echo "▶ [1/3] 봇 정보 조회 (getMe)..."
GET_ME=$(curl -s "${BASE_URL}/getMe")

OK=$(echo "$GET_ME" | grep -o '"ok":[a-z]*' | cut -d: -f2)
if [ "$OK" != "true" ]; then
  echo "❌ getMe 실패: $GET_ME"
  exit 1
fi

BOT_ID=$(echo "$GET_ME"     | grep -o '"id":[0-9]*'         | head -1 | cut -d: -f2)
BOT_NAME=$(echo "$GET_ME"   | grep -o '"first_name":"[^"]*"' | cut -d'"' -f4)
BOT_USER=$(echo "$GET_ME"   | grep -o '"username":"[^"]*"'   | cut -d'"' -f4)
echo "✅ 봇 연결 성공"
echo "   ID       : $BOT_ID"
echo "   이름     : $BOT_NAME"
echo "   Username : @$BOT_USER"
echo ""

# ── 2. getUpdates — Chat ID 확인 ──────────────────────────
echo "▶ [2/3] 최근 메시지에서 Chat ID 조회 (getUpdates)..."
UPDATES=$(curl -s "${BASE_URL}/getUpdates?limit=5")
OK=$(echo "$UPDATES" | grep -o '"ok":[a-z]*' | cut -d: -f2)

if [ "$OK" = "true" ]; then
  CHAT_IDS=$(echo "$UPDATES" | grep -o '"chat":{"id":[^,]*' | grep -o '[0-9-]*$' | sort -u)
  if [ -n "$CHAT_IDS" ]; then
    echo "✅ 감지된 Chat ID 목록:"
    echo "$CHAT_IDS" | while read -r id; do
      echo "   → $id"
    done
    echo ""
    echo "   💡 .env 의 TELEGRAM_CHAT_ID 에 위 ID 중 하나를 입력하세요."
  else
    echo "ℹ️  최근 메시지 없음. 봇에게 먼저 메시지를 보내면 Chat ID가 나타납니다."
    echo "   @lians_ai_bot 을 열고 /start 를 입력해 보세요."
  fi
else
  echo "⚠️  getUpdates 실패 (봇이 webhook 모드일 경우 정상): $UPDATES"
fi
echo ""

# ── 3. sendMessage — 테스트 메시지 발송 ──────────────────
if [ -z "${TELEGRAM_CHAT_ID:-}" ]; then
  echo "⏭  [3/3] TELEGRAM_CHAT_ID 미설정 → sendMessage 테스트 건너뜀"
  echo "   .env 에 TELEGRAM_CHAT_ID 를 설정한 뒤 다시 실행하세요."
else
  echo "▶ [3/3] 테스트 메시지 발송 (sendMessage → Chat $TELEGRAM_CHAT_ID)..."
  MSG="🤖 <b>연결 테스트 성공</b>%0A@lians_ai_bot 이 정상 작동 중입니다.%0A%0A<i>AI 뉴스 브리핑 파이프라인 준비 완료 ✅</i>"
  SEND=$(curl -s -X POST "${BASE_URL}/sendMessage" \
    -H "Content-Type: application/json" \
    -d "{
      \"chat_id\": \"${TELEGRAM_CHAT_ID}\",
      \"text\": \"🤖 <b>연결 테스트 성공</b>\n@lians_ai_bot 이 정상 작동 중입니다.\n\n<i>AI 뉴스 브리핑 파이프라인 준비 완료 ✅</i>\",
      \"parse_mode\": \"HTML\"
    }")

  OK=$(echo "$SEND" | grep -o '"ok":[a-z]*' | cut -d: -f2)
  if [ "$OK" = "true" ]; then
    MSG_ID=$(echo "$SEND" | grep -o '"message_id":[0-9]*' | cut -d: -f2)
    echo "✅ 메시지 발송 성공 (message_id: $MSG_ID)"
  else
    ERR_CODE=$(echo "$SEND" | grep -o '"error_code":[0-9]*' | cut -d: -f2)
    ERR_DESC=$(echo "$SEND" | grep -o '"description":"[^"]*"' | cut -d'"' -f4)
    echo "❌ 발송 실패 (error_code: $ERR_CODE)"
    echo "   원인: $ERR_DESC"
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  테스트 완료"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
