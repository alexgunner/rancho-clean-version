Branch.create! name: "Rancho Viejo La Paz", description: "Rancho", address: "La Paz", city: "La Paz"

#Payment.create(name: "Efectivo")
#Payment.create(name: "Tarjeta")

UserRole.create name: 'Cajero'
UserRole.create name: 'Contador'
UserRole.create name: 'Administrador'
UserRole.create name: 'Socio'
User.create email: "admin@admin.com", password: "adminadmin", password_confirmation: "adminadmin", branch_id: 1, user_role_id: 3
