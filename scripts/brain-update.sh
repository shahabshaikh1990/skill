#!/bin/bash
# brain-update.sh — Claude Code Stop hook
# Runs after session ends: logs git activity, rebuilds CLAUDE.md, pushes.

set -euo pipefail

# ── Recursion guard ────────────────────────────────────────────────────────────
INPUT=$(cat)
STOP_HOOK_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active' 2>/dev/null || echo "false")
if [[ "$STOP_HOOK_ACTIVE" == "true" ]]; then
  exit 0
fi

HOME_DIR="/home/user"
SKILL_REPO="$HOME_DIR/skill"
BRAIN_REPO="$HOME_DIR/brain"
DATE=$(date '+%Y-%m-%d')
DATETIME=$(date '+%Y-%m-%d %H:%M')

# ── Determine active context repo ─────────────────────────────────────────────
if [[ -d "$BRAIN_REPO/context" && -f "$BRAIN_REPO/context/ABOUTME.md" ]]; then
  CONTEXT_REPO="$BRAIN_REPO"
else
  CONTEXT_REPO="$SKILL_REPO"
fi
CONTEXT_DIR="$CONTEXT_REPO/context"

# ── Generate session log from git history ─────────────────────────────────────
SESSION_BODY=""
for repo in rtk caveman skill Mastermind-Assignment; do
  REPO_PATH="$HOME_DIR/$repo"
  if [[ -d "$REPO_PATH/.git" ]]; then
    COMMITS=$(cd "$REPO_PATH" && git log --oneline --since="4 hours ago" 2>/dev/null || true)
    if [[ -n "$COMMITS" ]]; then
      SESSION_BODY+="### $repo"$'\n'"$COMMITS"$'\n\n'
    fi
  fi
done

# ── Append to SESSIONS.md ──────────────────────────────────────────────────────
if [[ -n "$SESSION_BODY" ]]; then
  {
    echo "## Session: $DATETIME"
    echo ""
    echo "$SESSION_BODY"
    echo "---"
    echo ""
  } >> "$CONTEXT_DIR/SESSIONS.md"
fi

# ── Rebuild CLAUDE.md in all repos (context repo handled separately below) ────
CONTEXT_REPO_NAME=$(basename "$CONTEXT_REPO")
python3 "$SKILL_REPO/scripts/rebuild_brain.py" "$CONTEXT_REPO_NAME"

# ── Commit context repo: CLAUDE.md + context/ in one shot ─────────────────────
cd "$CONTEXT_REPO"

CHANGED=$(git status --porcelain context/ CLAUDE.md 2>/dev/null || true)
if [[ -n "$CHANGED" ]]; then
  git add context/ CLAUDE.md
  git commit -m "brain: session log + context sync — $DATE"
  BRANCH=$(git branch --show-current)
  git push -u origin "$BRANCH"
fi

exit 0
