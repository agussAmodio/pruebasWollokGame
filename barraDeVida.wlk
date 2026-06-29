class MarcadorVida {
    const property personaje  
    var property position     

    method image() = "marcadorDeVida" + self.porcentajeDeVidaRedondeado() + ".png"

    method porcentajeDeVidaRedondeado() {
        if (personaje == null) return 100
        return ((self.porcentajeExacto() / 10).round() * 10).min(100).max(0)
    }

    method porcentajeExacto() = (personaje.vida() * 100) / personaje.vidaMaxima()

    method text() = personaje.vida().toString() + " / " + personaje.vidaMaxima().toString()

    method textColor() = "FF0000"
}