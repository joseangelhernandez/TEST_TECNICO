using System;
using System.Collections.Generic;

namespace TEST_TECNICO.Models;

public partial class TUser
{
    public int Id { get; set; }

    public string Nombre { get; set; } = null!;

    public string Apellido { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public int Rol { get; set; }

    public virtual TRole RolNavigation { get; set; } = null!;
}
