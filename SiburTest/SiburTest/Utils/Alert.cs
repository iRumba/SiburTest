using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SiburTest.Utils
{
    public class Alert
    {
        public string Title { get; set; }
        public string Message { get; set; }
        public AlertType Type { get; set; }
    }

    public enum AlertType
    {
        Success,
        Info,
        Warning,
        Danger
    }
}