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
echo "🔐  SECURITY NOTE"
echo ""
echo "The Google Sheet URL is stored as a GitHub SECRET (encrypted),"
echo "not a plain-text variable. This means:"
echo "  ✓ It is never visible to anyone who views the repo"
echo "  ✓ It is never printed in Action logs"
echo "  ✓ It is never included in any file committed to git"
echo "  ✓ Only GitHub Actions workflows in this repo can read it"
echo ""
echo "──────────────────────────────────────────"
echo "Next step: add your Google Sheet CSV URL as a Secret"
echo ""
echo "Step 1 — Publish your Google Sheet as CSV:"
echo "  a. Open your Google Sheet"
echo "  b. File → Share → Publish to web"
echo "  c. Change the format dropdown to 'Comma-separated values (.csv)'"
echo "  d. Click 'Publish' and copy the URL"
echo "  ⚠️  Do NOT paste this URL anywhere in the repo or share it publicly"
echo ""
echo "Step 2 — Add it as an encrypted GitHub Secret:"
echo "  a. Go to: https://github.com/$GITHUB_USER/$REPO/settings/secrets/actions"
echo "  b. Click 'New repository secret'"
echo "  c. Name:  SHEET_CSV_URL"
echo "  d. Value: (paste the URL — it will be encrypted immediately)"
echo "  e. Click 'Add secret'"
echo ""
echo "Step 3 — Run the first sync:"
echo "  a. Go to: https://github.com/$GITHUB_USER/$REPO/actions"
echo "  b. Click 'Sync Songs from Google Sheets'"
echo "  c. Click 'Run workflow' → 'Run workflow'"
echo "  d. Your songs will appear on the site within ~60 seconds"
echo ""
echo "──────────────────────────────────────────"
echo "After setup, the sync runs automatically every hour."
echo "To force an immediate update, repeat Step 3."
echo ""
