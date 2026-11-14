create extension if not exists pgcrypto;
create table if not exists public.projects (
 id uuid primary key default gen_random_uuid(), title text not null, description text not null default '', cover_image text, gallery text[] default '{}', video_url text, live_url text, source_url text, category text, technologies text[] default '{}', featured boolean default false, published boolean default false, created_at timestamptz default now(), updated_at timestamptz default now()
);
create table if not exists public.services (
 id uuid primary key default gen_random_uuid(), title text not null, description text not null default '', icon text, images text[] default '{}', video_url text, price text, active boolean default true, published boolean default false, created_at timestamptz default now()
);
create table if not exists public.testimonials (
 id uuid primary key default gen_random_uuid(), client_name text not null, company text, position text, avatar_url text, review text not null, rating int check (rating between 1 and 5), verified boolean default false, published boolean default false, created_at timestamptz default now()
);
create table if not exists public.certificates (
 id uuid primary key default gen_random_uuid(), title text not null, issuer text, image_url text, credential_id text, verification_url text, issued_at date, published boolean default false, created_at timestamptz default now()
);
create table if not exists public.offers (
 id uuid primary key default gen_random_uuid(), title text not null, description text, image_url text, price text, cta_url text, starts_at timestamptz, expires_at timestamptz, active boolean default true, created_at timestamptz default now()
);
create table if not exists public.technologies (
 id uuid primary key default gen_random_uuid(), name text not null, category text not null, icon_url text, sort_order int default 0, visible boolean default true
);
create table if not exists public.articles (
 id uuid primary key default gen_random_uuid(), title text not null, slug text unique not null, excerpt text, content text, cover_image text, language text default 'ar', seo_title text, seo_description text, published boolean default false, published_at timestamptz, created_at timestamptz default now()
);
create table if not exists public.social_links (
 id uuid primary key default gen_random_uuid(), label text not null, url text not null, icon text, sort_order int default 0, enabled boolean default true
);
create table if not exists public.site_settings (
 key text primary key, value jsonb not null default '{}'::jsonb, updated_at timestamptz default now()
);
create table if not exists public.contact_messages (
 id uuid primary key default gen_random_uuid(), name text not null, email text not null, message text not null, created_at timestamptz default now()
);

alter table public.projects enable row level security;
alter table public.services enable row level security;
alter table public.testimonials enable row level security;
alter table public.certificates enable row level security;
alter table public.offers enable row level security;
alter table public.technologies enable row level security;
alter table public.articles enable row level security;
alter table public.social_links enable row level security;
alter table public.site_settings enable row level security;
alter table public.contact_messages enable row level security;

-- Public visitors can only read published content. Only the configured admin email can manage content.
create or replace function public.is_portfolio_admin() returns boolean
language sql stable security definer set search_path = public
as $$ select coalesce(auth.jwt() ->> 'email' = 'YOUR_ADMIN_EMAIL', false) $$;

create policy "public read published projects" on public.projects for select using (published = true or public.is_portfolio_admin());
create policy "authenticated manage projects" on public.projects for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "public read active services" on public.services for select using (published = true or public.is_portfolio_admin());
create policy "authenticated manage services" on public.services for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "public read published testimonials" on public.testimonials for select using (published = true or public.is_portfolio_admin());
create policy "authenticated manage testimonials" on public.testimonials for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "public read published certificates" on public.certificates for select using (published = true or public.is_portfolio_admin());
create policy "authenticated manage certificates" on public.certificates for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "public read active offers" on public.offers for select using (active = true or public.is_portfolio_admin());
create policy "authenticated manage offers" on public.offers for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "public read visible technologies" on public.technologies for select using (visible = true or public.is_portfolio_admin());
create policy "authenticated manage technologies" on public.technologies for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "public read published articles" on public.articles for select using (published = true or public.is_portfolio_admin());
create policy "authenticated manage articles" on public.articles for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "public read enabled social links" on public.social_links for select using (enabled = true or public.is_portfolio_admin());
create policy "authenticated manage social links" on public.social_links for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "public read site settings" on public.site_settings for select using (true);
create policy "authenticated manage site settings" on public.site_settings for all to authenticated using (public.is_portfolio_admin()) with check (public.is_portfolio_admin());
create policy "authenticated read contact messages" on public.contact_messages for select to authenticated using (public.is_portfolio_admin());
create policy "authenticated delete contact messages" on public.contact_messages for delete to authenticated using (public.is_portfolio_admin());
-- Contact form inserts are performed server-side using the service role key, never exposed to browsers.
