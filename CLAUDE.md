# CLAUDE.md — skill

This file provides context to Claude Code when working in this repository.

---

## Developer Context

> Auto-updated after each session. Last updated: June 08, 2026.
> **Edit source files** at `skill/context/` (or `brain/context/` once vault repo is set up) — not directly here.
> At end of each session: update `skill/context/PROJECTS.md` with any status changes before ending.

### About Shahab

---

## Who I Am
- Based in **Mumbai, India** (Mahim area)
- Day job: **Export Customer Service & Documentation** at Sarang Maritime Logistics Pvt Ltd
- Domain expertise: NVOCC operations, carrier bookings, vessel scheduling, B/L documentation, Delivery Orders, port operations, Exim India data
- Actively building skills in **AI and data science** — positioning at intersection of logistics expertise + AI tooling
- Schedule: 9AM–6PM job → Mahim social service → home by 9:30PM (~45–60 mins free at night)

---

## My Setup
- **Laptop:** ASUS ExpertBook P1503CVA, Windows
- **Python env:** Miniforge3 conda
- **AI tools:** Claude Code (terminal), claude.ai (mobile app)
- **Security:** Windows Defender + Malwarebytes Free
- **Investing:** Groww (mutual funds + demat), SIP ₹10K/month

### Memory & AI Stack (Active)
- **claude-mem** ✓ working — auto-captures sessions, web viewer at localhost:37777
- **MemPalace** ✓ connected
- **obsidian-mcp** ✓ connected — vault at `C:\Users\shaha\OneDrive\Documents\Obsidian Vault`
- **RTK** ✓ hooked globally into Claude Code
- **Odysseus stack** ✓ running at localhost:7000 (ChromaDB + SearXNG + ntfy, 10 Anthropic models)
- **Local models:** Ollama (llama3.2)
- **context-sync** — connected but set_project has 401 auth bug (pending fix)
- **plugin:mempalace** — python3 path error (pending fix: change `python` → `python3`)

### Obsidian
- **Version:** 1.12.7
- **Vault path:** `C:\Users\shaha\OneDrive\Documents\Obsidian Vault`
- **MCP command:** `claude mcp add obsidian-mcp -- npx -y obsidian-mcp "C:\Users\shaha\OneDrive\Documents\Obsidian Vault"`
- **Obsidian Git:** pending setup (brain repo not yet created)

---

## Current Financial Goal
- **₹5 lakh** — need to keep aside as debt repayment (owner can ask anytime)
- Currently have no savings toward this
- Strategy: freelance logistics documentation consulting via LinkedIn visibility

---

## Work Context (Sarang Maritime)
- Role: Export dept — customer service + documentation only
- Company acts as **agent** for principals (does not own containers)
- Principals' containers tracked until empty return to depot
- Data sources: Excel, Email, WhatsApp, Botim, Exim India subscription
- Pain: Exim India data sometimes mismatches VO (vessel operator) — VO word preferred
- Branch in Gandhidham, Gujarat (separate management — Director: Mr. Jaymin Thakkar)

---

## GitHub Repos
- github.com/shahabshaikh1990/rtk
- github.com/shahabshaikh1990/caveman
- github.com/shahabshaikh1990/skill
- github.com/shahabshaikh1990/Mastermind-Assignment

---

## LinkedIn
- Profile: linkedin.com/in/shahab-shaikh-562522b1
- Headline + About section: optimized and ready to paste
- Status: First post not yet published

---

## How I Work Best with Claude
- Direct, no fluff
- Practical over theoretical
- Indian market context always applies
- Mobile app user (claude.ai)
- Honest about limitations (lazy with outreach, busy schedule)
- Responds well to step-by-step actionable plans

---

### Active Projects

---

## 1. LinkedIn Visibility & Freelance Documentation Consulting
**Status:** In Progress — profile optimized, first post pending
**Goal:** Make exporters come to me, build toward ₹5 lakh side income

**Positioning:**
> "Export documentation specialist | Helping small Mumbai exporters avoid costly B/L mistakes and shipment delays"

**Target Clients:**
- Small Mumbai exporters (garments, handicrafts, spices, chemicals)
- Can't afford full-time documentation person
- Struggle with B/L errors, shipping instructions, freight coordination

**Content Strategy:**
- Claude drafts posts, Shahab reviews + publishes
- Post ideas:
  - "3 mistakes small exporters make in shipping instructions"
  - "What to check when Exim India data doesn't match VO details"
  - "How to read a B/L — common errors that cost money"
  - "COD vs prepaid freight — what exporters often get wrong"

**Revenue Model:**
- 2–3 clients × ₹8K–15K/month = ₹25K–45K/month side income
- Timeline to ₹5 lakh: 12–18 months realistically

**Done:**
- [x] LinkedIn headline + About section optimized (ready to paste)

**Next Steps:**
- [ ] Paste optimized headline + About into LinkedIn profile
- [ ] Draft and publish first post
- [ ] Set up simple client inquiry template

