# Obsidian + Claude — Setup Guide

## What this system does

```
Obsidian vault (GitHub) ←──Obsidian Git pulls──  GitHub repo: brain
                                                        ↑
                                              brain-update.sh pushes
                                                        ↑
                                           Stop hook runs at session end
                                                        ↑
                                         Claude Code session (web or local)
```

- `skill/context/` = source of truth RIGHT NOW (until vault repo exists)
- `brain/context/` = source of truth AFTER you complete this setup
- All 4 repo CLAUDE.md files are auto-rebuilt at session end

---

## Step 1 — Create the GitHub vault repo

Go to github.com → New repository
- Name: `brain` (or `obsidian-vault`, `second-brain` — your choice)
- Private: yes
- Initialize with README: no

---

## Step 2 — Clone + move context files

Run these commands on your Windows machine (Git Bash or PowerShell):

```bash
git clone https://github.com/shahabshaikh1990/brain.git
cd brain
mkdir context
# Copy your existing context files here (from skill/context/ or start fresh)
git add .
git commit -m "init: personal knowledge base"
git push
```

---

## Step 3 — Set up Obsidian Git plugin

1. Open Obsidian → Settings → Community plugins → Browse
2. Search: **Obsidian Git** → Install → Enable
3. Settings → Obsidian Git:
   - Custom base path: point to the cloned `brain/` folder
   - Auto pull interval: 5 minutes
   - Auto push on commit: ON
   - Commit message: `vault: {{date}}`

Now Obsidian and GitHub stay in sync automatically.

---

## Step 4 — Tell Claude Code about the vault repo

In your next Claude Code web session, say:
> "My Obsidian vault repo is shahabshaikh1990/brain — add it to this session"

Claude will use `brain/context/` as the source of truth instead of `skill/context/`.

---

## Step 5 — Local MCP (for Claude Code terminal on Windows)

This lets Claude read/write Obsidian notes directly when using the terminal.

### Install Obsidian Local REST API plugin

1. Obsidian → Settings → Community plugins → Browse
2. Search: **Local REST API** → Install → Enable
3. Settings → Local REST API:
   - Copy the **API Key** shown (save it somewhere)
   - Default port: 27124

### Add MCP to Claude Code on Windows

Edit `%APPDATA%\Claude\claude_desktop_config.json` (Claude Desktop)
OR `%USERPROFILE%\.claude\settings.json` (Claude Code terminal):

```json
{
  "mcpServers": {
    "obsidian": {
      "command": "npx",
      "args": ["-y", "mcp-obsidian"],
      "env": {
        "OBSIDIAN_API_KEY": "paste-your-api-key-here",
        "OBSIDIAN_HOST": "https://127.0.0.1:27124"
      }
    }
  }
}
```

Restart Claude Code. You'll now have tools like:
- `obsidian_list_files_in_vault`
- `obsidian_get_file_contents`
- `obsidian_simple_search`
- `obsidian_append_content`
- `obsidian_update_content`

---

## How to update your context

| What changed | What to do |
|---|---|
| Personal info (job, setup) | Edit `skill/context/ABOUTME.md` |
| Project status/next steps | Edit `skill/context/PROJECTS.md` |
| Both auto-sync | Session end hook pushes → Obsidian Git pulls |

**Convention:** At the end of every Claude session, update `skill/context/PROJECTS.md`
with what changed (status updates, completed checklist items, new next steps).
The Stop hook then auto-rebuilds all CLAUDE.md files and pushes.

---

## File map

```
brain/ (GitHub repo = Obsidian vault)
├── context/
│   ├── ABOUTME.md      ← personal context (source of truth)
│   ├── PROJECTS.md     ← all projects (source of truth)
│   ├── SESSIONS.md     ← auto-generated session log
│   └── OBSIDIAN_SETUP.md ← this file
└── ... (other Obsidian notes)
```
