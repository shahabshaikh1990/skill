#!/bin/bash
# setup-hooks.sh — Install brain-update Stop hook into ~/.claude/
# Run this at the start of a new CCR session if hooks are missing.
# Usage: bash /home/user/skill/scripts/setup-hooks.sh

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPTS_DIR="$SKILL_DIR/scripts"

# Resolve actual home (.claude lives at /root/.claude in CCR)
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"

echo "Installing brain scripts from: $SCRIPTS_DIR"
echo "Claude config dir: $CLAUDE_DIR"

# Copy scripts to ~/.claude/
cp "$SCRIPTS_DIR/brain-update.sh"  "$CLAUDE_DIR/brain-update.sh"
cp "$SCRIPTS_DIR/rebuild_brain.py" "$CLAUDE_DIR/rebuild_brain.py"
chmod +x "$CLAUDE_DIR/brain-update.sh"

echo "Copied brain-update.sh and rebuild_brain.py"

# ── Merge Stop hook into launcher-settings.json ────────────────────────────────
SETTINGS="$CLAUDE_DIR/launcher-settings.json"

if [[ ! -f "$SETTINGS" ]]; then
  cat > "$SETTINGS" <<'EOF'
{
  "Stop": [
    {
      "matcher": "",
      "hooks": [
        {"type": "command", "command": "~/.claude/brain-update.sh"}
      ]
    }
  ]
}
EOF
  echo "Created $SETTINGS with brain-update Stop hook"
else
  # Check if brain-update is already wired
  if grep -q 'brain-update' "$SETTINGS"; then
    echo "brain-update hook already present in $SETTINGS"
  else
    echo "NOTE: $SETTINGS exists but brain-update hook not found."
    echo "Add manually:"
    echo '  {"type": "command", "command": "~/.claude/brain-update.sh"}'
    echo "to the Stop hooks array."
  fi
fi

echo ""
echo "Setup complete. Brain update hook is ready."
echo "It will run automatically at session end."
