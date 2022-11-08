using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace TEST_TECNICO.Models;

public partial class TestCrudContext : DbContext
{
    public TestCrudContext()
    {
    }

    public TestCrudContext(DbContextOptions<TestCrudContext> options)
        : base(options)
    {
    }

    public virtual DbSet<TRole> TRoles { get; set; }

    public virtual DbSet<TUser> TUsers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {

        if (!optionsBuilder.IsConfigured)
        {
            IConfigurationRoot configuration = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json")
            .Build();
            var connectionString = configuration.GetConnectionString("DefaultConnectionString");
            optionsBuilder.UseSqlServer(connectionString);
        }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<TRole>(entity =>
        {
            entity.HasKey(e => e.RolId);

            entity.ToTable("tRoles");

            entity.Property(e => e.RolId).HasColumnName("rolId");
            entity.Property(e => e.Rolname)
                .HasMaxLength(50)
                .HasColumnName("rolname");
        });

        modelBuilder.Entity<TUser>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_TblUsers");

            entity.ToTable("tUsers");

            entity.Property(e => e.Id).HasColumnName("ID");

            entity.HasOne(d => d.RolNavigation).WithMany(p => p.TUsers)
                .HasForeignKey(d => d.Rol)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_tUsers_tRoles");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
