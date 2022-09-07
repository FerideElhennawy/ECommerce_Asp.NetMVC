using StrongEnergyCompany.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace StrongEnergyCompany.Controllers
{
    public class HomeController : Controller
    {
        MadeniYağlar_DatabaseEntities d = new MadeniYağlar_DatabaseEntities();
        public ActionResult Index()
        {
            return View();
        }

        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }
        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(User U)
        {
            User user = d.User.FirstOrDefault(x => x.UserID == U.UserID && x.Sifre == U.Sifre);
            if (user != null)
            {
                FormsAuthentication.SetAuthCookie(user.UserID, false);
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.mesaj = "Username or passowrd is wrong.. Please try again";
                return View();
            }
        }
        public ActionResult Logout()
        {
            string name = FormsAuthentication.FormsCookieName;
            HttpCookie authcookie = HttpContext.Request.Cookies[name];
            FormsAuthenticationTicket t = FormsAuthentication.Decrypt(authcookie.Value);
            string tname = t.Name;

            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }

        [AllowAnonymous]
        public ActionResult Signup()
        {
            ViewBag.SatisElemani = d.SatisElemani.ToList();
            ViewBag.User = d.User.ToList();
            ViewBag.Ulke = d.Ulke.ToList();
            ViewBag.Il = d.Il.ToList();
            return View();
            
        }
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Signup(User U, Musteri M, Il I, Sepet S)
        {
            User user = d.User.FirstOrDefault(x => x.UserID == U.UserID);
            if (user != null )
            {
                ViewBag.Mesaj = "User name most be unique, please try somethin else! ";
                return View();
            }
            else
            {
                d.User.Add(U);
            }

            d.Sepet.Add(S);
            d.Musteri.Add(M);
            d.Il.Add(I);
            d.SaveChanges();
            return RedirectToAction("Login");
        }
        public ActionResult Error()
        {
            ViewBag.Message = "Your application description page.";

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