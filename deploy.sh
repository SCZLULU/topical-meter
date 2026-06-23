#!/bin/bash
# Publie le dashboard Topical Meter (statique) sur GitHub Pages — compte SCZLULU.
# Usage : bash deploy.sh
set -e
cd "$(dirname "$0")"
if [ ! -d .git ]; then
  git init -b main -q
  git add -A
  git -c user.email="sclucas57500@gmail.com" -c user.name="SCZLULU" commit -q -m "Topical Meter — static dashboard"
fi
echo "→ création du dépôt public + push…"
gh repo create topical-meter --public --source=. --remote=origin --push
echo "→ activation de GitHub Pages…"
gh api -X POST repos/SCZLULU/topical-meter/pages -f 'source[branch]=main' -f 'source[path]=/' 2>/dev/null \
 || gh api -X PUT repos/SCZLULU/topical-meter/pages -f 'source[branch]=main' -f 'source[path]=/'
echo ""
echo "✅ Publié — URL (dispo dans 1-2 min, le temps que Pages build) :"
echo "   https://sczlulu.github.io/topical-meter/"
