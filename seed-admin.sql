-- Seed initial admin user and API key for cloud deployment
-- Run this after migrations to create first admin access

-- Create admin user
INSERT INTO "user" (id, email, name, email_verified, created_at, updated_at)
VALUES (
  'admin-001',
  'admin@paperclip.local',
  'Cloud Admin',
  true,
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Create session for admin
INSERT INTO "session" (id, user_id, expires_at, created_at, updated_at)
VALUES (
  'session-001',
  'admin-001',
  NOW() + INTERVAL '1 year',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Create company
INSERT INTO companies (id, name, description, created_at, updated_at)
VALUES (
  'company-001',
  'My Cloud Company',
  'Auto-created during deployment',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Add admin to company
INSERT INTO company_memberships (id, user_id, company_id, role, created_at, updated_at)
VALUES (
  'membership-001',
  'admin-001',
  'company-001',
  'admin',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Create API key for admin
INSERT INTO agent_api_keys (
  id,
  company_id,
  agent_id,
  api_key,
  name,
  created_at,
  expires_at
)
VALUES (
  'apikey-001',
  'company-001',
  NULL,
  'pc_live_cloud_admin_key_2024_secure_token_xyz789',
  'Cloud Admin API Key',
  NOW(),
  NOW() + INTERVAL '10 years'
)
ON CONFLICT (id) DO NOTHING;

-- Create instance admin role
INSERT INTO instance_user_roles (id, user_id, role, created_at, updated_at)
VALUES (
  'role-001',
  'admin-001',
  'admin',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;
