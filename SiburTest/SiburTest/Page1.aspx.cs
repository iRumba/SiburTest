using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SiburTest
{
    public partial class Page1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            var fn = new Parameter("@FirstName", System.Data.DbType.String);
            var ln = new Parameter("@LastName", System.Data.DbType.String);
            fn.DefaultValue = txtName.Text;
            ln.DefaultValue = txtName.Text;
            StuffSource.InsertParameters.Add(fn);
            StuffSource.InsertParameters.Add(ln);
            StuffSource.Insert();
        }
    }
}