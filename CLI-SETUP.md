# Paperclip CLI Cloud Setup

## Your API is Running At:
**https://paperclip-bruce.onrender.com**

## Pre-configured Admin Account:
- **API Key:** `pc_live_cloud_admin_key_2024_secure_token_xyz789`
- **Company ID:** `company-001`
- **Admin User:** `admin@paperclip.local`

## Configure CLI (No Localhost!)

### Step 1: Set Environment Variables
```bash
export PAPERCLIP_API_URL='https://paperclip-bruce.onrender.com'
export PAPERCLIP_API_KEY='pc_live_cloud_admin_key_2024_secure_token_xyz789'
export PAPERCLIP_COMPANY_ID='company-001'
```

### Step 2: Use CLI
```bash
cd cli

# List companies
pnpm exec paperclipai company list

# List agents  
pnpm exec paperclipai agent list

# Create an issue
pnpm exec paperclipai issue create --title "Test from CLI"
```

## API Endpoints:
- **Health:** https://paperclip-bruce.onrender.com/api/health
- **Companies:** https://paperclip-bruce.onrender.com/api/companies
- **Agents:** https://paperclip-bruce.onrender.com/api/agents
- **Issues:** https://paperclip-bruce.onrender.com/api/issues

## Important Headers:
When calling API directly, include:
```
Authorization: Bearer pc_live_cloud_admin_key_2024_secure_token_xyz789
```
