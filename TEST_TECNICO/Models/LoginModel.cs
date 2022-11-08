using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace TEST_TECNICO.Models
{
    public class LoginModel
    {
        [Required]
        [Display(Name ="Username")]
        public string Email { get; set; }
        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        public bool RememberMe { get; set; }
        public string ReturnUrl { get; set; }

    }
}
