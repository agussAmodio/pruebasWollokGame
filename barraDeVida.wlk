class MarcadorVida {
    const property personaje // El personaje al que le mide la vida
    var property position   // Dónde se va a ubicar en la pantalla
    
    // Wollok pide este método para dibujar texto en lugar de una imagen
    method text() {
        return "HP: " + personaje.vida() + " / " + personaje.vidaMaxima()
    }
    
    // Opcional: Podés cambiar el color del texto usando un String en formato Hexadecimal (RGB)
    method textColor() {
        return "FF0000FF" // Rojo brillante en formato ARGB
    }
}