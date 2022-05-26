using Databind.DAL;
using Databind.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Databind.Controllers
{
    public class HomeController : Controller
    {
        DataAccess DB = new DataAccess();
        private int procid;


        #region T_Event 

        [HttpGet]
        public ActionResult Event()
        {
            T_Event Event = new T_Event();

            if (Request.QueryString["sid"] != null)   // update and fill all value base on id here  using 3 rd storeprocedure
            {
                Event.Eid = Convert.ToInt32(Request.QueryString["sid"].ToString());
                Event = DB.Event(3, Event).ToList().FirstOrDefault();
                ViewBag.button = "Update";
            }
            else
            {
                ViewBag.button = "submit";
            }
            var list1 = DB.Event(4, Event).ToList(); // Show data here...; use procuder 4 for show data 
            if (list1.Count > 0)
            {
                ViewBag.Event = list1;

            }
            else
            {
                ViewBag.Event = null;
            }
            return View(Event);
        }

        [HttpPost]
        [ValidateInput(false)]

        public ActionResult Event(T_Event Event, string command)
        {

            if (command == "submit")
            {
                procid = 1;

            }
            else if (command == "update")
            {
                procid = 2;
            }
            var list = DB.Event(procid, Event).ToList();
            if (list.Count > 0)
            {
                if (list[0].msg == "success")
                {
                    TempData["msg"] = "1";
                }
                else if (list[0].msg == "exists")
                {
                    TempData["msg"] = "2";
                }
                else if (list[0].msg == "update")
                {
                    TempData["msg"] = "3";
                }
                else
                {
                    TempData["msg"] = "4";
                }
                ViewBag.M_Gallery = list;
            }
            else
            {
                ViewBag.M_Gallery = null;
            }


            return RedirectToAction("Event", "Home");
        }
        public JsonResult Event_Delete(int sid) //  delete here   using procedure 5 
        {
            T_Event Event = new T_Event();
            Event.Eid = sid;
            var data = DB.Event(5, Event).ToList().FirstOrDefault();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Event_Update(int Rid) // update here only go on the id form here ........
        {
            T_Event Event = new T_Event();
            return RedirectToAction("Event", new { sid = Rid });
        }

        #endregion


        #region M_Event


        [HttpGet]
        public ActionResult M_Event()
        {
            M_Event Event_F = new M_Event();
            //if (Session["Id"] == null)
            //{
            //    return RedirectToAction("Login", "Home");
            //}
            if (Request.QueryString["sid"] != null)   // update and fill all value base on id here  using 3 rd storeprocedure
            {
                Event_F.EventId = Convert.ToInt32(Request.QueryString["sid"].ToString());
                Event_F = DB.Event_F(3, Event_F).ToList().FirstOrDefault();
                ViewBag.button = "Update";
            }
            else
            {
                ViewBag.button = "submit";
            }
            var list1 = DB.Event_F(4, Event_F).ToList(); // Show data here...; use procuder 4 for show data 
            if (list1.Count > 0)
            {
                ViewBag.M_Event = list1;

            }
            else
            {
                ViewBag.M_Event = null;
            }
            return View(Event_F);
        }

        [HttpPost]
        [ValidateInput(false)]

        public ActionResult M_Event(M_Event Event_F, string command, HttpPostedFileBase imgs)
        {
            //if (Session["Id"] == null)
            //{
            //    return RedirectToAction("Login", "Home");
            //}
            if (imgs != null)
            {
                string prepath = "~/Content/Uploads";
                string path = "";
                var uploadUrl = Server.MapPath(prepath);
                string extension = System.IO.Path.GetExtension(Request.Files["imgs"].FileName);
                if (extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg" || extension.ToLower() == ".png")
                {
                    if (imgs.ContentLength > 0)
                    {
                        imgs = Request.Files["imgs"];
                        string Name = DateTime.Now.Ticks + "_R" + extension.ToLower().ToString();
                        string pathtosave = prepath + "/" + Name;
                        path = uploadUrl + "/" + Name;
                        Event_F.Images = pathtosave;
                        imgs.SaveAs(path);
                    }
                    else
                    {
                        TempData["Message"] = "Please Upload Gallery !";
                    }
                }
                else
                {
                    TempData["Message"] = "Please Upload Valid File !";
                }
            }
            if (command == "submit")
            {
                procid = 1;

            }
            else if (command == "Update")
            {
                procid = 2;
            }
            var list = DB.Event_F(procid, Event_F).ToList();
            if (list.Count > 0)
            {
                if (list[0].msg == "success")
                {
                    TempData["msg"] = "1";
                }
                else if (list[0].msg == "exists")
                {
                    TempData["msg"] = "2";
                }
                else if (list[0].msg == "update")
                {
                    TempData["msg"] = "3";
                }
                else
                {
                    TempData["msg"] = "4";
                }
                ViewBag.M_Event = list;
            }
            else
            {
                ViewBag.M_Event = null;
            }


            return RedirectToAction("M_Event", "Home");
        }
        public JsonResult E_Delete(int sid) //  delete here   using procedure 5 
        {
            M_Event Event_F = new M_Event();
            Event_F.EventId = sid;
            var data = DB.Event_F(5, Event_F).ToList().FirstOrDefault();
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        public ActionResult E_Update(int Eid) // update here only go on the id form here ........
        {
            M_Event Event_F = new M_Event();
            return RedirectToAction("M_Event", new { sid = Eid });
        }


        #endregion


        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}