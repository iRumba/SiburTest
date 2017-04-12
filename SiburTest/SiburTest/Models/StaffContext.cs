using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace SiburTest.Models
{
    public class StaffContext : DbContext
    {
        public StaffContext()
            : base("SiburConnection")
        {
        }


    }
}