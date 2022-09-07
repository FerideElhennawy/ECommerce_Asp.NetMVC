using StrongEnergyCompany.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StrongEnergyCompany.Controllers
{
    public class SiparisController : Controller
    {
        MadeniYağlar_DatabaseEntities d = new MadeniYağlar_DatabaseEntities();
        // GET: Siparis
        public ActionResult Index(Musteri M)
        {
            //There is no access to SepetKodu from Musteri table>>> Make SepetKodu FK of Musteri table!!
            //List<Siparis> siparisler = d.Siparis.SqlQuery("SELECT * FROM Siparis WHERE SepetKodu = '" + M.SepetKodu + "'").ToList();
            return View();
        }
    }
}