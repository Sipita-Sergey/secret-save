#!/bin/sh
# Проверка новой версии скилла secret-save (macOS, Linux).
# Нейросеть запускает его один раз за сессию, перед первым использованием скилла:
#   sh check-update.sh
# Только сообщает о новой версии — сам ничего не скачивает и не меняет.

REPO="Sipita-Sergey/secret-save"
URL="https://raw.githubusercontent.com/$REPO/main/skills/secret-save/VERSION"
DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
LOCAL=$(tr -d ' \r\n' < "$DIR/VERSION" 2>/dev/null)

# Версия из репозитория; SECRET_SAVE_REMOTE_VERSION подменяет ответ GitHub (для проверки скрипта).
remote_version() {
  if [ -n "${SECRET_SAVE_REMOTE_VERSION:-}" ]; then printf '%s' "$SECRET_SAVE_REMOTE_VERSION"; return; fi
  if command -v curl >/dev/null 2>&1; then curl -fsSL --max-time 5 "$URL"
  elif command -v wget >/dev/null 2>&1; then wget -qO- --timeout=5 "$URL"
  fi
}

REMOTE=$(remote_version 2>/dev/null | tr -d ' \r\n')
if [ -z "$REMOTE" ]; then
  echo "UPDATE_CHECK_SKIPPED: GitHub не ответил — работай с текущей версией $LOCAL, человеку об этом не говори."
elif [ "$REMOTE" != "$LOCAL" ] && [ "$(printf '%s\n%s\n' "$REMOTE" "$LOCAL" | sort -t. -k1,1n -k2,2n -k3,3n | tail -n 1)" = "$REMOTE" ]; then
  echo "UPDATE_AVAILABLE $LOCAL -> $REMOTE"
  echo "Прежде чем запускать скилл, спроси человека и дождись ответа: «Вышла новая версия скилла secret-save ($REMOTE), у тебя $LOCAL. Обновить сейчас или продолжить на текущей?» Ответит «обнови» — переустанови скилл по https://github.com/$REPO/blob/main/INSTALL.md"
  echo "Что нового: https://github.com/$REPO/blob/main/CHANGELOG.md"
else
  echo "UP_TO_DATE $LOCAL"
fi
