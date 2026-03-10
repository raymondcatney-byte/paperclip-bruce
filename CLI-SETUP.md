# Paperclip CLI Cloud Setup

## Your API is Running At:
**https://paperclip-bruce.onrender.com**

## Quick Start - Create First Admin

### Step 1: I've Created Config for You
A config file has been placed at:
`C:\Users\raymo\.paperclip\instances\default\config.json`

This tells the CLI to connect to your cloud instance.

### Step 2: Run Bootstrap CEO
Open Command Prompt and run:

```cmd
cd C:\Users\raymo\paperclip-bruce\cli

npx tsx src/index.ts auth bootstrap-ceo --base-url https://paperclip-bruce.onrender.com
```

### Step 3: Visit the Invite URL
The command will output a link like:
```
https://paperclip-bruce.onrender.com/invite?token=abc123...
```

**Open that URL in your browser** to create your admin account and get your API key.

### Step 4: Set Environment Variables
After getting your API key from the invite page:

```cmd
set PAPERCLIP_API_URL=https://paperclip-bruce.onrender.com
set PAPERCLIP_API_KEY=your-api-key-from-invite
```

### Step 5: Use CLI
```cmd
# List companies
npx tsx src/index.ts company list

# Create an agent
npx tsx src/index.ts agent create --name "My Agent"

# Create an issue
npx tsx src/index.ts issue create --title "Test issue" --company-id YOUR_COMPANY_ID
```

---

## API Endpoints:
- **Health:** https://paperclip-bruce.onrender.com/api/health
- **Companies:** https://paperclip-bruce.onrender.com/api/companies
- **Agents:** https://paperclip-bruce.onrender.com/api/agents
- **Issues:** https://paperclip-bruce.onrender.com/api/issues

## Note: "Cannot GET /" is Normal
The root URL shows "Cannot GET /" because this is **API-only mode** (no web UI built).
The API works perfectly - just use the `/api/*` endpoints!
