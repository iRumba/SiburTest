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
        protected void OnEditCommand(object sender, CommandEventArgs e)
        {
            return;
        }

        protected void grid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var btnNew = (LinkButton)e.Row.FindControl("btnNew");
                var btnEdit = (LinkButton)e.Row.FindControl("btnEdit");
                var btnDelete = (LinkButton)e.Row.FindControl("btnDelete");
                var btnUpdate = (LinkButton)e.Row.FindControl("btnUpdate");
                var btnCancel = (LinkButton)e.Row.FindControl("btnCancel");
                //btnNew.OnClientClick = Page.ClientScript.GetPostBackEventReference(grid, $"Edit${e.Row.RowIndex}");
                if (e.Row.RowState.HasFlag(DataControlRowState.Edit))
                {
                    btnNew.Visible = false;
                    btnEdit.Visible = false;
                    btnDelete.Visible = false;
                    btnUpdate.Visible = true;
                    btnCancel.Visible = true;
                }
                else
                {
                    btnNew.Visible = e.Row.RowIndex == 0;
                    btnEdit.Visible = e.Row.RowIndex > 0;
                    btnDelete.Visible = e.Row.RowIndex > 0;
                    btnUpdate.Visible = false;
                    btnCancel.Visible = false;
                }
            }
        }

        protected void grid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            return;
        }

        protected void grid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            return;
        }
    }
}