using Databind.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Databind.Models
{
    public class Master
    {
          public int MasterId { get; set; }

        public string MasterName { get; set; }
    }
    public class MasterData
    {
        DataAccess DB = new DataAccess();

        public SelectList LoadMaster(int procid)
        {
            return new SelectList(DB.Proc_BindMaster(procid).ToList(), "MasterId", "MasterName");
        }
    }
}