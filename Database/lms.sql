-- Drop tables if they already exist (safe reset)
DROP TABLE IF EXISTS leave_requests CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Users table: login + role
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role VARCHAR(20) NOT NULL CHECK (role IN ('hr', 'employee')),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Departments table
CREATE TABLE departments (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);

-- Employees table: links to users + departments
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  user_id INT UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  department_id INT REFERENCES departments(id) ON DELETE SET NULL,
  joining_date DATE NOT NULL,
  leave_balance INT DEFAULT 20 CHECK (leave_balance >= 0)
);

-- Leave Requests table
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

-- Indexes for performance
CREATE INDEX idx_employee_department ON employees(department_id);
CREATE INDEX idx_leave_employee ON leave_requests(employee_id);
CREATE INDEX idx_leave_status ON leave_requests(status);

-- Sample departments
INSERT INTO departments (name) VALUES 
  ('Engineering'),
  ('HR'),
  ('Sales');

-- Sample HR user
INSERT INTO users (email, password_hash, role) VALUES
  ('hr@company.com', 'hashed_password_here', 'hr');

-- Sample employee user + profile
INSERT INTO users (email, password_hash, role) VALUES
  ('employee1@company.com', 'hashed_password_here', 'employee');

INSERT INTO employees (user_id, name, department_id, joining_date, leave_balance)
VALUES (2, 'John Doe', 1, '2024-01-01', 15);
