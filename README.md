# Acacia Health Insurance – Agent Management Portal

A full-stack web portal for Retail Unit management. Unit Head gets a private dashboard; Health Planners get a mobile-friendly activity logging interface.

---

## LIVE DEPLOYMENT GUIDE (30–45 minutes)

### STEP 1 — Create your Supabase database (free)

1. Go to **https://supabase.com** and sign up (free)
2. Click **New Project** → name it `acacia-portal` → set a password → choose a region (e.g. EU West for Ghana proximity)
3. Wait ~2 minutes for it to provision
4. Go to **SQL Editor** in the left sidebar
5. Open the file `supabase_schema.sql` from this project, paste ALL of its contents into the editor, and click **Run**
6. This creates all tables and inserts your 10 agents automatically
7. Go to **Settings → API** and copy:
   - **Project URL** (looks like `https://abcdefgh.supabase.co`)
   - **anon / public key** (long JWT string)

---

### STEP 2 — Deploy to Vercel (free)

**Option A — Via GitHub (recommended)**

1. Create a GitHub account if you don't have one at **https://github.com**
2. Create a new repository called `acacia-portal`
3. Upload all files from this project folder to the repository
4. Go to **https://vercel.com** and sign up with your GitHub account
5. Click **Add New Project** → Import your `acacia-portal` repo
6. Before clicking Deploy, click **Environment Variables** and add:
   - `VITE_SUPABASE_URL` → paste your Supabase Project URL
   - `VITE_SUPABASE_ANON_KEY` → paste your anon key
7. Click **Deploy** — Vercel builds and deploys automatically (~2 minutes)
8. Your portal is live at `https://acacia-portal.vercel.app` (or similar)

**Option B — Via Vercel CLI**
```bash
npm install -g vercel
cd acacia-portal
cp .env.example .env   # then edit .env with your keys
vercel --prod
```

---

### STEP 3 — Share the link

- **Your Unit Head link**: `https://your-app.vercel.app`  → Sign in as Unit Head, PIN: 1234
- **Agents link**: Same URL → Sign in as Health Planner, select name, PIN: 0000

**To change PINs after deployment:**
- Unit Head PIN: Update directly in Supabase → Table Editor → `unit_head` table
- Agent PINs: Update in `agents` table, `pin` column for each agent

---

## LOCAL DEVELOPMENT

```bash
# Install dependencies
npm install

# Create environment file
cp .env.example .env
# Edit .env and add your Supabase URL and key

# Run locally
npm run dev
# Opens at http://localhost:3000

# Build for production
npm run build
```

---

## PORTAL FEATURES

### Unit Head (private dashboard)
| Feature | Description |
|---------|-------------|
| Dashboard | Live overview — active agents, policies sold, premium, star performers |
| Agent Roster | All 10 Health Planners with full profiles, status, license info |
| Agent Detail | Individual page with KPI charts, full activity history, editable targets |
| KPI Tracker | Inline editable targets vs actuals for all agents — monthly |
| All Activities | Full activity log across team with filters by agent, type, outcome |
| Coaching Log | Record 1-on-1s, reviews, coaching sessions with action items |

### Health Planner (agent view)
| Feature | Description |
|---------|-------------|
| Log Activity | Submit calls, visits, sales, renewals, claims with full details |
| My Activities | Personal activity history with filters |
| My KPIs | Monthly targets, progress bars, score, incentive eligibility |
| My Profile | View personal details on record |

---

## TECHNOLOGY STACK

| Layer | Technology |
|-------|-----------|
| Frontend | React 18 + Vite |
| Styling | Tailwind CSS |
| Database | Supabase (PostgreSQL) |
| Auth | PIN-based session auth via Supabase |
| Hosting | Vercel (free tier) |
| Fonts | DM Sans + Syne (Google Fonts) |

---

## DEFAULT CREDENTIALS

| Role | Login | PIN |
|------|-------|-----|
| Unit Head | Select "Unit Head" | 1234 |
| Any Health Planner | Select your name | 0000 |

**Change PINs in Supabase after go-live.**

---

## SUPPORT / CUSTOMISATION

To add more agents, insert rows into the `agents` table in Supabase.
To change KPI weightings, edit the `calcScore` function in `Dashboard.jsx` and `AgentDetail.jsx`.
To add new plan types, edit the `PLANS` array in `LogActivity.jsx`.

---

*Acacia Health Insurance Ltd · Retail Unit Portal v1.0*
