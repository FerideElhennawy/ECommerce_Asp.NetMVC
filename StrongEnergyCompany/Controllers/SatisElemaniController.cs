using StrongEnergyCompany.Models;
using StrongEnergyCompany.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace StrongEnergyCompany.Controllers
{
    public class SatisElemaniController : Controller
    {
        MadeniYağlar_DatabaseEntities d = new MadeniYağlar_DatabaseEntities();

        // GET: SatisElemani
        [MyAuthorization(Roles = "A")]
        public ActionResult Index()
        {
            ViewBag.Elemanlar = d.SatisElemani.ToList();
            return View();
        }
    }
}