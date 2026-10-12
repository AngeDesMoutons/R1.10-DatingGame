#!/usr/bin/env bash
# Installe uniquement Tweego dans ./tools/tweego (sans droits administrateur)
set -euo pipefail
URL="https://github.com/tmedwards/tweego/releases/download/v2.1.1/tweego-2.1.1-linux-x64.zip"
cd "$(dirname "$0")"

if [ -x tools/tweego/tweego ]; then
  echo "Tweego est déjà installé dans tools/tweego."
else
  mkdir -p tools/tweego
  echo "Téléchargement de Tweego..."
  curl -fsSL -o tools/tweego.zip "$URL"
  if command -v unzip >/dev/null 2>&1; then unzip -q -o tools/tweego.zip -d tools/tweego
  else python3 -m zipfile -e tools/tweego.zip tools/tweego; fi
  rm tools/tweego.zip
  chmod +x tools/tweego/tweego
  echo "Tweego installé."
fi
mkdir -p dist

echo
echo "Pour compiler (à faire dans chaque nouveau terminal) :"
echo '  export PATH="$PWD/tools/tweego:$PATH" TWEEGO_PATH="$PWD/storyformats"'
echo '  tweego -o dist/index.html src --watch'
