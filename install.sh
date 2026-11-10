#!/bin/bash
# Wheeking 🐾 installer:
#   curl -fsSL https://raw.githubusercontent.com/SubzeroQ/wheeking-releases/main/install.sh | bash
#
# Downloads the latest release, puts it into /Applications and starts it. Files fetched with curl are
# not marked "downloaded from the internet", so macOS opens the app without the Gatekeeper block that
# a browser-downloaded, non-notarized app gets.
# Test overrides: WHEEKING_DIR (install folder), WHEEKING_NO_OPEN=1 (don't launch), WHEEKING_URL.
set -euo pipefail

URL="${WHEEKING_URL:-https://github.com/SubzeroQ/wheeking-releases/releases/latest/download/Wheeking.zip}"
DIR="${WHEEKING_DIR:-/Applications}"
APP="$DIR/Wheeking.app"

major=$(sw_vers -productVersion | cut -d. -f1)
if [ "$major" -lt 14 ]; then
  echo "Wheeking потребує macOS 14 або новішої (у вас $(sw_vers -productVersion))." >&2
  exit 1
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "🐾 Завантажую Wheeking…"
curl -fL --progress-bar "$URL" -o "$TMP/Wheeking.zip"
ditto -x -k "$TMP/Wheeking.zip" "$TMP/unpacked"
if [ ! -d "$TMP/unpacked/Wheeking.app" ]; then
  echo "Не вдалося розпакувати архів." >&2
  exit 1
fi

if [ -z "${WHEEKING_DIR:-}" ] && pgrep -xq Wheeking; then
  echo "Закриваю запущений Wheeking…"
  osascript -e 'quit app "Wheeking"' >/dev/null 2>&1 || pkill -x Wheeking || true
  sleep 1
fi

echo "Встановлюю в $DIR…"
SUDO=""
if [ ! -w "$DIR" ] || { [ -e "$APP" ] && [ ! -w "$APP" ]; }; then
  echo "Потрібен пароль адміністратора, щоб записати в $DIR."
  SUDO="sudo"
fi
$SUDO rm -rf "$APP"
$SUDO ditto "$TMP/unpacked/Wheeking.app" "$APP"
$SUDO xattr -dr com.apple.quarantine "$APP" 2>/dev/null || true

if [ -z "${WHEEKING_NO_OPEN:-}" ]; then
  open "$APP"
  echo "✅ Готово! Шукайте лапки 🐾 у рядку меню вгорі. Wheeking попросить дозвіл «Універсальний доступ»."
else
  echo "✅ Встановлено в $APP"
fi
