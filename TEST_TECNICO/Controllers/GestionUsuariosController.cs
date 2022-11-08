using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using TEST_TECNICO.Models;

namespace TEST_TECNICO.Controllers
{
    [Authorize(Roles = "1")]
    public class GestionUsuariosController : Controller
    {
        private readonly TestCrudContext _context;

        public GestionUsuariosController(TestCrudContext context)
        {
            _context = context;
        }

        // GET: GestionUsuarios
        public async Task<IActionResult> Index()
        {
            var testCrudContext = _context.TUsers.Include(t => t.RolNavigation);
            return View(await testCrudContext.ToListAsync());
        }

        // GET: GestionUsuarios/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.TUsers == null)
            {
                return NotFound();
            }

            var tUser = await _context.TUsers
                .Include(t => t.RolNavigation)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (tUser == null)
            {
                return NotFound();
            }

            return View(tUser);
        }

        // GET: GestionUsuarios/Create
        public IActionResult Create()
        {
            ViewData["Rol"] = new SelectList(_context.TRoles, "RolId", "Rolname");
            return View();
        }

        // POST: GestionUsuarios/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Nombre,Apellido,Email,Password,Rol")] TUser tUser)
        {

            _context.Add(tUser);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
            ViewData["Rol"] = new SelectList(_context.TRoles, "RolId", "Rolname", tUser.Rol);
            return View(tUser);
        }

        // GET: GestionUsuarios/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.TUsers == null)
            {
                return NotFound();
            }

            var tUser = await _context.TUsers.FindAsync(id);
            if (tUser == null)
            {
                return NotFound();
            }
            ViewData["Rol"] = new SelectList(_context.TRoles, "RolId", "Rolname", tUser.Rol);
            return View(tUser);
        }

        // POST: GestionUsuarios/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id, Nombre,Apellido,Email,Password,Rol")] TUser tUser)
        {
            if (id != tUser.Id)
            {
                return NotFound();
            }


            try
            {
                _context.Update(tUser);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TUserExists(tUser.Id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return RedirectToAction(nameof(Index));
            ViewData["Rol"] = new SelectList(_context.TRoles, "RolId", "Rolname", tUser.Rol);
            return View(tUser);
        }

        // GET: GestionUsuarios/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.TUsers == null)
            {
                return NotFound();
            }

            var tUser = await _context.TUsers
                .Include(t => t.RolNavigation)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (tUser == null)
            {
                return NotFound();
            }

            return View(tUser);
        }

        // POST: GestionUsuarios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.TUsers == null)
            {
                return Problem("Entity set 'TestCrudContext.TUsers'  is null.");
            }
            var tUser = await _context.TUsers.FindAsync(id);
            if (tUser != null)
            {
                _context.TUsers.Remove(tUser);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool TUserExists(int id)
        {
          return _context.TUsers.Any(e => e.Id == id);
        }
    }
}
