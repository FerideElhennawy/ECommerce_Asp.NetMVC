using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using StrongEnergyCompany.Models;
using StrongEnergyCompany.Security;

namespace StrongEnergyCompany.Controllers
{
    [MyAuthorization(Roles = "A,P")]
    public class UrunController : Controller
    {
        MadeniYağlar_DatabaseEntities d = new MadeniYağlar_DatabaseEntities();

        // GET: Urun
        public ActionResult Index()
        {
            List<Urun> liste= d.Urun.ToList();
            return View(liste);
        }

        [HttpGet]
        public ActionResult UrunSil(string id)
        {
            Urun u = d.Urun.FirstOrDefault(x => x.UrunKodu == id);

            return View(u);
        }

        [HttpPost]

        public ActionResult UrunSil(Urun u)
        {
            Urun urun = d.Urun.FirstOrDefault(x => x.UrunKodu == u.UrunKodu);

            d.Urun.Remove(urun);
            d.SaveChanges();

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult UrunEkle()
        {
            ViewBag.Kategori = d.Kategori.ToList();
            Urun u = new Urun();
            return View(u);
        }

        [HttpPost]
        public ActionResult UrunEkle(Urun u)
        {
            Urun urun = d.Urun.FirstOrDefault(x => x.UrunKodu == u.UrunKodu);
            if(urun == null)
            {
                d.Urun.Add(u);

            }
            else
            {
                urun.UrunKodu = u.UrunKodu;
                urun.Fiyat = u.Fiyat;
                urun.StokMiktari = u.StokMiktari;
                urun.KategoriKodu = u.KategoriKodu;
                urun.Detaylar = u.Detaylar;
                urun.Özellikler = u.Özellikler;
            }
            d.SaveChanges();

            return RedirectToAction("Index");
        }
        public ActionResult UrunGuncelle(string id)
        {
            Urun u = d.Urun.FirstOrDefault(x => x.UrunKodu == id);

            return View("UrunEkle", u);
        }
    }
}