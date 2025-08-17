# Leave Management System

Effortlessly manage employee leave requests and approvals with the **Leave Management System**. Designed for modern workplaces, this full-stack application streamlines HR operations and empowers employees with an intuitive dashboard. Built using **Go (Gin)**, **Supabase (Postgres)**, and a modern frontend framework (**React/Vue**), it ensures a seamless experience for all users.

---

## 📌 Features

### 👨‍💼 Employee Dashboard

- Apply for leave (casual, sick, etc.)
- Track leave balance
- View leave status (Pending / Approved / Rejected)
- Access profile and joining details

### 🧑‍💻 HR Dashboard

- Approve or reject leave requests
- Manage employees (add, update, remove)
- Assign employees to departments
- View department-wise workforce data

---

## 🏗️ System Architecture

![Architecture](ARCHITECTURE.png)

- **Frontend**: Employee & HR dashboards (React or Vue.js)
- **Backend**: REST APIs built with Go (Gin) to manage users, employees, departments, and leave requests
- **Database**: Supabase/Postgres with secure Role-Level Security (RLS) policies
- **Authentication**: Supabase auth with role-based access for HR and employees

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

- **Frontend**: React.js (or Vue.js)
- **Backend**: Go (Gin Framework)
- **Database**: PostgreSQL (Supabase hosted)
- **ORM/Driver**: pgx / pgxpool
- **Authentication**: Supabase authentication
- **Deployment**: Docker + Supabase

---

## 🛠️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/leave-management-system.git
cd leave-management-system
```

### 2️⃣ Backend Setup (Go)

```bash
cd backend
go mod tidy
```

Create a `.env` file:

```env
DB_URL=postgres://postgres:[PASSWORD]@aws-1-ap-south-1.pooler.supabase.com:6544/postgres
PORT=8080
```

Run the backend:

```bash
go run main.go
```

---

### 3️⃣ Database Setup (Supabase/Postgres)

Run the SQL schema from `db/schema.sql` in the Supabase SQL editor:

- **Tables**: users, employees, departments, leave_requests
- **Policies (RLS)**: Restrict employees to only their data

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

- `POST /employees`: Add employee
- `GET /employees`: List employees

### Leaves

- `POST /leaves`: Request leave
- `GET /leaves`: Get all leaves (HR)
- `GET /leaves/:id`: Get employee’s leaves
- `PUT /leaves/:id/approve`: Approve leave
- `PUT /leaves/:id/reject`: Reject leave

---

## 🔐 Roles & Permissions

- **Employee**: Can apply for leave and view their own profile.
- **HR**: Can approve/reject leaves, manage employees, and access reports.

---

## 🚀 Roadmap

- [ ] Email notifications for leave approvals/rejections
- [ ] Analytics dashboard for HR
- [ ] Export leave reports to Excel/PDF
- [ ] Mobile-responsive frontend

---

## 🤝 Contributing

We welcome contributions to make this project even better! To contribute:

1. Fork the repository
2. Create a new branch (`feature/leave-approval`)
3. Commit your changes
4. Push the branch and create a Pull Request

---

Thank you for checking out the Leave Management System! If you have any questions or suggestions, feel free to open an issue or reach out. Let’s build something amazing together! 🚀
