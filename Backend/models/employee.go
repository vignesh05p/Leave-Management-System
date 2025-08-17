package models

type Employee struct {
	ID           int    `json:"id"`
	UserID       string `json:"user_id"`
	Name         string `json:"name"`
	Department   int    `json:"department_id"`
	JoiningDate  string `json:"joining_date"`
	LeaveBalance int    `json:"leave_balance"`
}
