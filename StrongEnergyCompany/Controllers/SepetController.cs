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
    public class SepetController : Controller
    {
        MadeniYağlar_DatabaseEntities d = new MadeniYağlar_DatabaseEntities();
        // GET: Sepet
        [MyAuthorization(Roles = "C")]
        public ActionResult Index(String id)
        {
            Musteri M = d.Musteri.FirstOrDefault(x => x.UserID == id);
            
            List<Sepet> t = d.Sepet.Where(x=>x.SepetKodu ==M.SepetKodu).ToList();

            List<Urun> u = new List<Urun>();
            foreach(Sepet item in t)
           {
                u = item.Urun.ToList();
                //u[0]
           }
            
            return View(u);
        }

        public ActionResult SepeteEkle(Urun u, string id)
        {
            //ViewBag.Urunler = d.Urun.FirstOrDefault(x => x.UrunKodu == u.UrunKodu);
            //d.Sepet.Add(u);
            //d.SaveChanges();

            //.Sepet[M.SepetKodu].Urun.Add(U);
            Musteri M = d.Musteri.FirstOrDefault(x => x.UserID == id);
            ViewBag.t = d.Sepet.Where(x => x.SepetKodu == M.SepetKodu).ToList();

            return RedirectToAction("SepeteEkle", u);
        }

        [HttpPost]
        public ActionResult SepeteEkle(Urun urun)
        {
            //ViewBag.Urunler = d.Urun.FirstOrDefault(x => x.UrunKodu == u.UrunKodu);
            //d.Sepet.Add(u);
            //d.SaveChanges();

            //List<Sepet> t = d.Sepet.Where(x => x.SepetKodu == t.).ToList();


            List<Urun> u = new List<Urun>();
            foreach (Sepet item in ViewBag.t)
            {
                foreach (Urun i in u)
                {
                    if (urun.UrunKodu == i.UrunKodu)
                    {
                        item.Urun.Add(i);
                    }

                }
            }


            return RedirectToAction("Index");

        }
    }
}