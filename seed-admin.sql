-- Seed initial admin user for cloud deployment
-- Simplified version with proper column names

-- Generate UUIDs using PostgreSQL
DO $$
DECLARE
  admin_user_id TEXT := 'usr_' || encode(gen_random_bytes(16), 'hex');
  company_uuid UUID := gen_random_uuid();
BEGIN

-- Create admin user (without session for now)
INSERT INTO "user" (id, name, email, email_verified, created_at, updated_at)
VALUES (
  admin_user_id,
  'Cloud Admin',
  'admin@paperclip.local',
  true,
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Create company
INSERT INTO companies (id, name, description, created_at, updated_at)
VALUES (
  company_uuid,
  'My Cloud Company',
  'Auto-created during deployment',
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;

-- Note: API keys are stored as hashes, so we can't pre-create a known key
-- You'll need to use the bootstrap-ceo command or create via API

END $$;
