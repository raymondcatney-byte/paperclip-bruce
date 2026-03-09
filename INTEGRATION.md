# Paperclip + OpenClaw Integration Guide

## Setup Complete

**Dashboard:** https://poor-candies-fall.loca.lt

## What Was Installed

1. **Paperclip Server** (port 3100) - API and orchestration
2. **PostgreSQL Database** - Stores companies, agents, tasks, audit logs
3. **React UI** (port 5173) - Dashboard for managing your AI company
4. **Company Config** - The Architect's Dispatch with 8 agents

## Your Agent Roster

| Agent | Role | Schedule | Budget |
|-------|------|----------|--------|
| **Orchestrator** | CEO / System Coordinator | On-demand | $20/mo |
| **Alfred** | Chief of Staff | Daily 7 AM | $50/mo |
| **Machiavelli** | Senior Strategist | On-demand | $100/mo |
| **Pattern Detector** | Trends Analyst | Every 6 hours | $30/mo |
| **Synthesis Engine** | Integration | Post-analysis | $50/mo |
| **Autonomous Controller** | Self-Directing | Every 2 hours | $40/mo |
| **Self-Improvement** | Meta-Learning | Daily 3 AM | $30/mo |
| **Archivist** | Knowledge Keeper | Daily 9 PM | $20/mo |

**Total Monthly Budget:** $340

## Integration with OpenClaw

Paperclip sends tasks to OpenClaw via the gateway adapter. When an agent's heartbeat fires or you assign a task, Paperclip calls the OpenClaw API.

### How It Works

```
Paperclip Dashboard
       ↓
Assign Task to Alfred
       ↓
OpenClaw Gateway Adapter
       ↓
Kimi Claw (me) receives task
       ↓
Execute as Alfred persona
       ↓
Return result to Paperclip
       ↓
Audit log + UI update
```

## Current Status

- ✅ Database: PostgreSQL running
- ✅ Server: API healthy on port 3100
- ✅ UI: Dashboard accessible via tunnel
- ✅ Company: "The Architect's Dispatch" configured
- ⏳ OpenClaw Adapter: Needs JWT token for authentication

## Next Steps

### 1. Generate Agent JWT Token

Run this to create authentication tokens for agents:

```bash
cd /root/.openclaw/workspace/paperclip
export DATABASE_URL="postgres://paperclip:paperclip@localhost:5432/paperclip"
export BETTER_AUTH_SECRET="paperclip-secret-key-change-in-production"
pnpm paperclipai onboard
```

### 2. Configure OpenClaw Gateway

Edit `/root/.openclaw/workspace/paperclip/server/src/config.ts` or set env:

```bash
OPENCLAW_GATEWAY_URL=http://localhost:3000  # Your OpenClaw gateway
OPENCLAW_API_KEY=your-api-key-here
```

### 3. Import Your Company

Through the UI or API:
- Navigate to Companies → Import
- Upload `company-config.json`
- Review and approve agent hires

### 4. Start Operations

Once configured:
- Agents wake on their schedules
- Tasks appear in the ticket system
- You approve/review from the dashboard
- Full audit trail maintained

## Dashboard Features

| Feature | Description |
|---------|-------------|
| **Org Chart** | Visual hierarchy of your 8 agents |
| **Ticket System** | Every task tracked with full context |
| **Goal Alignment** | Tasks trace back to company mission |
| **Budget Tracking** | Monitor spend per agent |
| **Audit Log** | Immutable record of all decisions |
| **Governance** | Approve hires, override strategy |
| **Heartbeat Monitor** | See when agents check in |

## Commands

```bash
# View server logs
tail -f /tmp/paperclip-server.log

# Restart server
cd /root/.openclaw/workspace/paperclip
export DATABASE_URL="postgres://paperclip:paperclip@localhost:5432/paperclip"
export BETTER_AUTH_SECRET="paperclip-secret-key-change-in-production"
pnpm dev:server

# Database backup
pnpm --filter @paperclipai/db backup

# Create new tunnel (if needed)
npx localtunnel --port 3100
```

## Troubleshooting

**Server won't start:**
- Check PostgreSQL: `service postgresql status`
- Check port 3100: `lsof -i :3100`
- Check logs: `tail /tmp/paperclip-server.log`

**Tunnel not working:**
- Tunnel expires after ~8 hours
- Generate new one: `npx localtunnel --port 3100`

**Database connection error:**
- Verify PostgreSQL is running
- Check credentials in .env
- Test connection: `psql postgres://paperclip:paperclip@localhost:5432/paperclip`

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    PAPERCLIP DASHBOARD                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │   Org Chart │  │   Tickets   │  │   Budgets   │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
├─────────────────────────────────────────────────────────────┤
│                    PAPERCLIP SERVER                         │
│  - Task routing    - Heartbeat scheduler    - Audit log    │
│  - Goal alignment  - Budget enforcement     - Governance   │
├─────────────────────────────────────────────────────────────┤
│                    OPENCLAW GATEWAY                         │
│  - Receives tasks from Paperclip                            │
│  - Routes to appropriate agent (Alfred, Machiavelli, etc.) │
│  - Returns results to Paperclip                             │
├─────────────────────────────────────────────────────────────┤
│                    AGENTS (8 Total)                         │
│  Alfred | Machiavelli | Pattern Detector | Synthesis       │
│  Autonomous Controller | Self-Improvement | Archivist      │
│  Orchestrator                                               │
└─────────────────────────────────────────────────────────────┘
```

## Migration from Current System

Your existing agents live in:
- `/root/.openclaw/workspace/agents/` (agent definitions)
- `/root/.openclaw/workspace/memory/` (daily notes)
- `/root/.openclaw/workspace/MEMORY.md` (long-term memory)

Paperclip will:
1. Use the same agent definitions
2. Add ticketing/tracking layer
3. Provide governance/budget controls
4. Maintain audit trail
5. Enable multi-agent coordination

**You don't lose anything** — Paperclip adds orchestration on top.
