using System;
using System.Collections.Generic;

namespace TEST_TECNICO.Models;

public partial class TRole
{
    public int RolId { get; set; }

    public string Rolname { get; set; } = null!;

    public virtual ICollection<TUser> TUsers { get; } = new List<TUser>();
}
