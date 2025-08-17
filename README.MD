Perfect ⚡ If you already have an **`ARCHITECTURE.png`** diagram, we can use it to create a **clean README.md** for your Leave Management System project.

Here’s a **professional README.md draft** you can use directly:

---

# 🚀 Leave Management System

A full-stack **Leave Management System** built with **Go (Gin) + Supabase (Postgres)** + modern frontend (React/Vue).
The system provides **separate dashboards** for **HR** and **Employees**, enabling employee leave requests, HR approvals, and workforce management.

---

## 📌 Features

### 👨‍💼 Employee Dashboard

* Apply for leave (casual, sick, etc.)
* Track leave balance
* View leave status (Pending / Approved / Rejected)
* Profile & joining details

### 🧑‍💻 HR Dashboard

* Approve / reject leave requests
* Manage employees (add/update/remove)
* Assign employees to departments
* View department-wise workforce data

---

## 🏗️ System Architecture

![Architecture](ARCHITECTURE.png)

* **Frontend** → Employee & HR dashboards (React or Vue.js)
* **Backend (Go + Gin)** → REST APIs to manage users, employees, departments, and leave requests
* **Database (Supabase / Postgres)** → Secure data storage with Role-Level Security (RLS) policies
* **Auth & Security** → Supabase auth (UUIDs, hashed passwords), HR/Employee role-based access

---

## 📂 Project Structure

```
Leave-Management-System/
│── backend/              # Go backend (Gin + pgx + Supabase)
│   ├── config/           # DB connection
│   ├── handlers/         # API endpoints
│   ├── models/           # Database models
│   ├── main.go           # Entry point
│── frontend/             # React or Vue.js frontend (dashboards)
│── db/                   # SQL schema & migrations
│── ARCHITECTURE.png      # System architecture diagram
│── README.md             # Documentation
```

---

## ⚙️ Tech Stack

* **Frontend** → React.js (or Vue.js)
* **Backend** → Go (Gin Framework)
* **Database** → PostgreSQL (Supabase hosted)
* **ORM/Driver** → pgx / pgxpool
* **Auth** → Supabase authentication
* **Deployment** → Docker + Supabase

---

## 🛠️ Setup Instructions

### 1️⃣ Clone Repo

```bash
git clone https://github.com/your-username/leave-management-system.git
cd leave-management-system
```

### 2️⃣ Backend Setup (Go)

```bash
cd backend
go mod tidy
```

Create `.env` file:

```env
DB_URL=postgres://postgres:[PASSWORD]@aws-1-ap-south-1.pooler.supabase.com:6544/postgres
PORT=8080
```

Run backend:

```bash
go run main.go
```

---

### 3️⃣ Database Setup (Supabase/Postgres)

Run SQL schema from `db/schema.sql` in Supabase SQL editor:

* **Tables** → users, employees, departments, leave\_requests
* **Policies (RLS)** → restrict employees to only their data

---

### 4️⃣ Frontend Setup (React Example)

```bash
cd frontend
npm install
npm run dev
```

---

## 📡 API Endpoints

### Employees

* `POST /employees` → Add employee
* `GET /employees` → List employees

### Leaves

* `POST /leaves` → Request leave
* `GET /leaves` → Get all leaves (HR)
* `GET /leaves/:id` → Get employee’s leaves
* `PUT /leaves/:id/approve` → Approve leave
* `PUT /leaves/:id/reject` → Reject leave

---

## 🔐 Roles & Permissions

* **Employee** → Can only apply for leave and view their own profile.
* **HR** → Can approve/reject leaves, manage employees, and access reports.

---

## 🚀 Roadmap

* [ ] Email notifications for leave approvals/rejections
* [ ] Analytics dashboard for HR
* [ ] Export leave reports to Excel/PDF
* [ ] Mobile responsive frontend

---

## 🤝 Contributing

1. Fork the repo
2. Create a new branch (`feature/leave-approval`)
3. Commit changes
4. Push and create PR

---

## 📜 License

MIT License © 2025 Your Name

---

👉 Would you like me to also include a **sample ER diagram (tables + relationships)** inside the README, alongside `ARCHITECTURE.png`? That way the schema is clear for anyone reading your repo.
