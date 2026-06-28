class Personaje{
    const property nombre
    var property vidaMaxima
    var property vida = vidaMaxima
    var property fuerza
    var property defensa

    
   
   // atributos requeridos por wollok game
   var property position = null
   var property image = null
   var property estaDefendiendose = false
    

    method atacar(unEnemigo) {
        unEnemigo.recibirDaño(fuerza)
    }

    method recibirDaño(cantidadDeDaño) {
        vida = (vida - cantidadDeDaño).max(0)
    }

    method estaVivo() {
        return vida > 0
    }

    method defenderse() {
        estaDefendiendose = true
    }
    
    method recibirCuracion(cantidad) {
        vida = (vida + cantidad).min(self.vidaMaxima())
    }
}