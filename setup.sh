#!/bin/bash
# Addie's AI Jams — one-time setup script
# Run this from the addies-ai-jams folder

set -e

REPO="addies-ai-jams"
GITHUB_USER="flamingquaks"

echo ""
echo "🎵  Setting up $REPO on GitHub..."
echo ""

# Check for gh CLI
if ! command -v gh &>/dev/null; then
  echo "❌  GitHub CLI (gh) not found."
  echo "   Install it from: https://cli.github.com"
  echo "   Then run: gh auth login"
  exit 1
fi

# Check auth
if ! gh auth status &>/dev/null; then
  echo "👤  Logging in to GitHub..."
  gh auth login
fi

# Create repo
echo "📦  Creating public repo $GITHUB_USER/$REPO..."
gh repo create "$GITHUB_USER/$REPO" \
  --public \
  --description "Addie's AI-generated songs" \
  --source . \
  --remote origin \
  --push

# Enable GitHub Pages (main branch, root)
echo "🌐  Enabling GitHub Pages..."
gh api "repos/$GITHUB_USER/$REPO/pages" \
  --method POST \
  --field source[branch]=main \
  --field source[path]="/" 2>/dev/null || \
  echo "   (Pages may already be enabled, or enable manually in Settings → Pages)"

echo ""
echo "✅  Done! Your site will be live at:"
echo "   https://$GITHUB_USER.github.io/$REPO"
echo ""
echo "──────────────────────────────────────────"
echo "Next step: add your Google Sheet CSV URL"
echo ""
echo "1. Open your Google Sheet"
echo "2. File → Share → Publish to web"
echo "3. Change dropdown to 'Comma-separated values (.csv)'"
echo "4. Click Publish and copy the URL"
echo "5. Go to: https://github.com/$GITHUB_USER/$REPO/settings/variables/actions"
echo "6. Click 'New repository variable'"
echo "7. Name: SHEET_CSV_URL   Value: (paste the URL)"
echo "──────────────────────────────────────────"
echo ""
echo "After that, go to Actions → Sync Songs from Google Sheets"
echo "and click 'Run workflow' to sync immediately."
echo ""
