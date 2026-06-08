# Obsidian + Claude — Setup Guide

## What this system does

```
Obsidian vault (Windows)
        ↕  Obsidian Git plugin auto-sync
GitHub repo: shahabshaikh1990/brain  (private)
        ↑
brain-update.sh pushes at session end
        ↑
Claude Code Stop hook (CCR web or local terminal)
```

- `skill/context/` = source of truth **RIGHT NOW** (until brain repo is set up)
- `brain/context/` = source of truth **AFTER** you complete Step 1–3 below
- All 4 repo CLAUDE.md files are auto-rebuilt at session end

---

## Step 1 — Create the GitHub brain repo

Go to github.com → **New repository**
- **Name:** `brain`
- **Private:** yes
- **Initialize with README:** no (empty repo)

Click "Create repository". Copy the HTTPS URL shown.

---

## Step 2 — Clone + move context files (Windows PowerShell)

```powershell
# Clone the brain repo
git clone https://github.com/shahabshaikh1990/brain.git C:\Users\shaha\brain

# Create context folder
New-Item -ItemType Directory -Path "C:\Users\shaha\brain\context"

# Copy existing context files from skill repo
Copy-Item "C:\Users\shaha\skill\context\*" "C:\Users\shaha\brain\context\" -Force

# Push to GitHub
cd C:\Users\shaha\brain
git add .
git commit -m "init: personal knowledge base"
git push
```

---

## Step 3 — Set up Obsidian Git plugin

1. Open Obsidian → **Settings** → **Community plugins** → **Browse**
2. Search: **Obsidian Git** → Install → Enable
3. Go to **Settings** → **Obsidian Git**:
   - **Custom base path**: leave empty (Obsidian uses its vault as the git root)
4. Point your vault AT the brain repo:
   - Close Obsidian
   - **Move** (or point) your vault to `C:\Users\shaha\brain\`
     - OR: Open existing vault at `C:\Users\shaha\brain\` if you keep the current vault separate
   - Reopen Obsidian

5. In Obsidian Git settings:
   - **Auto pull interval:** 5 minutes
   - **Auto push on commit:** ON
   - **Commit message:** `vault: {{date}}`

Obsidian and GitHub now stay in sync automatically.

---

## Step 4 — Copy WhatsApp notes into vault

```powershell
# Copy the 11 WhatsApp .md files into the vault
Copy-Item "C:\Users\shaha\Downloads\*.md" "C:\Users\shaha\brain\" -Force
```

Then open Obsidian — the notes will appear in the file tree.

---

## Step 5 — Hook auto-update to brain repo (CCR web sessions)

After brain repo is cloned in a CCR session, the `rebuild_brain.py` script
automatically detects and uses `brain/context/` instead of `skill/context/`.

The scripts live in `skill/scripts/` and are always available:

```bash
# If hooks are missing at start of a CCR session, run:
bash /home/user/skill/scripts/setup-hooks.sh
```

This re-installs `brain-update.sh` into `~/.claude/` and verifies the Stop hook.

---

## Step 6 — Local MCP (already done)

The `obsidian-mcp` MCP server is already connected in Claude Code terminal:

```
claude mcp add obsidian-mcp -- npx -y obsidian-mcp "C:\Users\shaha\OneDrive\Documents\Obsidian Vault"
```

Once the vault is pointed to the brain repo, update this path to:
```
claude mcp add obsidian-mcp -- npx -y obsidian-mcp "C:\Users\shaha\brain"
```

Available tools after reconnect:
- `obsidian_list_files_in_vault`
- `obsidian_get_file_contents`
- `obsidian_simple_search`
- `obsidian_append_content`
- `obsidian_update_content`

---

## How to update your context

| What changed | What to do |
|---|---|
| Personal info (job, setup) | Edit `brain/context/ABOUTME.md` in Obsidian |
| Project status/next steps | Edit `brain/context/PROJECTS.md` in Obsidian |
| Session ends | brain-update.sh auto-pushes → Obsidian Git auto-pulls |

---

## File map

```
brain/ (GitHub repo = Obsidian vault root)
├── context/
│   ├── ABOUTME.md          ← personal context (source of truth)
│   ├── PROJECTS.md         ← all projects (source of truth)
│   ├── SESSIONS.md         ← auto-generated session log
│   └── OBSIDIAN_SETUP.md   ← this file
└── ... (other Obsidian notes, WhatsApp exports, etc.)
```

```
skill/scripts/
├── rebuild_brain.py        ← rewrites Developer Context in all CLAUDE.md files
├── brain-update.sh         ← Stop hook: logs session + calls rebuild_brain.py
└── setup-hooks.sh          ← installs hooks into ~/.claude/ (run once per CCR session)
```
