using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace TEST_TECNICO.Controllers
{
    [Authorize(Roles ="2")]
    public class VisitanteController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
