using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Databind.Models
{
    public class M_Event
    {
        public int EventId { get; set; }
        public int Eid { get; set; }
        //public int title { get; set; }
        public string Title { get; set; }
        public string Name { get; set; }
        public string Date { get; set; }
        public string Discription { get; set; }
        public string Images { get; set; }
        public string msg { get; set; }
    }
}