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
    [MyAuthorization(Roles = "A,P")]

    public class MusteriController : Controller
    {
        MadeniYağlar_DatabaseEntities d = new MadeniYağlar_DatabaseEntities();
        // GET: Musteri
        public ActionResult Index()
        {
            List<Musteri> Musteriler = d.Musteri.ToList();
            ViewBag.SatisElemani = d.SatisElemani.ToList();
            return View(Musteriler);
        }

        public ActionResult MusteriEkle()
        {
            ViewBag.SatisElemani = d.SatisElemani.ToList();
            ViewBag.User = d.User.ToList();
            ViewBag.Ulke = d.Ulke.ToList();
            ViewBag.Il = d.Il.ToList();
            return View();
        }
        [HttpPost]
        public ActionResult MusteriEkle( User u, Musteri m, Sepet s)
        {
            d.Sepet.Add(s);
            d.User.Add(u);
            d.Musteri.Add(m);
            d.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}