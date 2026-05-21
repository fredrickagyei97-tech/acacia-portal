-- ============================================================
-- ACACIA HEALTH INSURANCE – AGENT PORTAL
-- Supabase Database Schema
-- Run this in your Supabase SQL Editor
-- ============================================================

-- AGENTS TABLE
create table if not exists agents (
  id text primary key,
  name text not null,
  phone text,
  email text,
  zone text,
  joined date,
  contract_type text default 'Full-Time',
  license_no text,
  license_expiry date,
  status text default 'Active',
  pin text default '0000',
  created_at timestamptz default now()
);

-- KPI TARGETS TABLE
create table if not exists kpi_targets (
  id uuid primary key default gen_random_uuid(),
  agent_id text references agents(id),
  month text not null,
  year int not null,
  new_clients_target int default 20,
  renewals_target int default 8,
  premium_target numeric default 15000,
  created_at timestamptz default now(),
  unique(agent_id, month, year)
);

-- ACTIVITIES TABLE
create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  agent_id text references agents(id),
  agent_name text,
  date date not null,
  activity_type text not null,
  client_name text not null,
  contact_mode text,
  outcome text,
  plan text,
  premium numeric default 0,
  follow_up_date date,
  notes text,
  logged_at timestamptz default now()
);

-- COACHING LOG TABLE
create table if not exists coaching_log (
  id uuid primary key default gen_random_uuid(),
  agent_id text references agents(id),
  date date not null,
  meeting_type text,
  discussion_points text,
  targets_set text,
  challenges text,
  action_items text,
  follow_up_date date,
  unit_head_notes text,
  created_at timestamptz default now()
);

-- UNIT HEAD AUTH TABLE
create table if not exists unit_head (
  id int primary key default 1,
  name text default 'Unit Head',
  pin text default '1234'
);

-- Insert default unit head
insert into unit_head (id, name, pin) values (1, 'Unit Head', '1234')
on conflict (id) do nothing;

-- INSERT DEFAULT AGENTS
insert into agents (id, name, phone, email, zone, joined, contract_type, license_no, license_expiry, status, pin) values
('ACA-001','Kwame Asante','+233 24 100 0001','k.asante@acacia.gh','Greater Accra North','2022-01-15','Full-Time','NIC-GH-001','2026-12-31','Active','0000'),
('ACA-002','Abena Mensah','+233 24 100 0002','a.mensah@acacia.gh','Greater Accra South','2022-03-20','Full-Time','NIC-GH-002','2026-11-30','Active','0000'),
('ACA-003','Kojo Boateng','+233 24 100 0003','k.boateng@acacia.gh','Ashanti','2021-06-01','Part-Time','NIC-GH-003','2026-09-30','Active','0000'),
('ACA-004','Ama Owusu','+233 24 100 0004','a.owusu@acacia.gh','Western','2023-02-10','Full-Time','NIC-GH-004','2027-01-31','Active','0000'),
('ACA-005','Fiifi Darko','+233 24 100 0005','f.darko@acacia.gh','Eastern','2022-08-15','Full-Time','NIC-GH-005','2026-10-31','Active','0000'),
('ACA-006','Efua Annan','+233 24 100 0006','e.annan@acacia.gh','Central','2023-05-01','Part-Time','NIC-GH-006','2026-12-31','Active','0000'),
('ACA-007','Yaw Acheampong','+233 24 100 0007','y.acheampong@acacia.gh','Volta','2021-11-20','Full-Time','NIC-GH-007','2025-08-31','Active','0000'),
('ACA-008','Akosua Frimpong','+233 24 100 0008','a.frimpong@acacia.gh','Northern','2022-04-05','Full-Time','NIC-GH-008','2027-03-31','Active','0000'),
('ACA-009','Nana Boakye','+233 24 100 0009','n.boakye@acacia.gh','Brong-Ahafo','2023-09-01','Part-Time','NIC-GH-009','2026-07-31','Active','0000'),
('ACA-010','Adwoa Tetteh','+233 24 100 0010','a.tetteh@acacia.gh','Upper East','2022-07-12','Full-Time','NIC-GH-010','2026-06-30','On Leave','0000')
on conflict (id) do nothing;

-- INSERT DEFAULT KPI TARGETS (May 2026)
insert into kpi_targets (agent_id, month, year, new_clients_target, renewals_target, premium_target) values
('ACA-001','May',2026,20,8,15000),
('ACA-002','May',2026,20,8,15000),
('ACA-003','May',2026,12,5,8000),
('ACA-004','May',2026,20,8,15000),
('ACA-005','May',2026,20,8,15000),
('ACA-006','May',2026,12,5,8000),
('ACA-007','May',2026,20,8,15000),
('ACA-008','May',2026,20,8,15000),
('ACA-009','May',2026,12,5,8000),
('ACA-010','May',2026,20,8,15000)
on conflict (agent_id, month, year) do nothing;

-- ROW LEVEL SECURITY (optional – enable for production)
-- alter table activities enable row level security;
-- alter table agents enable row level security;
