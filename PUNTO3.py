# Clase Libro
class Libro:
    def __init__(self, titulo, autor, isbn):
        self.titulo = titulo
        self.autor = autor
        self.isbn = isbn
        self.disponible = True

    def __str__(self):
        estado = "Disponible" if self.disponible else "Prestado"
        return f"{self.titulo} de {self.autor} (ISBN: {self.isbn}) - {estado}"


# Clase Miembro
class Miembro:
    def __init__(self, nombre, id_miembro):
        self.nombre = nombre
        self.id_miembro = id_miembro
        self.libros_prestados = []

    def __str__(self):
        return f"{self.nombre} (ID: {self.id_miembro})"


# Clase Biblioteca
class Biblioteca:
    def __init__(self, nombre):
        self.nombre = nombre
        self.libros = []
        self.miembros = []

    def agregar_libro(self, libro):
        self.libros.append(libro)
        print(f"Libro agregado: {libro}")

    def registrar_miembro(self, miembro):
        self.miembros.append(miembro)
        print(f"Miembro registrado: {miembro}")

    def prestar_libro(self, isbn, id_miembro):
        libro = next((l for l in self.libros if l.isbn == isbn and l.disponible), None)
        miembro = next((m for m in self.miembros if m.id_miembro == id_miembro), None)

        if libro and miembro:
            libro.disponible = False
            miembro.libros_prestados.append(libro)
            print(f"Libro prestado: {libro.titulo} a {miembro.nombre}")
        else:
            print("No se pudo prestar el libro (no disponible o miembro no encontrado).")

    def devolver_libro(self, isbn, id_miembro):
        miembro = next((m for m in self.miembros if m.id_miembro == id_miembro), None)
        if miembro:
            libro = next((l for l in miembro.libros_prestados if l.isbn == isbn), None)
            if libro:
                libro.disponible = True
                miembro.libros_prestados.remove(libro)
                print(f"Libro devuelto: {libro.titulo} por {miembro.nombre}")
            else:
                print("Este libro no está prestado a este miembro.")
        else:
            print("Miembro no encontrado.")


# Ejemplo de uso
if __name__ == "__main__":
    biblioteca = Biblioteca("Biblioteca Central")

    # Agregar libros
    libro1 = Libro("1984", "George Orwell", "12345")
    libro2 = Libro("Cien años de soledad", "Gabriel García Márquez", "67890")
    biblioteca.agregar_libro(libro1)
    biblioteca.agregar_libro(libro2)

    # Registrar miembros
    miembro1 = Miembro("Ana López", "M001")
    biblioteca.registrar_miembro(miembro1)

    # Prestar y devolver libros
    biblioteca.prestar_libro("12345", "M001")
    biblioteca.devolver_libro("12345", "M001")