---

## 2. Work Automation (Sarang Maritime — Internal)
**Status:** Planned — build after LinkedIn momentum starts
**Goal:** Reduce daily repetitive work, free up energy

**Pain Points Identified:**
- Replying to repetitive customer emails (shipment status, vessel position)
- Delayed inventory reports to principals
- Releasing Delivery Orders (DO) to shippers
- Container tracking until empty return to depot
- Reconciling empty returns with principal inventory
- Exim India data vs VO mismatch — manual cross-checking

**3 Tools to Build:**
1. **Email Reply Assistant** — paste incoming email → get drafted reply with correct shipment details
2. **Inventory + Container Tracker Dashboard** — all active containers, vessel position, empty return status, auto-generates principal inventory reports
3. **DO Release Workflow** — structured checklist + auto-generated DO letter

**Data Sources Available:**
- Excel (primary)
- Email / WhatsApp / Botim
- Exim India subscription
- VO emails for cut-off, ETD, ETA

**Stack:** Python + Claude Code + Excel automation

---

## 3. Instagram Saves Engine
**Status:** On hold until LinkedIn + freelance income stream is stable
**Goal:** Anonymous AI content brand — grow through saves/shares

**Target Audience:** Indian small business owners, freelancers, solopreneurs

**Content Pillars:**
- AI tool releases and reviews
- Motivation / mindset for builders
- "Build in public" content
- Practical AI workflows for non-technical people

**Tech Stack:**
- Notion MCP for content database
- Python automation for scheduling
- Claude Code for content generation
- Windows-specific setup

**Key Constraint:** Fully anonymous — no personal branding

---

## 4. Meta Ads Freelance
**Status:** Built system, no client yet
**Goal:** Manage Meta ad campaigns for Indian D2C brands

**Built:**
- Meta Ads Analysis System (Windsor.ai + Claude integration)
- India-specific KPIs: INR ROAS, COD order rate, RTO %

**Target Clients:** Small D2C brands spending ₹50K–5L/month on ads

**Note:** Secondary priority — LinkedIn consulting is faster path to ₹5 lakh

---

## 5. MerchantAntiques (Shopify)
**Status:** Active store
**URL:** merchantantiques.in
**Product:** Brass kitchenware, antique-style home goods
**Platform:** Shopify
**Next:** Meta ads strategy implementation

---

## 6. Dropshipping
**Status:** On hold
**Niche:** Pet wellness (India)
**Blocker:** Time + focus needed elsewhere first

---

## 7. AI & Data Science Upskilling
**Status:** Ongoing (slow)
**Platform:** UpGrad
**Course:** Python for AI & Data Science + Gen AI course

**Honest pattern:** Tendency to enroll and not complete
**Fix:** Build practical projects alongside learning

**Tools actively using:**
- Claude Code + RTK (global hook) ✓
- claude-mem ✓ working
- MemPalace ✓ connected
- obsidian-mcp ✓ connected
- Odysseus stack ✓ running (localhost:7000)
- Ollama / llama3.2
- ScrapeGraphAI

---

## 8. Obsidian Second Brain
**Status:** In Progress
**Vault:** `C:\Users\shaha\OneDrive\Documents\Obsidian Vault`
**MCP:** obsidian-mcp ✓ connected

**Done:**
- [x] obsidian-mcp connected via Claude Code
- [x] 815 WhatsApp links extracted and categorized into 11 notes (ready to copy)

**Pending:**
- [ ] Create `shahabshaikh1990/brain` GitHub repo (private)
- [ ] Install Obsidian Git plugin → point to brain repo
- [ ] Copy 11 WhatsApp .md files into vault
- [ ] Review and organize 260 YouTube Shorts + 23 videos

---

## Priority Order (as of June 2026)
1. **LinkedIn first post** — this week (profile already optimized)
2. **Create brain repo + Obsidian Git setup** — enables auto-sync
3. **Fix plugin:mempalace** — change `python` → `python3`
4. **Copy WhatsApp notes into vault**
5. **Email Reply Assistant (Tool 1)** — first automation win
6. **MerchantAntiques Meta ads**
7. **Instagram Saves Engine**

---

## Pending Setup Checklist
- [x] Install claude-mem
- [x] Install MemPalace
- [x] Connect obsidian-mcp
- [x] Hook RTK globally into Claude Code
- [x] LinkedIn headline + About section optimized
- [ ] Paste LinkedIn headline + About into profile
- [ ] Draft and publish first LinkedIn post
- [ ] Create `shahabshaikh1990/brain` GitHub repo (private)
- [ ] Install Obsidian Git plugin → point to brain repo
- [ ] Copy 11 WhatsApp .md files into vault (`C:\Users\shaha\Downloads\*.md` → vault)
- [ ] Fix plugin:mempalace: change `python` → `python3` in `.claude.json`
- [ ] Fix context-sync 401 auth bug
- [ ] Install ECC plugin in Claude Code
