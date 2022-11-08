using Azure;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Net;
using System.Security.Claims;
using TEST_TECNICO.Models;
using static System.Net.Mime.MediaTypeNames;

namespace TEST_TECNICO.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly TestCrudContext _testCrudContext;

        public HomeController(ILogger<HomeController> logger, TestCrudContext testCrudContext)
        {
            _logger = logger;
            _testCrudContext = testCrudContext;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Login(string returnUrl="/")
        {
            var checkRol = Request.Cookies["Rol"];
            if (checkRol != null)
            {
                if(checkRol == "1")
                {
                    return LocalRedirect("/GestionUsuarios/Index");

                }else if(checkRol == "2")
                {
                    return LocalRedirect("/Visitante/Index");
                }
            }
            else
            {
                LoginModel loginModel = new LoginModel();
                loginModel.ReturnUrl = returnUrl;
                return View(loginModel);
            }

            return new EmptyResult();
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginModel loginModel)
        {
            var usuario = _testCrudContext.TUsers.Where(x => x.Email == loginModel.Email && x.Password == loginModel.Password).FirstOrDefault();
            if(usuario != null)
            {
                var cookieOptions = new CookieOptions();
                cookieOptions.Path = "/";
                Response.Cookies.Append("Rol", Convert.ToString(usuario.Rol), cookieOptions);

                var claims = new List<Claim>()
                {
                    new Claim(ClaimTypes.NameIdentifier,Convert.ToString(usuario.Id)),
                    new Claim(ClaimTypes.Email,usuario.Email),
                    new Claim(ClaimTypes.Role, Convert.ToString(usuario.Rol)),
                    new Claim("CookieUser","Code")
                };

                var identidad = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                var claimsPrincipal = new ClaimsPrincipal(identidad);
                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, claimsPrincipal, 
                    new AuthenticationProperties() 
                    { 
                        IsPersistent = loginModel.RememberMe,
                        ExpiresUtc = DateTime.UtcNow.AddMinutes(60)
                    });


                if (usuario.Rol == 1)
                {
                    return LocalRedirect("/GestionUsuarios/Index");
                }
                else if(usuario.Rol == 2)
                {
                    return LocalRedirect("/Visitante/Index");
                }

                return new EmptyResult();
            }
            else
            {
                ViewBag.Message = "Sus credenciales están incorrectas, favor verificar.";
                return View(loginModel);

            }
            
        }

        public async Task<IActionResult> Salir()
        {
            Response.Cookies.Delete("Rol");
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return LocalRedirect("/");
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}