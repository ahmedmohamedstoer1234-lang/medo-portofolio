# Ahmed Mohamed — Premium Portfolio

A Next.js + TypeScript portfolio starter with a cinematic dark UI, the supplied profile portrait, Supabase schema, and an authenticated starter admin dashboard.

## Requirements
- Node.js 20.9+
- Supabase project

## Run locally
1. `npm install`
2. Copy `.env.example` to `.env.local` and fill in your Supabase project URL and anon key.
3. Run `supabase/schema.sql` in the Supabase SQL Editor.
4. Create your administrator user in Supabase Authentication (Email/Password).
5. `npm run dev`
6. Open `http://localhost:3000` and `/admin`.

## Environment variables
- `NEXT_PUBLIC_SITE_URL`: canonical production URL.
- `NEXT_PUBLIC_SUPABASE_URL`: Supabase project URL.
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Supabase anon/public key.
- `SUPABASE_SERVICE_ROLE_KEY`: server-only key for contact form inserts. Never prefix with `NEXT_PUBLIC_`.

## Before production
- Replace placeholder email, social URLs, and domain.
- Review every project description and only publish work you can substantiate.
- Restrict administrator account creation in Supabase; do not enable public signups.
- Configure Supabase Storage buckets and upload policies before enabling media management.
- Add rate limiting / CAPTCHA to the contact endpoint before high-traffic production use.
- The admin currently implements secure sign-in and basic project creation/deletion. Other dashboard modules are scaffolded for the next implementation pass.
- Run `npm run build` before deployment.

## Deployment
Import the repository into Vercel, set the environment variables, deploy, and configure the custom domain. Submit `/sitemap.xml` after adding the sitemap route and verifying the canonical domain.

## Admin security
In `supabase/schema.sql`, replace `YOUR_ADMIN_EMAIL` inside `is_portfolio_admin()` with the exact administrator email used in Supabase Auth before running the SQL. Keep public signups disabled. The dashboard uses Supabase Auth; database writes are restricted by RLS to that email.
