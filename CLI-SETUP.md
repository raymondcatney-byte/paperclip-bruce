# Paperclip CLI Cloud Setup

## Your API is Running At:
**https://paperclip-bruce.onrender.com**

## Create First Admin (Required!)

Since Paperclip uses hashed API keys, you need to create the first admin via the bootstrap command:

### Step 1: Run Bootstrap CEO
```bash
# In your local CLI directory
cd cli

# Set the API URL to your cloud instance
export PAPERCLIP_API_URL='https://paperclip-bruce.onrender.com'

# Run bootstrap (this creates first admin and gives you an invite URL)
npx tsx src/index.ts auth bootstrap-ceo --base-url https://paperclip-bruce.onrender.com
```

### Step 2: Visit the Invite URL
The command will output something like:
```
https://paperclip-bruce.onrender.com/invite?token=abc123...
```
Click that link to set up your admin account and get your API key.

### Step 3: Configure CLI
```bash
export PAPERCLIP_API_URL='https://paperclip-bruce.onrender.com'
export PAPERCLIP_API_KEY='your-api-key-from-invite'
```

## API Endpoints:
- **Health:** https://paperclip-bruce.onrender.com/api/health
- **Companies:** https://paperclip-bruce.onrender.com/api/companies
- **Agents:** https://paperclip-bruce.onrender.com/api/agents
- **Issues:** https://paperclip-bruce.onrender.com/api/issues

## Note on "Cannot GET /"
The root URL shows "Cannot GET /" because this is API-only mode (no web UI).
This is normal - the API endpoints work fine!
