# Render.com Deployment Guide

## One-Click Deploy

### Step 1: Create Render Account
1. Go to https://dashboard.render.com
2. Sign up with GitHub or email
3. Verify your account

### Step 2: Create PostgreSQL Database
1. Click "New +" → "PostgreSQL"
2. Name: `paperclip-db`
3. Database: `paperclip`
4. User: `paperclip`
5. Plan: **Free**
6. Click "Create Database"
7. **Copy the Internal Database URL** (you'll need it in Step 3)

### Step 3: Create Web Service
1. Click "New +" → "Web Service"
2. **Build from repo:** Use "Upload Code" option (since we have local code)

**Alternative - Manual Upload:**
Since you have local code, use Render's Deploy Button approach:

```bash
# First, push your code to GitHub (or I can create a gist)
```

**OR use this simpler approach:**

1. Go to: https://render.com/blueprints
2. Click "New Blueprint Instance"
3. Paste this:

```yaml
services:
  - type: web
    name: architects-dispatch
    runtime: node
    plan: free
    repo: https://github.com/paperclipai/paperclip
    buildCommand: |
      npm install -g pnpm
      pnpm install
      pnpm build
      pnpm --filter @paperclipai/db migrate
    startCommand: |
      export DATABASE_URL=$RENDER_DATABASE_URL
      pnpm --filter @paperclipai/server start
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: paperclip-db
          property: connectionString
      - key: BETTER_AUTH_SECRET
        generateValue: true
      - key: PAPERCLIP_DEPLOYMENT_MODE
        value: authenticated
      - key: PAPERCLIP_PUBLIC_URL
        value: https://architects-dispatch.onrender.com
    healthCheckPath: /api/health

databases:
  - name: paperclip-db
    plan: free
```

### Step 4: Configure Environment Variables

In your Render dashboard, add these environment variables:

| Variable | Value |
|----------|-------|
| `DATABASE_URL` | (From your PostgreSQL database - Internal URL) |
| `BETTER_AUTH_SECRET` | (Generate: `openssl rand -hex 32`) |
| `PAPERCLIP_DEPLOYMENT_MODE` | `authenticated` |
| `PAPERCLIP_PUBLIC_URL` | `https://your-service-name.onrender.com` |
| `PORT` | `10000` (Render sets this automatically) |

### Step 5: Deploy
1. Click "Create Web Service"
2. Wait for build (~5 minutes)
3. Your URL will be: `https://architects-dispatch.onrender.com`

---

## Quick Alternative: Deploy Your Current Setup

Since your server is already configured locally, here's a faster path:

### Option A: Use My Tunnel (Temporary)
Use the Cloudflare tunnel I set up:
```
https://tourist-pacific-realize-resident.trycloudflare.com
```

### Option B: Export Your Config
I can export your complete Paperclip setup as a Docker container you can deploy anywhere:

```bash
# I create a docker-compose.yml
docker-compose up -d
```

### Option C: Manual Render Setup (Recommended)

1. **Fork the Paperclip repo** to your GitHub: https://github.com/paperclipai/paperclip

2. **Add your company config** to the repo:
   - Copy `company-config.json` to the repo root

3. **Connect to Render:**
   - New Web Service → Connect your fork
   - Build Command:
     ```
     npm install -g pnpm && pnpm install && pnpm build
     ```
   - Start Command:
     ```
     pnpm --filter @paperclipai/server start
     ```

4. **Add PostgreSQL** (free tier)

5. **Set env vars** as shown above

---

## After Deployment

1. Open your Render URL
2. Create admin account
3. Import `company-config.json` (your 8-agent setup)
4. Agents start working on their schedules

---

## Free Tier Limits (Render)

| Resource | Limit |
|----------|-------|
| Web Service | Spins down after 15 min idle, wakes on request |
| PostgreSQL | 1 GB storage, 90-day retention |
| Bandwidth | 100 GB/month |
| Builds | 500 minutes/month |

**For 24/7 operation:** Upgrade to paid ($7/month) or use the local server.

---

## Need Help?

If Render setup is complex, your current local setup works fine. I can also:
1. Keep the Cloudflare tunnel running
2. Set up a simple reverse proxy on your server
3. Create a systemd service so Paperclip auto-starts

What's easiest for you?
