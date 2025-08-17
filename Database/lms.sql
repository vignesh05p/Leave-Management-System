-- ==============================
-- CLEAN SLATE (Drop old tables)
-- ==============================
DROP TABLE IF EXISTS leave_requests CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ==============================
-- USERS: Login + Role (HR / Employee)
-- ==============================
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),   -- use UUID for Supabase auth compatibility
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role VARCHAR(20) NOT NULL CHECK (role IN ('hr', 'employee')),
  created_at TIMESTAMP DEFAULT NOW()
);

-- ==============================
-- DEPARTMENTS
-- ==============================
CREATE TABLE departments (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);

-- ==============================
-- EMPLOYEES: Profile linked to Users
-- ==============================
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  user_id UUID UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  department_id INT REFERENCES departments(id) ON DELETE SET NULL,
  joining_date DATE NOT NULL,
  leave_balance INT DEFAULT 20 CHECK (leave_balance >= 0)
);

-- ==============================
-- LEAVE REQUESTS
-- ==============================
CREATE TABLE leave_requests (
  id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  reason TEXT,
  status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- ==============================
-- INDEXES (Performance)
-- ==============================
CREATE INDEX idx_employee_department ON employees(department_id);
CREATE INDEX idx_leave_employee ON leave_requests(employee_id);
CREATE INDEX idx_leave_status ON leave_requests(status);

-- ==============================
-- ENABLE RLS (Row Level Security)
-- ==============================
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE employees ENABLE ROW LEVEL SECURITY;
ALTER TABLE leave_requests ENABLE ROW LEVEL SECURITY;

-- ==============================
-- RLS POLICIES
-- ==============================

-- USERS Table
-- HR can view all users
CREATE POLICY hr_select_users ON users
  FOR SELECT
  USING (role = 'hr');

-- Employee can view only themselves
CREATE POLICY employee_select_self ON users
  FOR SELECT
  USING (id = auth.uid());

-- Allow inserting users (signup)
CREATE POLICY insert_users ON users
  FOR INSERT
  WITH CHECK (true);

-- EMPLOYEES Table
-- HR can view all employees
CREATE POLICY hr_select_employees ON employees
  FOR SELECT
  USING (EXISTS (SELECT 1 FROM users u WHERE u.id = auth.uid() AND u.role = 'hr'));

-- Employee can view only their own profile
CREATE POLICY employee_select_self ON employees
  FOR SELECT
  USING (user_id = auth.uid());

-- LEAVE REQUESTS Table
-- HR can view all leave requests
CREATE POLICY hr_select_requests ON leave_requests
  FOR SELECT
  USING (EXISTS (SELECT 1 FROM users u WHERE u.id = auth.uid() AND u.role = 'hr'));

-- Employee can view only their own leave requests
CREATE POLICY employee_select_self ON leave_requests
  FOR SELECT
  USING (employee_id IN (
    SELECT e.id FROM employees e WHERE e.user_id = auth.uid()
  ));

-- Employee can insert leave requests for themselves
CREATE POLICY employee_insert_requests ON leave_requests
  FOR INSERT
  WITH CHECK (employee_id IN (
    SELECT e.id FROM employees e WHERE e.user_id = auth.uid()
  ));

-- HR can approve/reject (update) any leave request
CREATE POLICY hr_update_requests ON leave_requests
  FOR UPDATE
  USING (EXISTS (SELECT 1 FROM users u WHERE u.id = auth.uid() AND u.role = 'hr'));

-- ==============================
-- SAMPLE DATA (Optional for testing)
-- ==============================
INSERT INTO departments (name) VALUES 
  ('Engineering'),
  ('HR'),
  ('Sales');

-- HR user
INSERT INTO users (email, password_hash, role) VALUES
  ('hr@company.com', 'hashed_password_here', 'hr');

-- Employee user
INSERT INTO users (email, password_hash, role) VALUES
  ('employee1@company.com', 'hashed_password_here', 'employee');

-- Employee profile linked to user
INSERT INTO employees (user_id, name, department_id, joining_date, leave_balance)
VALUES ((SELECT id FROM users WHERE email='employee1@company.com'), 'John Doe', 1, '2024-01-01', 15);
