using Microsoft.AspNetCore.Mvc;

namespace TEST_TECNICO.Controllers
{
    public class AccountController : Controller
    {
        public IActionResult AccessDenied()
        {
            return View();
        }
    }
}
