package routes

import (
	"leave-management/handlers"

	"github.com/gin-gonic/gin"
)

func RegisterRoutes(r *gin.Engine) {
	r.POST("/employees", handlers.AddEmployee)
}
