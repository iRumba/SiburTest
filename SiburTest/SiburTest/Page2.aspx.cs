using SiburTest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SiburTest
{
    public partial class Page2 : System.Web.UI.Page
    {
        const string SEPARATOR_COOKIE_NAME = "ReportEmployeesSeparator";

        public string Separator
        {
            get
            {
                var cook = Request.Cookies[SEPARATOR_COOKIE_NAME].Value;
                return string.IsNullOrEmpty(cook) ? ";" : HttpUtility.UrlDecode(cook);
            }
            set
            {
                Response.Cookies.Set(new HttpCookie(SEPARATOR_COOKIE_NAME, HttpUtility.UrlEncode(value)));
                Response.Cookies[SEPARATOR_COOKIE_NAME].Expires = DateTime.Now.AddDays(1);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                DataBind();
        }

        protected void DeparetmentsSource_Selected(object sender, LinqDataSourceStatusEventArgs e)
        {
            //var c = new StaffContext();
            //var d = c.Departments.ToList();
            //return;
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            Separator = txtSep.Text;

            //Response.Cookies["ReportEmployeesSeparator"].Value = txtSep.Text;
            //Response.Cookies["ReportEmployeesSeparator"].Expires = DateTime.Now.AddDays(2);
            Response.Redirect(Request.RawUrl);
        }
    }
}