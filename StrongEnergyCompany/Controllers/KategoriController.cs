using StrongEnergyCompany.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StrongEnergyCompany.Controllers
{
    public class KategoriController : Controller
    {
        MadeniYağlar_DatabaseEntities d = new MadeniYağlar_DatabaseEntities();

        // GET: Kategori
        public ActionResult Index()
        {
            List<Kategori> liste = d.Kategori.ToList();
            return View(liste);
        }
        public ActionResult Kategoriler(int id = 1)
        {
            Kategori k = d.Kategori.FirstOrDefault(x => x.KategoriKodu == id);
            ViewBag.Urunler = d.Urun.SqlQuery("SELECT * FROM Urun WHERE KategoriKodu = '" + id + "'").ToList();
            return View(k);
        }

    }
}