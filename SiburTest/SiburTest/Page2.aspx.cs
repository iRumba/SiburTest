using SiburTest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SiburTest
{
    public partial class Page2 : System.Web.UI.Page
    {
        /// <summary>
        /// Название куки для хранения разделителя отчета сотрудников по отделам
        /// </summary>
        const string SEPARATOR_COOKIE_NAME = "ReportEmployeesSeparator";

        /// <summary>
        /// Разделитель между сотрудниками в отчете сотрудников по отделам (использует куки)
        /// </summary>
        protected string Separator
        {
            get
            {
                var cook = Request.Cookies[SEPARATOR_COOKIE_NAME].Value;
                return string.IsNullOrEmpty(cook) ? ";" : HttpUtility.UrlDecode(cook);
            }
            set
            {
                //Response.Cookies.Set(new HttpCookie(SEPARATOR_COOKIE_NAME, HttpUtility.UrlEncode(value)));
                Response.Cookies[SEPARATOR_COOKIE_NAME].Value = HttpUtility.UrlEncode(value);
                // Кука будет жить 1 день
                Response.Cookies[SEPARATOR_COOKIE_NAME].Expires = DateTime.Now.AddDays(1);
            }
        }

        /// <summary>
        /// Получаем список отделов, где есть сотрудники.
        /// </summary>
        protected List<Department> Departments
        {
            get
            {
                var res = new List<Department>();
                using(var context = new StaffContext())
                {
                    // Получаем список сотрудников без отдела
                    var freeDepEmployees = context.Employees.Where(empl => empl.Department == null).ToList();
                    if (freeDepEmployees.Count > 0)
                    {
                        // Добавляем фейковый отдел для сотрудников без отдела
                        var emptyDepartment = new Department
                        {
                            Name = "[без отдела]",
                            Employees = freeDepEmployees
                        };
                        res.Add(emptyDepartment);
                    }

                    res.AddRange(context.Departments.Include("Employees").Where(d => d.Employees.Count > 0).ToList());
                }
                return res;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                DataBind();
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            Separator = txtSep.Text;
            Response.Redirect(Request.RawUrl);
        }

        /// <summary>
        /// Получаем ФИО сотрудника в формате Фамилия И. О.
        /// </summary>
        /// <param name="employee">Экземпляр модели сотрудника</param>
        /// <returns>Возвращает строку формата Фамилия И. О., Фамилия И., если отчество не задано</returns>
        protected string GetShortName(Employee employee)
        {
            var sb = new StringBuilder();
            sb.Append(employee.LastName);
            sb.Append(' ');
            sb.Append(employee.FirstName[0]);
            sb.Append('.');
            if (!string.IsNullOrWhiteSpace(employee.MiddleName))
            {
                sb.Append(' ');
                sb.Append(employee.MiddleName[0]);
                sb.Append('.');
            }
            return sb.ToString();
        }
    }
}