using System.Collections.Generic;
using System.Data.Entity;

namespace SiburTest.Models
{
    /// <summary>
    /// Контекст данных
    /// </summary>
    public class StaffContext : DbContext
    {
        public StaffContext()
            : base("SiburConnection")
        {
        }

        public DbSet<Employee> Employees { get; set; }
        public DbSet<Department> Departments { get; set; }
    }

    /// <summary>
    /// Модель сотрудника
    /// </summary>
    public class Employee
    {
        public int Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string MiddleName { get; set; }

        public int? DepartmentId { get; set; }

        public virtual Department Department { get; set; }
    }

    /// <summary>
    /// Модель отдела
    /// </summary>
    public class Department
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public virtual List<Employee> Employees { get; set; }
    }
}