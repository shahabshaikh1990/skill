#!/usr/bin/env python3
"""
Rebuild Developer Context in all repo CLAUDE.md files.
Source of truth (in priority order):
  1. ~/brain/context/   ← Obsidian vault repo (once created)
  2. ~/skill/context/   ← fallback
"""

import sys
import subprocess
from pathlib import Path
from datetime import date

HOME = Path.home()
# In CCR remote environments repos live at /home/user; fall back to actual HOME
REPOS_BASE = Path('/home/user') if Path('/home/user/skill').exists() else HOME
REPOS = ['rtk', 'caveman', 'skill', 'Mastermind-Assignment']

# skip_commit_repos: these repos' commits are handled by the caller (brain-update.sh)
SKIP_COMMIT = set(sys.argv[1:])

# ── Find source of truth ──────────────────────────────────────────────────────
CONTEXT_DIR = None
for candidate in [REPOS_BASE / 'brain' / 'context', REPOS_BASE / 'skill' / 'context']:
    if (candidate / 'ABOUTME.md').exists() and (candidate / 'PROJECTS.md').exists():
        CONTEXT_DIR = candidate
        break

if CONTEXT_DIR is None:
    print("ERROR: Cannot find ABOUTME.md + PROJECTS.md. Expected at brain/context/ or skill/context/")
    sys.exit(1)

print(f"Source: {CONTEXT_DIR}")

# Determine which repo name to show in the edit hint
context_repo = 'brain' if 'brain' in str(CONTEXT_DIR) else 'skill'

# ── Read and strip source files ───────────────────────────────────────────────
def read_stripped(path: Path) -> str:
    lines = path.read_text(encoding='utf-8').splitlines()
    out = []
    i = 0
    while i < len(lines):
        line = lines[i]
        # Skip H1 title containing file name markers
        if i == 0 and line.startswith('# ') and ('ABOUTME' in line or 'PROJECTS' in line):
            i += 1
            if i < len(lines) and lines[i] == '':
                i += 1
            continue
        # Skip Last Updated metadata line
        if line.startswith('**Last Updated:**'):
            i += 1
            if i < len(lines) and lines[i] == '':
                i += 1
            continue
        out.append(line)
        i += 1
    return '\n'.join(out).strip()

aboutme  = read_stripped(CONTEXT_DIR / 'ABOUTME.md')
projects = read_stripped(CONTEXT_DIR / 'PROJECTS.md')
today    = date.today().strftime('%B %d, %Y')

NEW_SECTION = f"""
---

## Developer Context

> Auto-updated after each session. Last updated: {today}.
> **Edit source files** at `{context_repo}/context/` — not directly here.
> At end of each session: update `{context_repo}/context/PROJECTS.md` with any status changes before ending.

### About Shahab

{aboutme}

---

### Active Projects

{projects}
"""

# ── Update each CLAUDE.md ────────────────────────────────────────────────────
MARKER = '\n---\n\n## Developer Context'

def rebuild(repo_path: Path) -> bool:
    md = repo_path / 'CLAUDE.md'
    if not md.exists():
        print(f"  [{repo_path.name}] no CLAUDE.md — skipping")
        return False
    content = md.read_text(encoding='utf-8')
    idx = content.find(MARKER)
    new_content = (content[:idx] if idx != -1 else content.rstrip()) + NEW_SECTION
    if new_content == content:
        print(f"  [{repo_path.name}] no change")
        return False
    md.write_text(new_content, encoding='utf-8')
    print(f"  [{repo_path.name}] updated")
    return True

def git_commit_push(repo_path: Path, files: list, message: str):
    try:
        for f in files:
            subprocess.run(['git', 'add', f], cwd=repo_path, check=True)
        # Check if there's anything staged
        r = subprocess.run(['git', 'diff', '--cached', '--quiet'], cwd=repo_path)
        if r.returncode == 0:
            return  # nothing staged
        subprocess.run(['git', 'commit', '-m', message], cwd=repo_path, check=True)
        branch = subprocess.check_output(
            ['git', 'branch', '--show-current'], cwd=repo_path, text=True
        ).strip()
        subprocess.run(['git', 'push', '-u', 'origin', branch], cwd=repo_path, check=True)
        print(f"  [{repo_path.name}] pushed ✓")
    except subprocess.CalledProcessError as e:
        print(f"  [{repo_path.name}] git error: {e}")

today_iso = date.today().isoformat()
commit_msg = f"brain: auto-rebuild Developer Context — {today_iso}"

for repo in REPOS:
    path = REPOS_BASE / repo
    if not path.exists():
        continue
    changed = rebuild(path)
    if changed and repo not in SKIP_COMMIT:
        git_commit_push(path, ['CLAUDE.md'], commit_msg)
