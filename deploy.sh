#!/bin/bash
# Publie le dashboard Topical Meter (statique) sur GitHub Pages — compte SCZLULU.
# Usage : bash deploy.sh
set -e
cd "$(dirname "$0")"
git init -b main -q 2>/dev/null || true
git add -A
git -c user.email="sclucas57500@gmail.com" -c user.name="SCZLULU" commit -q -m "Topical Meter — static dashboard" 2>/dev/null || echo "  (rien de nouveau à committer)"
echo "→ création du dépôt public + push…"
if gh repo view SCZLULU/topical-meter >/dev/null 2>&1; then
  echo "  (dépôt déjà existant) → push de la mise à jour"
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/SCZLULU/topical-meter.git"
  git push -u origin main
else
  gh repo create topical-meter --public --source=. --remote=origin --push
fi
echo "→ activation de GitHub Pages…"
gh api -X POST repos/SCZLULU/topical-meter/pages -f 'source[branch]=main' -f 'source[path]=/' 2>/dev/null \
 || gh api -X PUT repos/SCZLULU/topical-meter/pages -f 'source[branch]=main' -f 'source[path]=/' 2>/dev/null \
 || echo "  (Pages déjà activé)"
echo ""
echo "✅ Publié — URL (dispo dans 1-2 min, le temps que Pages build) :"
echo "   https://sczlulu.github.io/topical-meter/"
