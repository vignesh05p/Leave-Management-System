package handlers

import (
	"context"
	"net/http"

	"leave-management/config"
	"leave-management/models"

	"github.com/gin-gonic/gin"
)

func AddEmployee(c *gin.Context) {
	var emp models.Employee

	if err := c.ShouldBindJSON(&emp); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	query := `
		INSERT INTO employees (user_id, name, department_id, joining_date, leave_balance)
		VALUES ($1, $2, $3, $4, $5)
		RETURNING id
	`

	err := config.DB.QueryRow(
		context.Background(),
		query,
		emp.UserID, emp.Name, emp.Department, emp.JoiningDate, emp.LeaveBalance,
	).Scan(&emp.ID)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Employee added successfully", "employee": emp})
}
