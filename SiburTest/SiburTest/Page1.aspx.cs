using SiburTest.Utils;
using System;
using System.Collections.Generic;

namespace SiburTest
{
    public partial class Page1 : System.Web.UI.Page
    {
        /// <summary>
        /// Сообщения для пользователя
        /// </summary>
        protected List<Alert> Alerts { get; private set; }

        /// <summary>
        /// Получить текстовый тип сообщения для Bootstrap
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        protected string GetAlertTypeString(AlertType type)
        {
            switch (type)
            {
                case AlertType.Success:
                    return "success";
                case AlertType.Info:
                    return "info";
                case AlertType.Warning:
                    return "warning";
                case AlertType.Danger:
                    return "danger";
            }

            return string.Empty;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Alerts = new List<Alert>();
            if (!Page.IsPostBack)
                DataBind();
        }

        protected void DepartmentsSource_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                Alerts.Add(new Alert { Message = e.Exception.Message, Type = AlertType.Danger, Title = "Не удалось удалить элемент!" });
                DataBind();
                e.ExceptionHandled = true;
            }
        }
    }
}